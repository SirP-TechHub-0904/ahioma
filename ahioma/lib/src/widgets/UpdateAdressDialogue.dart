import 'package:ahioma/src/models/product.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:ahioma/config/ui_icons.dart';
import 'package:ahioma/src/models/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:ahioma/src/services/updateProfile_service.dart';

class UpdateAddressDialog extends StatefulWidget {
  User user;
  String uId;
  Address address;
  VoidCallback onChanged;

  UpdateAddressDialog({Key key, this.user, this.onChanged,this.uId,this.address}) : super(key: key);

  @override
  _UpdateAddressDialogState createState() =>
      _UpdateAddressDialogState(this.user);
}

class _UpdateAddressDialogState extends State<UpdateAddressDialog> {
  _UpdateAddressDialogState(User _user) {
    this._user = _user;
  }
  User _user;
  final ValueNotifier<int> loadig = ValueNotifier<int>(0);
  GlobalKey<FormState> _AddressFormKey = new GlobalKey<FormState>();
  final street = TextEditingController();
  final lga = TextEditingController();
  final state = TextEditingController();
  String update = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    street.dispose();
    lga.dispose();
    state.dispose();
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
                    Icon(Icons.add_location),
                    SizedBox(width: 10),
                    Text(
                      'Update address',
                      style: Theme.of(context).textTheme.body2,
                    )
                  ],
                ),
                children: <Widget>[
                  Form(
                    key: _AddressFormKey,
                    child: Column(
                      children: <Widget>[
                        new TextFormField(
                          controller: street,
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.text,
                          decoration: getInputDecoration(
                              hintText: '', labelText: 'Street'),
                          validator: (input) =>
                          input.isEmpty ? 'Street can\'t be empty' : null,
                          onSaved: (input) => widget.user.firstName = input,
                        ),
                        new TextFormField(
                          controller: lga,
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.text,
                          decoration: getInputDecoration(
                              hintText: '', labelText: 'Local Government Area'),
                          validator: (input) => input.isEmpty
                              ? 'Local Government can\'t be empty'
                              : null,
                          onSaved: (input) => widget.user.firstName = input,
                        ),
                        new TextFormField(
                          controller: state,
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.text,
                          decoration: getInputDecoration(
                              hintText: '', labelText: 'State'),
                          validator: (input) =>
                          input.isEmpty ? 'State can\'t be empty' : null,
                          onSaved: (input) => widget.user.firstName = input,
                        ),
                        // FormField<String>(
                        //   builder: (FormFieldState<String> state) {
                        //     return DropdownButtonFormField<String>(
                        //       decoration: getInputDecoration(hintText: 'Female', labelText: 'Gender'),
                        //       hint: Text("Select Device"),
                        //       value: widget.user.gender,
                        //       onChanged: (input) {
                        //         setState(() {
                        //           widget.user.gender = input;
                        //           widget.onChanged();
                        //         });
                        //       },
                        //       onSaved: (input) => widget.user.gender = input,
                        //       items: [
                        //         new DropdownMenuItem(value: 'Male', child: Text('Male')),
                        //         new DropdownMenuItem(value: 'Female', child: Text('Female')),
                        //       ],
                        //     );
                        //   },
                        // ),
                        // new TextFormField(
                        //   controller: nok,
                        //   style: TextStyle(color: Theme.of(context).hintColor),
                        //   keyboardType: TextInputType.text,
                        //   decoration: getInputDecoration(
                        //       hintText: 'John Doe', labelText: 'Next of kin'),
                        //   validator: (input) => input.trim().length < 3
                        //       ? 'Not a valid full name'
                        //       : null,
                        //   onSaved: (input) => widget.user.firstName = input,
                        // ),
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
                    child: Container(
                      child: ValueListenableBuilder(builder:
                          (BuildContext context, int value, Widget child) {
                        return Text('${update}');
                      },valueListenable: loadig,
                      ),
                    ),
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
    if (_AddressFormKey.currentState.validate()) {
      _AddressFormKey.currentState.save();

      update = 'Updataing address...';
      loadig.value+=1;
      print(widget.uId);
      UpdateAddress updat = UpdateAddress(
          address: street.text, state: state.text, localGovernment: lga.text);
      await updat.addAddress(widget.uId,widget.address.aId);
      if (updat.code == '200') {
        update = 'SUCCESSFUL';
        loadig.value+=1;
        Navigator.pop(context);
      } else {
        update = 'Unsuccessful try again';
        loadig.value+=1;
      }
    }
  }
}
