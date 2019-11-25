import 'dart:io';

import 'package:example_flutter/args/ip_details_args.dart';
import 'package:example_flutter/pages/forms/ip_form.dart';
import 'package:example_flutter/pages/ip_detail.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/';

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<String> hostsLines = [];
  List<String> hostsIPs = [];
  Map<String, List<String>> ipDomainMap = {};

  void parseHostsContent() async {
    try {
      File hostsFile = File('/etc/hosts');
      String hostsFileContent = await hostsFile.readAsString();

      hostsFileContent.split('\n').forEach((hostsFileLine) {
        hostsFileLine = hostsFileLine.trim();
        RegExp commentLineRegExp = RegExp(r'^\#.+$');

        if (!commentLineRegExp.hasMatch(hostsFileLine) &&
            hostsFileLine != r'\n' &&
            hostsFileLine != null &&
            !hostsFileLine.isEmpty) {
          hostsLines.add(hostsFileLine.replaceAll(r'\s+', ' ').trim());
        }
      });

      hostsLines.forEach((hostsLine) {
        List<String> hostInfo = hostsLine.split(' ');
        String ipAddr = hostInfo?.first;
        List<String> domainObj = ipDomainMap[ipAddr] ?? [];

        hostInfo?.skip(1)?.forEach((domain) {
          domainObj.add(domain);
        });

        ipDomainMap[ipAddr] = domainObj;
        hostsIPs.add(ipAddr);
      });

      setState(() {
        hostsIPs = hostsIPs.toSet().toList();
        ipDomainMap = ipDomainMap;
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    parseHostsContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách IP'),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: hostsIPs.length,
          itemBuilder: (BuildContext context, int idx) {
            String ipAddr = hostsIPs[idx];
            List<String> ipDomains = ipDomainMap[ipAddr];

            return Card(
              child: ListTile(
                title: Text(ipAddr),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    IPDetail.routeName,
                    arguments: IPDetailArgs(ipAddr, ipDomains)
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton(
            child: Icon(Icons.add),
            tooltip: 'Thêm mới IP',
            onPressed: () => _addNewIPAddress(context),
          );
        }
      ),
    );
  }
  _addNewIPAddress(BuildContext context) async {
    final newIPAddr = await Navigator.pushNamed(
      context,
      IPForm.routeName
    ) as String;

    if (newIPAddr != null && newIPAddr.isNotEmpty) {
      hostsIPs.add(newIPAddr);
      setState(() {
        hostsIPs = hostsIPs;
      });

      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('Thêm mới IP $newIPAddr thành công!')));
    }
  }
}
