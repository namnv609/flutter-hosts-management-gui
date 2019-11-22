import 'package:example_flutter/args/ip_details_args.dart';
import 'package:flutter/material.dart';

class IPDetail extends StatelessWidget {
  static const routeName = '/ip_detail';

  @override
  Widget build(BuildContext context) {
    IPDetailArgs ipDetailArgs = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Domains of ${ipDetailArgs.ipAddr}'),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: ipDetailArgs.ipDomains?.length ?? 0,
          itemBuilder: (BuildContext context, idx) {
            return Card(
              child: ListTile(
                title: Text(ipDetailArgs.ipDomains[idx]),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.redAccent,
                  tooltip: 'Xóa domain',
                  onPressed: () => print('Deleted')
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Thêm mới domain',
        onPressed: () => print('Added'),
      ),
    );
  }
}