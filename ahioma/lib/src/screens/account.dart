import 'package:ahioma/config/ui_icons.dart';
import 'package:ahioma/src/models/user.dart';
import 'package:ahioma/src/widgets/ProfileSettingsDialog.dart';
import 'package:ahioma/src/widgets/SearchBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ahioma/src/services/ahia_pay_services.dart';
import 'package:ahioma/src/widgets/BankDialogue.dart';

class AccountWidget extends StatefulWidget {
  @override
  _AccountWidgetState createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  User _user = User.init();
  User user = User.init();
  Bank bank =Bank();
  List<Bank>bankk;

  Future<User> getUser() async {
    var storage = FlutterSecureStorage();
    var uId = await storage.read(key: 'id');
    user = await _user.getCurrentMainUser(uId.toString());
    bankk = await bank.getBanks();
    print(bankk);
    print(user);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUser(),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (!snapshot.hasData) return Container(child:Center(child: CircularProgressIndicator())); // still loading
          // alternatively use snapshot.connectionState != ConnectionState.done
          User userID = snapshot.data;
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 7),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SearchBarWidget(),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text(
                              '${userID.firstName}',
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.display2,
                            ),
                            Text(
                              '${userID.email}',
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                      // SizedBox(
                      //     width: 55,
                      //     height: 55,
                      //     child: InkWell(
                      //       borderRadius: BorderRadius.circular(300),
                      //       onTap: () {
                      //         Navigator.of(context).pushNamed('/Tabs', arguments: 1);
                      //       },
                      //       child: CircleAvatar(
                      //         backgroundImage: AssetImage(_user.avatar),
                      //       ),
                      //     )),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.15),
                          offset: Offset(0, 3),
                          blurRadius: 10)
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: FlatButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/Orders');
                          },
                          child: Column(
                            children: <Widget>[
                              Icon(UiIcons.inbox),
                              Text(
                                'Orders',
                                style: Theme.of(context).textTheme.body1,
                              )
                            ],
                          ),
                        ),
                      ),
                      // Expanded(
                      //   child: FlatButton(
                      //     padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      //     onPressed: () {
                      //       Navigator.of(context).pushNamed('/Tabs', arguments: 0);
                      //     },
                      //     child: Column(
                      //       children: <Widget>[
                      //         Icon(UiIcons.favorites),
                      //         Text(
                      //           'Following',
                      //           style: Theme.of(context).textTheme.body1,
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Expanded(
                        child: FlatButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed('/Tabs', arguments: 3);
                          },
                          child: Column(
                            children: <Widget>[
                              Icon(UiIcons.money),
                              Text(
                                'AhiaPay',
                                style: Theme.of(context).textTheme.body1,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                //   decoration: BoxDecoration(
                //     color: Theme.of(context).primaryColor,
                //     borderRadius: BorderRadius.circular(6),
                //     boxShadow: [
                //       BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.15), offset: Offset(0, 3), blurRadius: 10)
                //     ],
                //   ),
                //   child: ListView(
                //     shrinkWrap: true,
                //     primary: false,
                //     children: <Widget>[
                //       ListTile(
                //         leading: Icon(UiIcons.inbox),
                //         title: Text(
                //           'My Orders',
                //           style: Theme.of(context).textTheme.body2,
                //         ),
                //         trailing: ButtonTheme(
                //           padding: EdgeInsets.all(0),
                //           minWidth: 50.0,
                //           height: 25.0,
                //           child: FlatButton(
                //             onPressed: () {
                //               Navigator.of(context).pushNamed('/Orders');
                //             },
                //             child: Text(
                //               "View all",
                //               style: Theme.of(context).textTheme.body1,
                //             ),
                //           ),
                //         ),
                //       ),
                //       ListTile(
                //         onTap: () {
                //           Navigator.of(context).pushNamed('/Orders');
                //         },
                //         dense: true,
                //         title: Text(
                //           'Unpaid',
                //           style: Theme.of(context).textTheme.body1,
                //         ),
                //         trailing: Chip(
                //           padding: EdgeInsets.symmetric(horizontal: 10),
                //           backgroundColor: Colors.transparent,
                //           shape: StadiumBorder(side: BorderSide(color: Theme.of(context).focusColor)),
                //           label: Text(
                //             '1',
                //             style: TextStyle(color: Theme.of(context).focusColor),
                //           ),
                //         ),
                //       ),
                //       ListTile(
                //         onTap: () {
                //           Navigator.of(context).pushNamed('/Orders');
                //         },
                //         dense: true,
                //         title: Text(
                //           'To be shipped',
                //           style: Theme.of(context).textTheme.body1,
                //         ),
                //         trailing: Chip(
                //           padding: EdgeInsets.symmetric(horizontal: 10),
                //           backgroundColor: Colors.transparent,
                //           shape: StadiumBorder(side: BorderSide(color: Theme.of(context).focusColor)),
                //           label: Text(
                //             '5',
                //             style: TextStyle(color: Theme.of(context).focusColor),
                //           ),
                //         ),
                //       ),
                //       ListTile(
                //         onTap: () {
                //           Navigator.of(context).pushNamed('/Orders');
                //         },
                //         dense: true,
                //         title: Text(
                //           'Shipped',
                //           style: Theme.of(context).textTheme.body1,
                //         ),
                //         trailing: Chip(
                //           padding: EdgeInsets.symmetric(horizontal: 10),
                //           backgroundColor: Colors.transparent,
                //           shape: StadiumBorder(side: BorderSide(color: Theme.of(context).focusColor)),
                //           label: Text(
                //             '3',
                //             style: TextStyle(color: Theme.of(context).focusColor),
                //           ),
                //         ),
                //       ),
                //       ListTile(
                //         onTap: () {
                //           Navigator.of(context).pushNamed('/Orders');
                //         },
                //         dense: true,
                //         title: Text(
                //           'In dispute',
                //           style: Theme.of(context).textTheme.body1,
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.15),
                          offset: Offset(0, 3),
                          blurRadius: 10)
                    ],
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    primary: false,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(UiIcons.user_1),
                        title: Text(
                          'Profile Settings',
                          style: Theme.of(context).textTheme.body2,
                        ),
                        trailing: ButtonTheme(
                          padding: EdgeInsets.all(0),
                          minWidth: 50.0,
                          height: 25.0,
                          child: ProfileSettingsDialog(
                            user: user,
                            onChanged: () {
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        dense: true,
                        title: Row(
                          children: <Widget>[
                            Icon(
                              UiIcons.placeholder,
                              size: 22,
                              color: Theme.of(context).focusColor,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'First Name:',
                              style: Theme.of(context).textTheme.body1,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                '${userID.firstName}',
                                overflow: TextOverflow.visible,
                                softWrap: true,
                                style: TextStyle(
                                    color: Theme.of(context).focusColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        dense: true,
                        title: Row(
                          children: <Widget>[
                            Icon(
                              UiIcons.placeholder,
                              size: 22,
                              color: Theme.of(context).focusColor,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Surname:',
                              style: Theme.of(context).textTheme.body1,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                '${userID.lastName}',
                                overflow: TextOverflow.visible,
                                softWrap: true,
                                style: TextStyle(
                                    color: Theme.of(context).focusColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        dense: true,
                        title: Row(
                          children: <Widget>[
                            Icon(
                              UiIcons.placeholder,
                              size: 22,
                              color: Theme.of(context).focusColor,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Other Names:',
                              style: Theme.of(context).textTheme.body1,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                '${userID.otherNames}',
                                overflow: TextOverflow.visible,
                                softWrap: true,
                                style: TextStyle(
                                    color: Theme.of(context).focusColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        dense: true,
                        title: Row(
                          children: <Widget>[
                            Icon(
                              UiIcons.placeholder,
                              size: 22,
                              color: Theme.of(context).focusColor,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Email:',
                              style: Theme.of(context).textTheme.body1,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                '${userID.email}',
                                overflow: TextOverflow.visible,
                                softWrap: true,
                                style: TextStyle(
                                    color: Theme.of(context).focusColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        dense: true,
                        title: Row(
                          children: <Widget>[
                            Icon(
                              UiIcons.placeholder,
                              size: 22,
                              color: Theme.of(context).focusColor,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Phone Number:',
                              style: Theme.of(context).textTheme.body1,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                '${userID.phoneNumber}',
                                overflow: TextOverflow.visible,
                                softWrap: true,
                                style: TextStyle(
                                    color: Theme.of(context).focusColor),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ListTile(
                      //   onTap: () {},
                      //   dense: true,
                      //   title: Text(
                      //     'Gender',
                      //     style: Theme.of(context).textTheme.body1,
                      //   ),
                      //   trailing: Text(
                      //     _user.gender,
                      //     style: TextStyle(color: Theme.of(context).focusColor),
                      //   ),
                      // ),
                      ListTile(
                        onTap: () {},
                        dense: true,
                        title: Row(
                          children: <Widget>[
                            Icon(
                              UiIcons.placeholder,
                              size: 22,
                              color: Theme.of(context).focusColor,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Date Of Birth:',
                              style: Theme.of(context).textTheme.body1,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                '${userID.dateOfBirth.toString()}',
                                overflow: TextOverflow.visible,
                                softWrap: true,
                                style: TextStyle(
                                    color: Theme.of(context).focusColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        dense: true,
                        title: Row(
                          children: <Widget>[
                            Icon(
                              UiIcons.placeholder,
                              size: 22,
                              color: Theme.of(context).focusColor,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Next Of Kin:',
                              style: Theme.of(context).textTheme.body1,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                '${userID.NOK}',
                                overflow: TextOverflow.visible,
                                softWrap: true,
                                style: TextStyle(
                                    color: Theme.of(context).focusColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        dense: true,
                        title: Row(
                          children: <Widget>[
                            Icon(
                              UiIcons.placeholder,
                              size: 22,
                              color: Theme.of(context).focusColor,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Next Of Kin Phone Number:',
                              style: Theme.of(context).textTheme.body1,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                '${userID.nokNumber}',
                                overflow: TextOverflow.visible,
                                softWrap: true,
                                style: TextStyle(
                                    color: Theme.of(context).focusColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        dense: true,
                        title: Row(
                          children: <Widget>[
                            Icon(
                              UiIcons.placeholder,
                              size: 22,
                              color: Theme.of(context).focusColor,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Security Questions:',
                              style: Theme.of(context).textTheme.body1,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                '${userID.secQuestion}',
                                overflow: TextOverflow.visible,
                                softWrap: true,
                                style: TextStyle(
                                    color: Theme.of(context).focusColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        dense: true,
                        title: Row(
                          children: <Widget>[
                            Icon(
                              UiIcons.placeholder,
                              size: 22,
                              color: Theme.of(context).focusColor,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Security Answer:',
                              style: Theme.of(context).textTheme.body1,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                '${userID.secAnswer}',
                                overflow: TextOverflow.visible,
                                softWrap: true,
                                style: TextStyle(
                                    color: Theme.of(context).focusColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.15),
                          offset: Offset(0, 3),
                          blurRadius: 10)
                    ],
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    primary: false,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(UiIcons.settings_1),
                        title: Text(
                          'Account Settings',
                          style: Theme.of(context).textTheme.body2,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                                color: Theme.of(context).hintColor.withOpacity(0.15),
                                offset: Offset(0, 3),
                                blurRadius: 10)
                          ],
                        ),
                        child: ListView(
                          shrinkWrap: true,
                          primary: false,
                          children: <Widget>[
                            ListTile(
                              leading: Icon(UiIcons.settings_1),
                              title: Text(
                                'Bank Details',
                                style: Theme.of(context).textTheme.body2,
                              ),
                                trailing: BankDialog(
                                  user: user,
                                  bankk:bankk,
                                  onChanged: () {
                                    setState(() {});
                                  },
                                )

                            ),
                            ListTile(
                              onTap: () {},
                              dense: true,
                              title: Row(
                                children: <Widget>[
                                  Icon(
                                    UiIcons.placeholder,
                                    size: 22,
                                    color: Theme.of(context).focusColor,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Bank Name:',
                                    style: Theme.of(context).textTheme.body1,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      '${user.bankName}',
                                      overflow: TextOverflow.visible,
                                      softWrap: true,
                                      style: TextStyle(
                                        color: Theme.of(context).focusColor,
                                    ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            ListTile(
                              onTap: () {
                              },
                              dense: true,
                              title: Row(
                                children: <Widget>[
                                  Icon(
                                    UiIcons.planet_earth,
                                    size: 22,
                                    color: Theme.of(context).focusColor,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Account Name:',

                                    style: Theme.of(context).textTheme.body1,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(child:Text(
                                    '${user.acctName}',
                                    overflow: TextOverflow.visible,
                                    softWrap: true,
                                    style: TextStyle(
                                      color: Theme.of(context).focusColor,
                                    ),
                                  )
                                  )
                                ],
                              ),

                            ),
                            ListTile(
                              onTap: () {

                              },
                              dense: true,
                              title: Row(
                                children: <Widget>[
                                  Icon(
                                    UiIcons.information,
                                    size: 22,
                                    color: Theme.of(context).focusColor,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Account Number:',
                                    style: Theme.of(context).textTheme.body1,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      '${user.accountNum}',
                                      overflow: TextOverflow.visible,
                                      softWrap: true,
                                      style: TextStyle(
                                        color: Theme.of(context).focusColor,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.of(context).pushNamed('/Address');
                        },
                        dense: true,
                        title: Row(
                          children: <Widget>[
                            Icon(
                              UiIcons.planet_earth,
                              size: 22,
                              color: Theme.of(context).focusColor,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Addresses',
                              style: Theme.of(context).textTheme.body1,
                            ),
                          ],
                        ),
                      ),
                      // ListTile(
                      //   onTap: () {
                      //     Navigator.of(context).pushNamed('/Help');
                      //   },
                      //   dense: true,
                      //   title: Row(
                      //     children: <Widget>[
                      //       Icon(
                      //         UiIcons.information,
                      //         size: 22,
                      //         color: Theme.of(context).focusColor,
                      //       ),
                      //       SizedBox(width: 10),
                      //       Text(
                      //         'Help & Support',
                      //         style: Theme.of(context).textTheme.body1,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          );
          // return a widget here (you have to return a widget to the builder)
        });
  }
}
