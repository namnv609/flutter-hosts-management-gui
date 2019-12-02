import 'package:example_flutter/models/ip_domain_model.dart';
import 'package:example_flutter/pages/forms/ip_form.dart';
import 'package:example_flutter/pages/ip_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/';
  static IPDomainModel ipDomainModel = IPDomainModel();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    HomePage.ipDomainModel.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<IPDomainModel>(
      model: HomePage.ipDomainModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Danh sách IP'),
        ),
        body: ScopedModelDescendant<IPDomainModel>(
          builder: (context, child, model) {
            List<String> hostsIPs = model.hostsIPs;

            return Container(
              child: model.isLoadingData ? _showLoadingIndicator() : _listViewBuilder(hostsIPs)
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Builder(
          builder: (context) {
            return Row(
              children: <Widget>[
                Spacer(flex: 1,),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    child: Icon(Icons.add),
                    tooltip: 'Thêm mới IP',
                    onPressed: () => _addNewIPAddress(context),
                    heroTag: null,
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: FloatingActionButton(
                    child: Icon(Icons.save),
                    tooltip: 'Lưu',
                    onPressed: () {},
                    heroTag: null,
                  )
                )
              ],
            );
          }
        ),
      ),
    );
  }

  Widget _showLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _listViewBuilder(List<String> hostsIPs) {
    return ListView.builder(
      itemCount: hostsIPs?.length ?? 0,
      itemBuilder: (context, idx) {
        String ipAddr = hostsIPs[idx];

        return Card(
          child: ListTile(
            title: Text(ipAddr),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _editIPAddress(context, ipAddr),
                  tooltip: 'Sửa IP',
                ),
                IconButton(
                  icon: Icon(Icons.view_list),
                  onPressed: () => _viewDomainsOfIP(context, ipAddr),
                  tooltip: 'Xem domain',
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  tooltip: 'Xóa IP',
                  onPressed: () {},
                )
              ],
            )
          ),
        );
      },
    );
  }

  void _addNewIPAddress(BuildContext context) async {
    final newIPAddr = await Navigator.pushNamed(
      context,
      IPForm.routeName
    ) as String;

    if (newIPAddr != null && newIPAddr.isNotEmpty) {
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('Thêm mới IP $newIPAddr thành công!')));
    }
  }

  void _editIPAddress(BuildContext context, String ipAddr) async {
    final newIPAddr = await Navigator.pushNamed(
      context,
      IPForm.routeName,
      arguments: {
        'ip_addr': ipAddr
      }
    ) as String;

    if (newIPAddr != null && newIPAddr.isNotEmpty) {
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('Cập nhật IP $ipAddr -> $newIPAddr thành công')));
    }
  }

  void _viewDomainsOfIP(BuildContext context, String ipAddr) {
    Navigator.pushNamed(
      context,
      IPDetail.routeName,
      arguments: {
        'ip_addr': ipAddr
      }
    );
  }
}