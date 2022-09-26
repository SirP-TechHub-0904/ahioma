import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:ahioma/config/ui_icons.dart';
import 'package:ahioma/src/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart' show DateFormat;
import 'package:ahioma/src/services/updateProfile_service.dart';
import 'package:ahioma/src/services/ahia_pay_services.dart';

class BankDialog extends StatefulWidget {
  User user;
  List<Bank> bankk;
  VoidCallback onChanged;

  BankDialog({Key key, this.user, this.onChanged,this.bankk}) : super(key: key);

  @override
  _BankDialogState createState() => _BankDialogState(this.user);
}

class _BankDialogState extends State<BankDialog> {
  _BankDialogState(User _user) {
    this._user = _user;
  }
  User _user;
  final ValueNotifier<int> loadig = ValueNotifier<int>(0);
  final ValueNotifier<int> load = ValueNotifier<int>(0);
  String update='';
  GlobalKey<FormState> _BankFormKey = new GlobalKey<FormState>();
  final acctNumber = TextEditingController();
  String acctName;
  String acctNumer;
  String bankName;
  Bank dropdownValue;
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    acctNumber.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                titlePadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                title: Row(
                  children: <Widget>[
                    Icon(UiIcons.user_1),
                    SizedBox(width: 10),
                    Text(
                      'Update Bank',
                      style: Theme.of(context).textTheme.body2,
                    )
                  ],
                ),
                children: <Widget>[
                  Form(
                    key: _BankFormKey,
                    child: Column(
                      children: <Widget>[
                        ValueListenableBuilder(builder:
                            (BuildContext context, int value, Widget child) {
                          return  DropdownButton<Bank>(
                            value: dropdownValue,
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            isExpanded: true,
                            style: TextStyle(color: Theme.of(context).hintColor),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (Bank newValue) {

                                dropdownValue = newValue;
                                load.value += 1;

                            },
                            items: widget.bankk.map<DropdownMenuItem<Bank>>((Bank value) {
                              return DropdownMenuItem<Bank>(
                                value: value,
                                child: Text('${value.bankName}',
                                    overflow: TextOverflow.visible,
                                    softWrap: true,
                                    style: TextStyle(color: Theme.of(context).hintColor)),
                              );
                            }).toList(),
                          );
                        },valueListenable: load),
                        new TextFormField(
                          controller: acctNumber,
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.number,
                          decoration: getInputDecoration(
                              hintText: '', labelText: 'Account Number'),
                          validator: (input) => input.isEmpty
                              ? 'Account number can\'t be empty'
                              : null,
                          onSaved: (input) => widget.user.firstName = input,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                      ),
                      MaterialButton(
                        onPressed: _submit,
                        child: Text(
                          'Save',
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.end,
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: ValueListenableBuilder(builder:
                        (BuildContext context, int value, Widget child) {
                      return Text('$update');
                    },valueListenable: loadig),
                  ),
                  SizedBox(height: 10),
                ],
              );
            });
      },
      child: Text(
        "Edit",
        style: Theme.of(context).textTheme.body1,
      ),
    );
  }

  InputDecoration getInputDecoration({String hintText, String labelText}) {
    return new InputDecoration(
      hintText: hintText,
      labelText: labelText,
      hintStyle: Theme.of(context).textTheme.body1.merge(
            TextStyle(color: Theme.of(context).focusColor),
          ),
      enabledBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).hintColor.withOpacity(0.2))),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).hintColor)),
      hasFloatingPlaceholder: true,
      labelStyle: Theme.of(context).textTheme.body1.merge(
            TextStyle(color: Theme.of(context).hintColor),
          ),
    );
  }

  void _submit() async {
    if (_BankFormKey.currentState.validate()) {
      _BankFormKey.currentState.save();
      update="Saving...";
      loadig.value += 1;
      print(dropdownValue.code);
      Response response = await put(
          Uri.parse('http://api.ahioma.ng/api/Transaction/GetBankInformationByCode?bankcode=${dropdownValue.code}&accountnumber=${acctNumber.text}'),
          headers: {"accept": "application/json"});
      var data = jsonDecode(response.body);
      acctName = data['accountName'];
      acctNumer = data['accountNumber'];
      bankName = data['bank'];
      if (response.statusCode == 200) {
        print(widget.user.id);
        await put(
            Uri.parse('http://api.ahioma.ng/api/Transaction/ValidateBankInfo?uid=${widget.user.id}&bankName=$bankName&accountName=$acctName&accountNumber=$acctNumer'),
            headers: {"accept": "application/json"});
        Navigator.pop(context);
      } else {}
    }
  }
}
