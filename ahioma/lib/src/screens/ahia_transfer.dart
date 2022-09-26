import 'package:ahioma/config/ui_icons.dart';
import 'package:ahioma/src/widgets/SocialMediaWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ahioma/src/services/ahia_pay_services.dart';
import 'package:ahioma/src/models/route_argument.dart';

class AhiaTransferWidget extends StatefulWidget {
  String userId;
  double balance;
  RouteArgument routeArgument;

  AhiaTransferWidget({Key key, this.routeArgument}) {
    userId = this.routeArgument.argumentsList[0] as String;
    balance = this.routeArgument.argumentsList[1] as double;
  }
  @override
  _AhiaTransferWidgetState createState() => _AhiaTransferWidgetState();
}

class _AhiaTransferWidgetState extends State<AhiaTransferWidget> {
  bool loading = true;
  bool error = false;
  bool recipientName = true;
  String mess = '';
  final amount = TextEditingController();
  final receiver = TextEditingController();
  final ValueNotifier<int> load1 = ValueNotifier<int>(0);
  final ValueNotifier<int> load2 = ValueNotifier<int>(0);
  final note = TextEditingController();
  AhiaTransfer transfer = AhiaTransfer();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _profileSettingsFormKey = new GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).hintColor,
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
                    key: _profileSettingsFormKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 25),
                        Text('AhiaPay Transfer',
                            style: Theme.of(context).textTheme.display3),
                        SizedBox(height: 20),
                        new TextFormField(
                          controller: amount,
                          validator: (value) {
                            int amou = 0;
                            if (value.isNotEmpty) {
                              amou = int.parse(value);
                            }
                            if (amou > widget.balance) {
                              return 'Insufficient balance';
                            } else if (amou == 0) {
                              return 'Amount cannot be empty';
                            }
                          },
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                            hintText: 'Amount',
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
                              UiIcons.placeholder,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        new TextFormField(
                          controller: receiver,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Phone number cannot be empty';
                            }
                          },
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                            hintText: 'Receiver phone number ',
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
                              UiIcons.placeholder,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        new TextFormField(
                          onFieldSubmitted: (value){

                          },
                          controller: note,
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.text,
                          decoration: new InputDecoration(
                            hintText: 'Recipent name',
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
                              UiIcons.placeholder,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        new TextFormField(
                          controller: note,
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.text,
                          decoration: new InputDecoration(
                            hintText: 'Transaction Note',
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
                              UiIcons.placeholder,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Text('Account Balance: ${widget.balance}'),
                        SizedBox(height: 10),
                        ValueListenableBuilder(
                            builder: (BuildContext context, int value,
                                Widget child) {
                              return Text(
                                mess,
                                style: TextStyle(
                                    color: error
                                        ? Colors.red
                                        : Theme.of(context).hintColor),
                              );
                            },
                            valueListenable: load2),
                        SizedBox(height: 30),
                        Column(
                          children: <Widget>[
                            ValueListenableBuilder(
                                builder: (BuildContext context, int value,
                                    Widget child) {
                                  return FlatButton(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 70),
                                    onPressed: loading
                                        ? () async {
                                            if (_profileSettingsFormKey
                                                .currentState
                                                .validate()) {
                                              error=false;
                                              loading = false;
                                              mess = 'Loading...';
                                              load1.value += 1;
                                              load2.value += 1;
                                              int amoun =
                                                  int.parse(amount.text);
                                              await transfer.ahiaTransfer(
                                                  widget.userId,
                                                  amoun,
                                                  receiver.text,
                                                  note.text);
                                              mess;
                                              String rte;
                                              if (transfer.message.isEmpty) {
                                                error=true;
                                                mess =
                                                    'Error:Check the recipient number and try again';
                                                load2.value += 1;
                                                loading = true;
                                                load1.value += 1;
                                              } else {
                                                mess = transfer.message;
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text(mess),
                                                  elevation: 250,
                                                  duration:
                                                      Duration(seconds: 3),
                                                ));
                                                loading = true;
                                                Navigator.of(context).pushNamed(
                                                    '/Tabs',
                                                    arguments: 3);
                                                // _scaffoldKey.currentState
                                                //     .showSnackBar(SnackBar(
                                                //   content: Column(
                                                //     mainAxisSize:
                                                //         MainAxisSize.min,
                                                //     children: <Widget>[
                                                //       Text('Go to wallet'),
                                                //       FlatButton(
                                                //         color: Colors.white,
                                                //         textColor: Colors.black,
                                                //         child: Text('$rte'),
                                                //         onPressed: () {
                                                //           Navigator.of(context)
                                                //               .pushNamed(
                                                //                   '/Tabs',
                                                //                   arguments: 3);
                                                //         },
                                                //       )
                                                //     ],
                                                //   ),
                                                // ));
                                              }
                                            }
                                            // 2 number refer the index of Home page
                                            // Navigator.of(context).pushNamed('/Tabs', arguments: 2);

                                            // Navigator.of(context).pushNamed('/AhiaPay');
                                          }
                                        : null,
                                    child: Text(
                                      'Send',
                                      style: Theme.of(context)
                                          .textTheme
                                          .title
                                          .merge(
                                            TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                    ),
                                    color: Theme.of(context).accentColor,
                                    shape: StadiumBorder(),
                                  );
                                },
                                valueListenable: load1),

                            SizedBox(height: 20),

                            // FlatButton(
                            //   padding: EdgeInsets.symmetric(vertical: 12, horizontal: 70),
                            //   onPressed: () {
                            //     // 2 number refer the index of Home page
                            //     Navigator.of(context).pushNamed('/Tabs', arguments: 2);
                            //   },
                            //   child: Text(
                            //     'Bank Transfer',
                            //     style: Theme.of(context).textTheme.title.merge(
                            //       TextStyle(color: Theme.of(context).primaryColor),
                            //     ),
                            //   ),
                            //   color: Theme.of(context).accentColor,
                            //   shape: StadiumBorder(),
                            // ),
                          ],
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
