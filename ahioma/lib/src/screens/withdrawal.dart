import 'package:ahioma/config/ui_icons.dart';
import 'package:ahioma/src/models/route_argument.dart';
import 'package:ahioma/src/services/ahia_pay_services.dart';
import 'package:ahioma/src/widgets/SocialMediaWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class WithdrawalWidget extends StatefulWidget {
  RouteArgument routeAgrument;
  String amount;
  WithdrawalWidget({Key key, this.amount, this.routeAgrument}) {
    amount = this.routeAgrument.argumentsList[0] as String;
  }
  @override
  _WithdrawalWidgetState createState() => _WithdrawalWidgetState();
}

class _WithdrawalWidgetState extends State<WithdrawalWidget> {
  bool lading = true;

  bool error= false;
  final amount = TextEditingController();
  final ValueNotifier<int> load1 = ValueNotifier<int>(0);
  final ValueNotifier<int> load2 = ValueNotifier<int>(0);
  String loading='';
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
                        Text('Withdraw To Bank',
                            style: Theme.of(context).textTheme.display3),
                        SizedBox(height: 20),
                        new TextFormField(
                          controller: amount,
                          validator: (value) {
                            double amou=0;
                            double an = double.parse(widget.amount);

    if (value.isNotEmpty) {
      amou = double.parse(value);
    }
                            if (amou > an) {
                              return 'Insufficient balance';
                            } else if (amou < 500) {
                              return 'Minimum withdral amount is 500';
                            }
                            else if (value.isEmpty) {
                              return 'Amount can\'t be empty';
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
                        SizedBox(height: 30),
                        Text('Account Balance: ${widget.amount}'),
                        SizedBox(height: 30),
                        ValueListenableBuilder(
                            builder: (BuildContext context, int value,
                                Widget child) {
                              return Text(
                                loading,
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

    return
                               FlatButton(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 70),
                                onPressed:lading? () async {
                                  if (_profileSettingsFormKey.currentState.validate()) {

                                      loading = 'Loading...';
                                      error=false;
                                      lading = false;
                                      load1.value += 1;
                                      load2.value += 1;

                                    initWithdrawal withdraw = initWithdrawal();
                                    double amou = double.parse(amount.text);
                                    var storage = FlutterSecureStorage();
                                    var id = await storage.read(key: 'id');
                                    await withdraw.initWithdraw(id, amou);
                                    if (withdraw.message == '') {
                                      Withdraw withd = Withdraw();
                                      await withd.withdraw(id, amount.text);
                                        loading = '';
                                      load1.value += 1;
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content: Text('Withdrawal Successful',style: TextStyle(color: Colors.white),),
                                        duration: Duration(seconds: 3),
                                        backgroundColor: Theme.of(context).hintColor,
                                        elevation: 250,
                                      ));
                                      Navigator.of(context).pushNamed(
                                          '/Tabs',
                                          arguments: 3);
                                    } else
                                      error=true;
                                      loading =
                                      '${withdraw.message}';
                                      load1.value += 1;
                                      lading=true;
                                      load2.value += 1;
                                  }

                                  // 2 number refer the index of Home page
                                  // Navigator.of(context).pushNamed('/Tabs', arguments: 2);

                                  // Navigator.of(context).pushNamed('/AhiaPay');
                                }:null,
                                child: Text(
                                  'Confirm',
                                  style: Theme.of(context).textTheme.title.merge(
                                        TextStyle(
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                ),
                                color: Theme.of(context).accentColor,
                                shape: StadiumBorder(),
                              );},valueListenable: load2
       ),
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
