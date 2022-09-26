import 'package:ahioma/config/ui_icons.dart';
import 'package:ahioma/main.dart';
import 'package:ahioma/src/services/login_service.dart';
import 'package:ahioma/src/widgets/SocialMediaWidget.dart';
import 'package:ahioma/src/widgets/popup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignInWidget extends StatefulWidget {
  final Function doAfter;

  SignInWidget({
    Key key,
    this.doAfter,
  }) : super(key: key);
  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  bool _showPassword = false;
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  var loginn;
  final storage = FlutterSecureStorage();
  String message = " ";

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  margin: EdgeInsets.symmetric(vertical: 65, horizontal: 50),
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
                      ]),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 25),
                        Text(
                          'Welcome Back',
                          style: Theme.of(context).textTheme.display3.merge(
                                TextStyle(color: Theme.of(context).hintColor),
                              ),
                        ),
                        SizedBox(height: 20),
                        new TextFormField(
                          controller: email,
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                          keyboardType: TextInputType.emailAddress,
                          decoration: new InputDecoration(
                            hintText: 'Email Address',
                            hintStyle: Theme.of(context).textTheme.body1.merge(
                                  TextStyle(
                                      color: Theme.of(context).accentColor),
                                ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor)),
                            prefixIcon: Icon(
                              UiIcons.envelope,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        new TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }

                            return null;
                          },
                          controller: password,
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                          keyboardType: TextInputType.text,
                          obscureText: !_showPassword,
                          decoration: new InputDecoration(
                            hintText: 'Password',
                            hintStyle: Theme.of(context).textTheme.body1.merge(
                                  TextStyle(
                                      color: Theme.of(context).accentColor),
                                ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor)),
                            prefixIcon: Icon(
                              UiIcons.padlock_1,
                              color: Theme.of(context).accentColor,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.4),
                              icon: Icon(_showPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        FlatButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot your password ?',
                            style: Theme.of(context).textTheme.body1,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text("$message"),
                        FlatButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 70),
                          onPressed: () async {
                            AttemptLogin login = AttemptLogin(
                                email: email.text, password: password.text);
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                message = 'Please wait while we log you in';
                              });
                              loginn = await login.login();

                              if (login.status == '200') {
                                await storage.write(
                                    key: 'login', value: login.loggin);
                                await storage.write(key: 'id', value: login.id);
                                await storage.write(
                                    key: 'email', value: login.email);
                                await storage.write(
                                    key: 'firstName', value: login.firstName);
                                if (widget.doAfter != null)
                                  {
                                  widget.doAfter(this.context);}
                                else {
                                  Navigator.popAndPushNamed(context, '/Tabs',
                                      arguments: 2);
                                }
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (_) => UnsuccessfulLogin());
                              }
                            }
                            // 2 number refer the index of Home page
                          },
                          child: Text(
                            'Login',
                            style: Theme.of(context).textTheme.title.merge(
                                  TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                          ),
                          color: Theme.of(context).hintColor,
                          shape: StadiumBorder(),
                        ),
                        // SizedBox(height: 30),
                        // Text(
                        //   'Or using social media',
                        //   style: Theme.of(context).textTheme.body1.merge(TextStyle(color: Theme.of(context).accentColor)),
                        // ),
                        // SizedBox(height: 10),
                        // new SocialMediaWidget(),
                        SizedBox(height: 10),
                        FlatButton(
                          onPressed: () {
                            Navigator.popAndPushNamed(context, '/SignUp',
                                arguments: widget.doAfter);
                          },
                          child: RichText(
                            text: TextSpan(
                              style: Theme.of(context).textTheme.title.merge(
                                    TextStyle(
                                        color: Theme.of(context).accentColor),
                                  ),
                              children: [
                                TextSpan(
                                    text: 'Don\'t have an account ?',
                                    style: TextStyle(fontSize: 12.0)),
                                TextSpan(
                                    text: ' Sign Up',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context).hintColor)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
