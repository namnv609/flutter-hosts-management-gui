import 'package:flutter/material.dart';

class DomainForm extends StatefulWidget {
  static const String routeName = '/domain_form';

  @override
  State<StatefulWidget> createState() => DomainFormState();
}

class DomainFormState extends State<DomainForm> {
  final _domainFormKey = GlobalKey<FormState>();
  String _domainName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm mới tên miền'),
      ),
      body: Form(
        key: _domainFormKey,
        child: Column(
          children: <Widget>[
            ListTile(
              title: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Vui lòng nhập tên miền cho IP';
                  }

                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Tên miền'
                ),
                onSaved: (value) {
                  _domainName = value;
                },
              ),
            ),
            RaisedButton(
              child: Text('Lưu'),
              onPressed: () {
                if (_domainFormKey.currentState.validate()) {
                  _domainFormKey.currentState.save();
                  Navigator.pop(context, _domainName);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}