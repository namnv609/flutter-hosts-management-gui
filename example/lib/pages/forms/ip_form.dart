import 'package:example_flutter/models/ip_domain_model.dart';
import 'package:example_flutter/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class IPForm extends StatefulWidget {
  static const String routeName = 'ip-form';

  @override
  _IPFormState createState() => _IPFormState();
}

class _IPFormState extends State<IPForm> {
  final _ipFormKey = GlobalKey<FormState>();
  String _ipAddr;

  @override
  Widget build(BuildContext context) {
    Map<String, String> args = ModalRoute.of(context).settings.arguments;
    _ipAddr = args != null ? args['ip_addr'] : null;

    String pageTitle = _ipAddr != null ? 'Sửa IP $_ipAddr' : 'Thêm mới IP';

    return ScopedModel<IPDomainModel> (
      model: HomePage.ipDomainModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text(pageTitle),
        ),
        body: Form(
          key: _ipFormKey,
          child: Column(
            children: <Widget>[
              ListTile(
                title: TextFormField(
                  initialValue: _ipAddr,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Vui lòng nhập địa chỉ IP';
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Địa chỉ IP'
                  ),
                  onSaved: (String value) => _ipAddr = value
                ),
              ),
              ScopedModelDescendant<IPDomainModel>(
                builder: (context, child, model) {
                  return RaisedButton(
                    child: Text('Lưu'),
                    onPressed: () {
                      if (_ipFormKey.currentState.validate()) {
                        _ipFormKey.currentState.save();
                        model.addIPDomain(_ipAddr);
                        Navigator.pop(context, _ipAddr);
                      }
                    },
                  );
                },
              )
            ],
          ),
        )
      ),
    );
  }
}