import 'package:ahioma/config/ui_icons.dart';
import 'package:ahioma/src/models/product.dart';
import 'package:ahioma/src/widgets/CartItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CartWidget extends StatefulWidget {
  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  ProductsList _productsList;
  CartItems list = CartItems();
  double sum = 0;
  bool loading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var ites = [];
  Future<List<CartItems>> getItems() async {
    try {
      var storage = FlutterSecureStorage();
      var id = await storage.read(key: 'id');
      print(id);
      ites = await list.getCartItems(id);
      return ites;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _productsList = new ProductsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (loading == true) {
      return Scaffold(

        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: new IconButton(
            icon: new Icon(UiIcons.return_icon,
                color: Theme.of(context).hintColor),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Cart',
            style: Theme.of(context).textTheme.display1,
          ),
          actions: <Widget>[
            // Container(
            //     width: 30,
            //     height: 30,
            //     margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
            //     child: InkWell(
            //       borderRadius: BorderRadius.circular(300),
            //       onTap: () {
            //         Navigator.of(context).pushNamed('/Tabs', arguments: 1);
            //       },
            //       child: CircleAvatar(
            //         backgroundImage: AssetImage('img/user2.jpg'),
            //       ),
            //     )),
          ],
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 50),
              padding: EdgeInsets.only(bottom: 15),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 10),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        subtitle: Text(
                          'Verify your quantity and click continue',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ),
                    Container(child: CircularProgressIndicator(),alignment:Alignment.center,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 170,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).focusColor.withOpacity(0.15),
                          offset: Offset(0, -2),
                          blurRadius: 5.0)
                    ]),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      // Row(
                      //   children: <Widget>[
                      //     Expanded(
                      //       child: Text(
                      //         'Total',
                      //         style: Theme.of(context).textTheme.body2,
                      //       ),
                      //     ),
                      //     Text('$sum',
                      //         style: Theme.of(context).textTheme.subhead),
                      //   ],
                      // ),
                      // SizedBox(height: 5),
                      // Row(
                      //   children: <Widget>[
                      //     Expanded(
                      //       child: Text(
                      //         'TAX (20%)',
                      //         style: Theme.of(context).textTheme.body2,
                      //       ),
                      //     ),
                      //     Text('\$13.23',
                      //         style: Theme.of(context).textTheme.subhead),
                      //   ],
                      // ),
                      SizedBox(height: 10),
                      Stack(
                        fit: StackFit.loose,
                        alignment: AlignmentDirectional.centerEnd,
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 40,
                            child: FlatButton(
                              onPressed: () {

                              },
                              padding: EdgeInsets.symmetric(vertical: 14),
                              color: Theme.of(context).accentColor,
                              shape: StadiumBorder(),
                              child: Text(
                                'Continue',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon:
              new Icon(UiIcons.return_icon, color: Theme.of(context).hintColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.display1,
        ),
        actions: <Widget>[
          // Container(
          //     width: 30,
          //     height: 30,
          //     margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
          //     child: InkWell(
          //       borderRadius: BorderRadius.circular(300),
          //       onTap: () {
          //         Navigator.of(context).pushNamed('/Tabs', arguments: 1);
          //       },
          //       child: CircleAvatar(
          //         backgroundImage: AssetImage('img/user2.jpg'),
          //       ),
          //     )),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 150),
            padding: EdgeInsets.only(bottom: 15),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      leading: Icon(
                        UiIcons.shopping_cart,
                        color: Theme.of(context).hintColor,
                      ),
                      title: Text(
                        'Shopping Cart',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.display1,
                      ),
                      subtitle: Text(
                        'Verify your quantity and click continue',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ),
                  FutureBuilder(
                    future: getItems(),
                    builder:
                        (BuildContext context, AsyncSnapshot<List> snapshot) {
                      if (!snapshot.hasData)
                        return Container(
                           alignment:Alignment.center,
                            child:
                                CircularProgressIndicator()); // still loading
                      // alternatively use snapshot.connectionState != ConnectionState.done
                      var listt = snapshot.data;
                      return ListView.separated(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        primary: false,
                        itemCount: listt.length,
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 15);
                        },
                        itemBuilder: (context, index) {
                          CartItems item = listt.elementAt(index);
                          double subtotl = item.quant * item.price;
                          sum = sum + subtotl;
                          print(item.cartId);
                          return CartItemWidget(
                            product: listt.elementAt(index),
                            heroTag: 'cart',
                            onDismissed: () async {
                              setState(() {
                                loading = true;
                              });
                              await get(
                                  Uri.parse('http://api.ahioma.ng/api/v1/Carts/RemoveCart?cid=${item.cartId}'),
                                  headers: {"accept": "application/json"});
                              setState(() {
                                loading = false;
                                listt.removeAt(index);
                              });
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 170,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).focusColor.withOpacity(0.15),
                        offset: Offset(0, -2),
                        blurRadius: 5.0)
                  ]),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    // Row(
                    //   children: <Widget>[
                    //     Expanded(
                    //       child: Text(
                    //         'Total',
                    //         style: Theme.of(context).textTheme.body2,
                    //       ),
                    //     ),
                    //     Text('$sum',
                    //         style: Theme.of(context).textTheme.subhead),
                    //   ],
                    // ),
                    // SizedBox(height: 5),
                    // Row(
                    //   children: <Widget>[
                    //     Expanded(
                    //       child: Text(
                    //         'TAX (20%)',
                    //         style: Theme.of(context).textTheme.body2,
                    //       ),
                    //     ),
                    //     Text('\$13.23',
                    //         style: Theme.of(context).textTheme.subhead),
                    //   ],
                    // ),
                    SizedBox(height: 10),
                    Stack(
                      fit: StackFit.loose,
                      alignment: AlignmentDirectional.centerEnd,
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 40,
                          child: FlatButton(
                            onPressed: () {
                              if(ites.isEmpty){
                                return _scaffoldKey.currentState
                                    .showSnackBar(SnackBar(
                                    content: Text(
                                        'Cart is still empty')));
                              }
                              else Navigator.of(context).pushNamed('/Shipping');
                            },
                            padding: EdgeInsets.symmetric(vertical: 14),
                            color: Theme.of(context).accentColor,
                            shape: StadiumBorder(),
                            child: Text(
                              'Continue',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
