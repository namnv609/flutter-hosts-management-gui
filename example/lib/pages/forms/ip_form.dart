import 'package:flutter/material.dart';

class IPForm extends StatefulWidget {
  static const String routeName = '/ip_form';

  @override
  IPFormState createState() => IPFormState();
}

class IPFormState extends State<IPForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IP Form'),
      ),
      body: Form(
        key: _formKey,
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
              ),
            ),
            RaisedButton(
              child: Text('Lưu'),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Navigator.pop(context);
                }
              },
            )
          ],
        )
      ),
    );
  }
}