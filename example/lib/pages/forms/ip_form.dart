import 'package:flutter/material.dart';

class IPForm extends StatefulWidget {
  static const String routeName = '/ip_form';

  @override
  IPFormState createState() => IPFormState();
}

class IPFormState extends State<IPForm> {
  final _ipFormKey = GlobalKey<FormState>();
  String _ipAddr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm mới IP'),
      ),
      body: Form(
        key: _ipFormKey,
        child: Column(
          children: <Widget>[
            ListTile(
              title: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Vui lòng nhập địa chỉ IP';
                  }

                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Địa chỉ IP'
                ),
                onSaved: (String val) {
                  _ipAddr = val;
                },
              ),
            ),
            RaisedButton(
              child: Text('Lưu'),
              onPressed: () {
                if (_ipFormKey.currentState.validate()) {
                  _ipFormKey.currentState.save();
                  Navigator.pop(context, _ipAddr);
                }
              },
            )
          ],
        )
      ),
    );
  }
}