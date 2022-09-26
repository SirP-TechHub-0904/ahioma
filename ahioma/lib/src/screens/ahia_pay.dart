import 'package:ahioma/config/ui_icons.dart';
import 'package:ahioma/src/models/user.dart';
import 'package:ahioma/src/widgets/ProfileSettingsDialog.dart';
import 'package:ahioma/src/widgets/SearchBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ahioma/src/widgets/AhiaTransactionList.dart';
import 'package:ahioma/src/services/ahia_pay_services.dart';
import 'package:ahioma/src/models/route_argument.dart';

class AhiaPayWidget extends StatefulWidget {
  @override
  _AhiaPayWidgetState createState() => _AhiaPayWidgetState();
}

class _AhiaPayWidgetState extends State<AhiaPayWidget> {
  User _user = User.init();
  var storage = FlutterSecureStorage();
  var transa = [];
  AhiaPay pay = AhiaPay();
  bool isLoading = false;
  final _scrollControlller = ScrollController();
  TransactionList trans = TransactionList();
  AhiaPay wallet;
  int pageKey = 1;
  var id;
  _onEndScroll() {
    setState(() {
      isLoading = true;
    });
    getTransactions();
    setState(() {
      isLoading = false;
    });
  }

  getId() async {
    var storage = FlutterSecureStorage();
    id = await storage.read(key: 'id');
  }

  // transa=trans.list;
  Future<AhiaPay> getWallet() async {
    var storage = FlutterSecureStorage();
    id = await storage.read(key: 'id');
    wallet = await pay.getCurrentWallet(id);
    return wallet;
  }

  Future<List> getTransactions() async {
    try {
      id = await storage.read(key: 'id');
      transa = await trans.getTransactions(id, pageKey.toString());
      pageKey++;
      return transa;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getId();
    // TODO: implement initState
    _scrollControlller.addListener(() {
      if (!isLoading &&
          _scrollControlller.position.maxScrollExtent ==
              _scrollControlller.offset) {
        _onEndScroll();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollControlller,
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SearchBarWidget(),
          ),
          FutureBuilder(
              future: getWallet(),
              builder: (BuildContext context, AsyncSnapshot<AhiaPay> snapshot) {
                if (!snapshot.hasData) return Container(); // still loading
                // alternatively use snapshot.connectionState != ConnectionState.done
                AhiaPay wallet = snapshot.data;
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Center(
                              child: Text(
                                'Avail. Balance',
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                            Center(
                              child: Text(
                                '₦${wallet.withdrawableBalance}',
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w200,
                                    fontSize: 13.00),
                              ),
                            )
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Center(
                              child: Text(
                                'Ledg. Balance',
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                            Center(
                              child: Text(
                                '₦${wallet.ledgerBalance}',
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w200,
                                    fontSize: 13.00),
                              ),
                            )
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                    ],
                  ),
                );
              }),
          FutureBuilder(
              future: getWallet(),
              builder: (BuildContext context, AsyncSnapshot<AhiaPay> snapshot) {
                if (!snapshot.hasData) return Container(); // still loading
                // alternatively use snapshot.connectionState != ConnectionState.done
                AhiaPay wallet = snapshot.data;
                double amou = double.parse(wallet.withdrawableBalance);

                return Container(
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
                            Navigator.of(context).pushNamed('/Deposit');
                          },
                          child: Column(
                            children: <Widget>[
                              Icon(UiIcons.inbox),
                              Text(
                                'Deposit',
                                style: Theme.of(context).textTheme.body1,
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: FlatButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/Withdrawal',arguments: RouteArgument(argumentsList: [amou.toString()]));
                          },
                          child: Column(
                            children: <Widget>[
                              Icon(UiIcons.inbox),
                              Text(
                                'Withdrawal',
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
                            Navigator.of(context).pushNamed('/AhiaTransfer',
                                arguments: new RouteArgument(
                                    argumentsList: [id, amou]));
                          },
                          child: Column(
                            children: <Widget>[
                              Icon(UiIcons.money),
                              Text(
                                'Send',
                                style: Theme.of(context).textTheme.body1,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
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
          FutureBuilder(
              future: getTransactions(),
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                if (!snapshot.hasData)
                  return Container(
                      child: Center(child: CircularProgressIndicator())); // still loading
                // alternatively use snapshot.connectionState != ConnectionState.done
                var transaa = snapshot.data;
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        leading: Icon(
                          UiIcons.flag,
                          color: Theme.of(context).hintColor,
                        ),
                        title: Text(
                          'Transaction History',
                          style: Theme.of(context).textTheme.display1,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: StaggeredGridView.countBuilder(
                        primary: false,
                        shrinkWrap: true,
                        crossAxisCount: 1,
                        itemCount: trans.lisst.length,
                        itemBuilder: (BuildContext context, int index) {
                          return TransactionListItemWidget(
                            transaction: trans.lisst.elementAt(index),
                          );
                        },
//                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(index % 2 == 0 ? 1 : 2),
                        staggeredTileBuilder: (int index) =>
                            new StaggeredTile.fit(1),
                        mainAxisSpacing: 15.0,
                        crossAxisSpacing: 15.0,
                      ),
                    ),
                  ],
                );
              })
        ],
      ),
    );
    // return a widget here (you have to return a widget to the builder)
  }
}
