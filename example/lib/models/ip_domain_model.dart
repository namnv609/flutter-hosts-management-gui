import 'dart:io';

import 'package:scoped_model/scoped_model.dart';

class IPDomainModel extends Model {
  Map<String, List<String>> _ipDomainMap = {};
  bool _isLoadingData = true;

  bool get isLoadingData => _isLoadingData;

  List<String> get hostsIPs => _ipDomainMap.keys.toList();

  Future loadData() async {
    _isLoadingData = true;

    File hostsFile = File('/etc/hosts');
    String hostsFileContent = await hostsFile.readAsString();
    List<String> hostsLines = [];

    hostsFileContent.split('\n').forEach((hostsFileLine) {
      hostsFileLine = hostsFileLine.trim();
      RegExp commentLineRegExp = RegExp(r'^\#.+$');

      if (!commentLineRegExp.hasMatch(hostsFileLine) && hostsFileLine != r'\n' && hostsFileLine != null && hostsFileLine.isNotEmpty) {
        hostsLines.add(hostsFileLine.replaceAll(r'\s+', ' ').trim());
      }
    });

    hostsLines.forEach((hostsLine) {
      List<String> hostsInfo = hostsLine.split(' ');
      String ipAddr = hostsInfo?.first;
      List<String> ipDomains = _ipDomainMap[ipAddr] ?? [];

      hostsInfo?.skip(1)?.forEach((domain) {
        ipDomains.add(domain);
      });

      _ipDomainMap[ipAddr] = ipDomains;
    });

    _isLoadingData = false;

    notifyListeners();
  }

  void addIPDomain(String ipAddr) {
    List<String> ipDomains = domainsOfIP(ipAddr);
    if (ipDomains.isEmpty) {
      _ipDomainMap[ipAddr] = [];
      notifyListeners();
    }
  }

  List<String> domainsOfIP(String ipAddr) => _ipDomainMap[ipAddr] ?? [];
}