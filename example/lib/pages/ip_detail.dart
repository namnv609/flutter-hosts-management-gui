import 'package:example_flutter/models/ip_domain_model.dart';
import 'package:example_flutter/pages/forms/domain_form.dart';
import 'package:example_flutter/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class IPDetail extends StatelessWidget {
  static const routeName = '/ip_detail';

  @override
  Widget build(BuildContext context) {
    Map<String, String> ipDetailArgs = ModalRoute.of(context).settings.arguments;
    String ipAddr = ipDetailArgs['ip_addr'];

    return ScopedModel(
      model: HomePage.ipDomainModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Danh sách domain của IP $ipAddr'),
        ),
        body: ScopedModelDescendant<IPDomainModel>(
          builder: (context, child, model) {
            List<String> domainsOfIP = model.domainsOfIP(ipAddr);

            return Container(
              child: ListView.builder(
                itemCount: domainsOfIP?.length ?? 0,
                itemBuilder: (context, idx) {
                  String domainAddr = domainsOfIP[idx];

                  return Card(
                    child: ListTile(
                      title: Text(domainAddr),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.edit),
                            tooltip: 'Sửa domain',
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            tooltip: 'Xóa domain',
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              child: IconButton(
                icon: Icon(Icons.add),
                tooltip: 'Thêm mới domain',
                onPressed: () {},
              )
            );
          },
        ),
      ),
    );
  }

  _addNewDomainNameAddress(BuildContext context) async {
    final newDomainName = await Navigator.pushNamed(
      context,
      DomainForm.routeName
    ) as String;
  }
}