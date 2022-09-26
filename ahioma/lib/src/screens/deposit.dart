import 'package:ahioma/config/ui_icons.dart';
import 'package:ahioma/src/services/ahia_pay_services.dart';
import 'package:ahioma/src/widgets/SocialMediaWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ahioma/src/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rave_flutter/rave_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DepositWidget extends StatefulWidget {
  @override
  _DepositWidgetState createState() => _DepositWidgetState();
}

class _DepositWidgetState extends State<DepositWidget> {
  Deposit deposit = Deposit();
  Deposit depo = Deposit();
  var id;
  UpdateDeposit updateDeposit = UpdateDeposit();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _profileSettingsFormKey = new GlobalKey<FormState>();

  final amount = TextEditingController();
  int amo;
  int trans;
  Future<void> getWallet() async {
    var storage = FlutterSecureStorage();
    id = await storage.read(key: 'id');
    if (amount.text.isNotEmpty) {
      amo = int.parse(amount.text);
    } else {
      amo == 0;
    }
    depo = await deposit.beginDeposit(id, amo);
  }

  final String txref = "My_unique_transaction_reference_123";
  final String amountt = "200";

  void startPayment() async {
    var initializer = RavePayInitializer(
        amount: depo.amount.toDouble(),
        publicKey: 'FLWPUBK-2441b9d4477112e505bfc756a3292c73-X',
        encryptionKey: '3ebc176be741462d7e4e490c',
        subAccounts: null)
      ..country = "NG"
      ..currency = "NGN"
      ..email = depo.email
      ..fName = depo.firstName
      ..lName = depo.lastName
      ..narration = 'Ahia deposit'
      ..txRef = depo.transId
      ..orderRef = depo.transId
      ..acceptMpesaPayments = false
      ..acceptAccountPayments = false
      ..acceptCardPayments = true
      ..acceptAchPayments = false
      ..acceptGHMobileMoneyPayments = false
      ..acceptUgMobileMoneyPayments = false
      ..acceptMobileMoneyFrancophoneAfricaPayments = false
      ..displayEmail = true
      ..displayAmount = true
      ..staging = false
      ..isPreAuth = true
      ..displayFee = true;

    var response = await RavePayManager()
        .prompt(context: context, initializer: initializer);
    print(response);
    print(response.rawResponse['status']);
    if (response.status.toString()=='RaveStatus.cancelled'){
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text(response?.message),duration: Duration(seconds: 3),));
        Navigator.of(context).pushNamed('/Tabs',arguments: 3);
    }
    else if (response.status.toString()=='RaveStatus.success') {
      var trans = int.parse(depo.transId);
      await updateDeposit.updateDeposit(id, trans, 4);
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text(response?.message),duration: Duration(seconds: 3),));
      Navigator.of(context).pushNamed('/Tabs', arguments: 3);
    } else {
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text(response?.message),duration: Duration(seconds: 3),));

      Navigator.of(context).pushNamed('/Tabs', arguments: 3);
    }

  }

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
                        Text('Deposit',
                            style: Theme.of(context).textTheme.display3),
                        SizedBox(height: 20),
                        new TextFormField(
                          controller: amount,
                          style: TextStyle(color: Theme.of(context).hintColor),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Amount can\'t be empty';
                            }
                          },
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
                        Column(
                          children: <Widget>[
                            FlatButton(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 70),
                              onPressed: () async {
                                if (_profileSettingsFormKey.currentState
                                    .validate()) {
                                  await getWallet();
                                  startPayment();
                                }
                                // 2 number refer the index of Home page
                                // Navigator.of(context).pushNamed('/Tabs', arguments: 2);
                              },
                              child: Text(
                                'Continue',
                                style: Theme.of(context).textTheme.title.merge(
                                      TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                              ),
                              color: Theme.of(context).accentColor,
                              shape: StadiumBorder(),
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
