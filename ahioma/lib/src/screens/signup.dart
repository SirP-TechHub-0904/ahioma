import 'dart:math';
import 'package:ahioma/config/ui_icons.dart';
import 'package:ahioma/src/services/register_service.dart';
import 'package:ahioma/src/services/login_service.dart';
import 'package:ahioma/src/widgets/SocialMediaWidget.dart';
import 'package:ahioma/src/widgets/popup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

typedef void IntCallback(String name);

class SignUpWidget extends StatefulWidget {
  final Function doAfter;

  SignUpWidget({
    Key key,
    this.doAfter,
  }) : super(key: key);
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  bool _showPassword = false;
  String message = " ";
  final ValueNotifier<int> loading = ValueNotifier<int>(0);
  final storage = FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  bool signUpAttempt = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    password.dispose();
    confirmPassword.dispose();
    email.dispose();
    phoneNumber.dispose();
    super.dispose();
  }

  signUpState() {
    setState(() {
      signUpAttempt = true;
    });
  }

  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Theme.of(context).hintColor,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                    margin: EdgeInsets.symmetric(vertical: 65, horizontal: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).primaryColor.withOpacity(0.6),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                    margin: EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).primaryColor,
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).hintColor.withOpacity(0.2),
                            offset: Offset(0, 10),
                            blurRadius: 20)
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 25),
                        Text('Sign Up',
                            style: Theme.of(context).textTheme.display3),
                        SizedBox(height: 20),
                        new TextFormField(
                          controller: firstName,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }

                            return null;
                          },
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.text,
                          decoration: new InputDecoration(
                            hintText: 'First Name',
                            hintStyle: Theme.of(context).textTheme.body1.merge(
                                  TextStyle(color: Theme.of(context).hintColor),
                                ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).hintColor)),
                            prefixIcon: Icon(
                              UiIcons.user,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        new TextFormField(
                          controller: lastName,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }

                            return null;
                          },
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.emailAddress,
                          decoration: new InputDecoration(
                            hintText: 'Last Name',
                            hintStyle: Theme.of(context).textTheme.body1.merge(
                                  TextStyle(color: Theme.of(context).hintColor),
                                ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).hintColor)),
                            prefixIcon: Icon(
                              UiIcons.user,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        new TextFormField(
                          controller: email,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }

                            return null;
                          },
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.emailAddress,
                          decoration: new InputDecoration(
                            hintText: 'Email Address',
                            hintStyle: Theme.of(context).textTheme.body1.merge(
                                  TextStyle(color: Theme.of(context).hintColor),
                                ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).hintColor)),
                            prefixIcon: Icon(
                              UiIcons.envelope,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        new TextFormField(
                          controller: phoneNumber,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your phone number';
                            }

                            return null;
                          },
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                            hintText: 'Phone Number',
                            hintStyle: Theme.of(context).textTheme.body1.merge(
                                  TextStyle(color: Theme.of(context).hintColor),
                                ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).hintColor)),
                            prefixIcon: Icon(
                              UiIcons.phone_call,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        new TextFormField(
                          controller: password,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your password';
                            }

                            return null;
                          },
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.text,
                          obscureText: !_showPassword,
                          decoration: new InputDecoration(
                            hintText: 'Password',
                            hintStyle: Theme.of(context).textTheme.body1.merge(
                                  TextStyle(color: Theme.of(context).hintColor),
                                ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).hintColor)),
                            prefixIcon: Icon(
                              UiIcons.padlock_1,
                              color: Theme.of(context).hintColor,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                              color:
                                  Theme.of(context).hintColor.withOpacity(0.4),
                              icon: Icon(_showPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        new TextFormField(
                          controller: confirmPassword,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please confirm your password ';
                            } else if (value != password.text) {
                              return 'Password mismatch';
                            }

                            return null;
                          },
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.text,
                          obscureText: !_showPassword,
                          decoration: new InputDecoration(
                            hintText: 'Confirm Password',
                            hintStyle: Theme.of(context).textTheme.body1.merge(
                                  TextStyle(color: Theme.of(context).hintColor),
                                ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).hintColor)),
                            prefixIcon: Icon(
                              UiIcons.padlock_1,
                              color: Theme.of(context).hintColor,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                              color:
                                  Theme.of(context).hintColor.withOpacity(0.4),
                              icon: Icon(_showPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        ValueListenableBuilder(
                            builder: (BuildContext context, int value,
                                Widget child) {
                              return Text("$message");
                            },
                            valueListenable: loading),
                        SizedBox(height: 40),
                        FlatButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 70),
                          onPressed: () async {
                            message = 'Please wait while we sign you up';
                            loading.value += 1;
                            Register register = Register(
                                email: email.text,
                                phoneNumber: phoneNumber.text,
                                password: password.text,
                                firstName: firstName.text,
                                surname: lastName.text);
                            if (_formKey.currentState.validate()) {
                              await register.getRegistered();
                              if (register.status == '200') {
                                message = 'Now logging you in ';
                                loading.value += 1;
                                AttemptLogin login = AttemptLogin(
                                    email: email.text, password: password.text);
                                await login.login();
                                if (login.status == '200') {
                                  await storage.write(
                                      key: 'login', value: login.loggin);
                                  await storage.write(
                                      key: 'id', value: login.id);
                                  await storage.write(
                                      key: 'email', value: login.email);
                                  await storage.write(
                                      key: 'firstName', value: login.firstName);
                                  widget.doAfter();
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (_) => UnsuccessfulLogin());
                                }

                                // showDialog(
                                //     context: context,
                                //     builder: (_) => SuccessPopup());
                                // signUpState();
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (_) => UnsuccessfullPopup());
                                signUpState();
                              }
                            }
                          },
                          child: Text(
                            'Sign Up',
                            style: Theme.of(context).textTheme.title.merge(
                                  TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                          ),
                          color: Theme.of(context).accentColor,
                          shape: StadiumBorder(),
                        ),
                        AlertDialog(),
                        SizedBox(height: 10),
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).popAndPushNamed('/SignIn',
                                arguments: widget.doAfter);
                          },
                          child: RichText(
                            text: TextSpan(
                              style: Theme.of(context).textTheme.title.merge(
                                    TextStyle(
                                        color: Theme.of(context).hintColor,
                                        fontSize: 12.0),
                                  ),
                              children: [
                                TextSpan(
                                  text: 'Already have an account ?',
                                ),
                                TextSpan(
                                    text: ' Sign In',
                                    style: Theme.of(context)
                                        .textTheme
                                        .title
                                        .merge(TextStyle(
                                            color:
                                                Theme.of(context).accentColor)))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
