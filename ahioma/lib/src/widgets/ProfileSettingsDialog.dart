import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:ahioma/config/ui_icons.dart';
import 'package:ahioma/src/models/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:ahioma/src/services/updateProfile_service.dart';

class ProfileSettingsDialog extends StatefulWidget {
  User user;
  VoidCallback onChanged;

  ProfileSettingsDialog({Key key, this.user, this.onChanged}) : super(key: key);

  @override
  _ProfileSettingsDialogState createState() =>
      _ProfileSettingsDialogState(this.user);
}

class _ProfileSettingsDialogState extends State<ProfileSettingsDialog> {
  _ProfileSettingsDialogState(User _user) {
    this._user = _user;
  }
  User _user;
  GlobalKey<FormState> _profileSettingsFormKey = new GlobalKey<FormState>();
  var firstName;
  var lastName;
  var otherName;
  var nok;
  var nokPhoneNo;
  var dob;
  var secQuestion;
  var secAnswer;
  DateTime pickedDate;
  String update = '';

  _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 100),
      initialDate: DateTime.parse(dob),
    );
    if (date != null)
      setState(() {
        pickedDate = date;
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    firstName = TextEditingController(text: widget.user.firstName);
    lastName = TextEditingController(text: widget.user.lastName);
    otherName = TextEditingController(text: widget.user.otherNames);
    nok = TextEditingController(text: widget.user.NOK);
    nokPhoneNo = TextEditingController(text: widget.user.nokNumber);
    dob = TextEditingController(text: widget.user.dateOfBirth.toString());
    secQuestion = TextEditingController(text: widget.user.secQuestion);
    secAnswer = TextEditingController(text: widget.user.secAnswer);
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    firstName.dispose();
    lastName.dispose();
    otherName.dispose();
    nok.dispose();
    nokPhoneNo.dispose();
    dob.dispose();
    secQuestion.dispose();
    secAnswer.dispose();
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
                      'Profile Settings',
                      style: Theme.of(context).textTheme.body2,
                    )
                  ],
                ),
                children: <Widget>[
                  Form(
                    key: _profileSettingsFormKey,
                    child: Column(
                      children: <Widget>[
                        new TextFormField(
                          controller: firstName,
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.text,
                          decoration: getInputDecoration(
                              hintText: 'John Doe', labelText: 'First Name'),
                          validator: (input) => input.trim().length < 2
                              ? 'Not a valid full name'
                              : null,
                          onSaved: (input) => widget.user.firstName = input,
                        ),
                        new TextFormField(
                          controller: lastName,
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.text,
                          decoration: getInputDecoration(
                              hintText: 'John Doe', labelText: 'Surname'),
                          validator: (input) => input.trim().length < 3
                              ? 'Not a valid full name'
                              : null,
                          onSaved: (input) => widget.user.firstName = input,
                        ),
                        new TextFormField(
                          controller: otherName,
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.text,
                          decoration: getInputDecoration(
                              hintText: 'John Doe', labelText: 'Other names'),
                          validator: (input) => input.trim().length < 3
                              ? 'Not a valid full name'
                              : null,
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
                        FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return DateTimeField(
                              controller: dob,
                              decoration: getInputDecoration(
                                  hintText: '1996-12-31',
                                  labelText: 'Birth Date'),
                              format: new DateFormat('yyyy-MM-dd'),
                              onShowPicker: (context, currentValue) {
                                return showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    initialDate: currentValue ?? DateTime.now(),
                                    lastDate: DateTime(3000));
                              },
                              onSaved: (input) => setState(() {
                                widget.user.dateOfBirth = input;
                                widget.onChanged();
                              }),
                            );
                          },
                        ),
                        new TextFormField(
                          controller: nok,
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.text,
                          decoration: getInputDecoration(
                              hintText: 'John Doe', labelText: 'Next of kin'),
                          validator: (input) => input.trim().length < 3
                              ? 'Not a valid full name'
                              : null,
                          onSaved: (input) => widget.user.firstName = input,
                        ),
                        new TextFormField(
                          controller: nokPhoneNo,
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.number,
                          decoration: getInputDecoration(
                              hintText: 'John Doe',
                              labelText: 'Next Of Kin Phone No'),
                          validator: (input) => input.trim().length < 1
                              ? 'Not a valid full name'
                              : null,
                          onSaved: (input) => widget.user.firstName = input,
                        ),
                        new TextFormField(
                          controller: secQuestion,
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.text,
                          decoration: getInputDecoration(
                              hintText: 'John Doe',
                              labelText: 'Security Question'),
                          validator: (input) => input.trim().length < 1
                              ? 'Not a valid full name'
                              : null,
                          onSaved: (input) => widget.user.firstName = input,
                        ),
                        new TextFormField(
                          controller: secAnswer,
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.text,
                          decoration: getInputDecoration(
                              hintText: 'Answer to question',
                              labelText: 'Security Answer'),
                          validator: (input) => input.trim().length < 1
                              ? 'Not a valid full name'
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
                    child: Container(
                      child: Text('${update}'),
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
    if (_profileSettingsFormKey.currentState.validate()) {
      _profileSettingsFormKey.currentState.save();

      update = 'Updating...';

      Update updat = Update(
          firstName: firstName.text,
          surname: lastName.text,
          otherNames: otherName.text,
          dob: dob.text,
          nextOfKin: nok.text,
          nextOfKinPhoneNumber: nokPhoneNo.text,
          secQuestion: secQuestion.text,
          secAnswer: secAnswer.text);
      await updat.getRegistered(widget.user.id);
      if (updat.status == '200') {
        update = 'SUCCESSFUL';
        Navigator.pop(context);
      } else {
        setState(() {
          update = 'Unsuccessful try again';
        });
      }

      Navigator.pop(context);
    }
  }
}
