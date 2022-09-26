import 'dart:math';

import 'package:ahioma/config/ui_icons.dart';
import 'package:ahioma/src/services/login_service.dart';
import 'package:ahioma/src/services/register_service.dart';
import 'package:ahioma/src/widgets/SocialMediaWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuccessPopup extends StatefulWidget {
  @override
  _SuccessPopupState createState() => _SuccessPopupState();
}

class _SuccessPopupState extends State<SuccessPopup> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Success'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Welcome to Ahioma'),
            Text('You can now sign in'),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Sign in',
            style: Theme.of(context).textTheme.title.merge(
              TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          color: Theme.of(context).accentColor,
          shape: StadiumBorder(),

          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/SignIn');
          },
        ),
      ],
    );
  }
  }




class UnsuccessfullPopup extends StatefulWidget {
  @override
  _UnsuccessfullPopupState createState() => _UnsuccessfullPopupState();
}

class _UnsuccessfullPopupState extends State<UnsuccessfullPopup> {

  @override
  Widget build(BuildContext context) {
    Register register;
    return AlertDialog(
      title: Text('Error'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
             // Text('${register.reason}'),
            Text('Please try again'),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Try again',
            style: Theme.of(context).textTheme.title.merge(
              TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          color: Theme.of(context).accentColor,
          shape: StadiumBorder(),

          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/SignUp');
          },
        ),
      ],
    );
  }
}
 class UnsuccessfulLogin extends StatefulWidget {
   @override
   _UnsuccessfulLoginState createState() => _UnsuccessfulLoginState();
 }

 class _UnsuccessfulLoginState extends State<UnsuccessfulLogin> {
   @override
   Widget build(BuildContext context) {
     return AlertDialog(
       title: Text('Error'),
       content: SingleChildScrollView(
         child: ListBody(
           children: <Widget>[
             // Text('${register.reason}'),
             Text('No account was found matching that email and password'),
           ],
         ),
       ),
       actions: <Widget>[
         FlatButton(
           child: Text('Try again',
             style: Theme.of(context).textTheme.title.merge(
               TextStyle(color: Theme.of(context).primaryColor),
             ),
           ),
           color: Theme.of(context).accentColor,
           shape: StadiumBorder(),

           onPressed: () {
             Navigator.of(context).pushReplacementNamed('/SignIn');
           },
         ),
       ],
     );
   }
 }


