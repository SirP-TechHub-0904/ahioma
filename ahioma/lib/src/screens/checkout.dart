import 'package:ahioma/config/ui_icons.dart';
import 'package:ahioma/src/widgets/CartViewWidget.dart';
import 'package:ahioma/src/widgets/ShoppingCartButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:ahioma/src/models/product.dart';
import 'package:ahioma/src/models/route_argument.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ahioma/src/services/ahia_pay_services.dart';
import 'package:http/http.dart';
import 'package:rave_flutter/rave_flutter.dart';
class CheckoutWidget extends StatefulWidget {
  RouteArgument routeAgrument;
  Address amount;
  CheckoutWidget({Key key, this.amount, this.routeAgrument}) {
    amount = this.routeAgrument.argumentsList[0] as Address;
  }
  @override
  _CheckoutWidgetState createState() => _CheckoutWidgetState();
}

class _CheckoutWidgetState extends State<CheckoutWidget> {
  CartItems list = CartItems();
  bool loading = false;
  int stat=5;
  int statt=4;
  AhiaPay payy;
  AhiaPay pay = AhiaPay();
  double sum = 0;
  double balance;
  double shipping;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  getWallet() async {
    var storage = FlutterSecureStorage();
    var id = await storage.read(key: 'id');
    AhiaPay wallet = await pay.getCurrentWallet(id);
    balance = double.parse(wallet.withdrawableBalance);
  }
  void startPayment(initCheckout checkout) async {
    double amt = double.parse(checkout.amount);
    var storage = FlutterSecureStorage();
    var id = await storage.read(key: 'id');
    var initializer = RavePayInitializer(

        amount: amt,
        publicKey: 'FLWPUBK-2441b9d4477112e505bfc756a3292c73-X',
        encryptionKey: '3ebc176be741462d7e4e490c',
        subAccounts: null)
      ..country = "NG"
      ..currency = "NGN"
      ..email = checkout.email
      ..fName = checkout.firstName
      ..lName = checkout.lastName
      ..narration = 'Order Payment'
      ..txRef = checkout.transRef
      ..orderRef = checkout.orderId
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
    if(response.status.toString()=='RaveStatus.cancelled'){
      // await put('http://api.ahioma.ng/api/CheckOut/ValidateCheckOut?uid=$id&source=checkout&tranxRef=${checkout.transRef}&status=$stat&orderid=${checkout.orderId}',
      //     headers: {"accept": "application/json"});
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text(response?.message)));
      setState(() {
        loading=false;
      });
    }
    else if (response.status.toString()=='RaveStatus.success') {
      Response responsed = await put(Uri.parse('http://api.ahioma.ng/api/CheckOut/ValidateCheckOut?uid=$id&source=checkout&tranxRef=${checkout.transRef}&status=$statt&orderid=${checkout.orderId}'),
          headers: {"accept": "application/json"});
      if (responsed.statusCode==200){
        Navigator.of(context).pushNamed('/CheckoutDone');
      }
    }else{
       // await put('http://api.ahioma.ng/api/CheckOut/ValidateCheckOut?uid=$id&source=checkout&tranxRef=${checkout.transRef}&status=$stat&orderid=${checkout.orderId}',
       //    headers: {"accept": "application/json"});
       _scaffoldKey.currentState
           .showSnackBar(SnackBar(content: Text('Transaction failed. Try again'),duration:Duration(seconds:3),));
       setState(() {
         loading=false;
       });
    }
    // _scaffoldKey.currentState
    //     .showSnackBar(SnackBar(content: Text(response?.message)));
  }
  Future<List<CartItems>> getItems() async {
    try {
      var storage = FlutterSecureStorage();
      var id = await storage.read(key: 'id');
      var ites = [];
      print(id);
      await getWallet();
      ites = await list.getCartItems(id);
      print(widget.amount.fullAddress);
      if (widget.amount.fullAddress.toString().toUpperCase().contains('OWERRI')==true){
        shipping=0.0;
      }
      else{
        shipping=list.shipping;
      }
      return ites;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
          'Checkout',
          style: Theme.of(context).textTheme.display1,
        ),
        actions: <Widget>[
          new ShoppingCartButtonWidget(
              iconColor: Theme.of(context).hintColor,
              labelColor: Theme.of(context).accentColor),
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
      body: FutureBuilder(
          future: getItems(),
          builder:
              (BuildContext context, AsyncSnapshot<List<CartItems>> snapshot) {
            if (!snapshot.hasData)
              return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator());
            if (loading==true)
              return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator());// still loading
            // alternatively use snapshot.connectionState != ConnectionState.done
            var listt = snapshot.data;
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      leading: Icon(
                        UiIcons.credit_card,
                        color: Theme.of(context).hintColor,
                      ),
                      title: Text(
                        'Payment Mode',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.display1,
                      ),
                      subtitle: Text(
                        'Confirm you order and checkout',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ListView(shrinkWrap: true, primary: false, children: <Widget>[
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
                            'Address',
                            style: Theme.of(context).textTheme.body1,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              '${widget.amount.fullAddress}',
                              overflow: TextOverflow.visible,
                              softWrap: true,
                              style: TextStyle(
                                  color: Theme.of(context).focusColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        primary: false,
                        itemCount: listt.length,
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 10);
                        },
                        itemBuilder: (context, index) {
                          CartItems ites = listt.elementAt(index);
                          sum = sum + (ites.quant * ites.price);
                          print(sum);
                          return CartViewWidget(
                            heroTag: 'orders_list',
                            order: listt.elementAt(index),
                            onDismissed: () {
                              setState(() {
                                listt.removeAt(index);
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ]),
                  SizedBox(height: 20),
                  Container(
                    height: 170,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.15),
                              offset: Offset(0, -2),
                              blurRadius: 5.0)
                        ]),
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  'Sub Total',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                              Text('${list.sum}',
                                  style: Theme.of(context).textTheme.bodyText1),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  'Delivery Fee',
                                  style: Theme.of(context).textTheme.body2,
                                ),
                              ),
                              Text('$shipping',
                                  style: Theme.of(context).textTheme.subhead),
                            ],
                          ),
                          SizedBox(height: 15),
                          Stack(
                            fit: StackFit.loose,
                            alignment: AlignmentDirectional.centerEnd,
                            children: <Widget>[
                              SizedBox(
                                width: 320,
                                child: Center(
                                  child: FlatButton(
                                    onPressed: () async {
                                      if ((list.sum + shipping) > balance) {
                                        return _scaffoldKey.currentState
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Insufficient funds in AhiaPay')));
                                      } else {
                                        setState(() {
                                          loading=true;
                                        });
                                        initCheckout checkout=initCheckout();
                                        var storage = FlutterSecureStorage();
                                        var id = await storage.read(key: 'id');
                                        checkout = await checkout.initCheckou(id, 'Pay with AhiaPay');

                                        Response response = await put(Uri.parse('http://api.ahioma.ng/api/CheckOut/ValidateCheckOut?uid=$id&source=${checkout.source}&transaction_id=${checkout.transId}&orderid=${checkout.orderId}&ahiapaystatus=${checkout.ahiaPayStat}&Ahia_transac_Id=${checkout.ahiaTransId}'),
                                            headers: {"accept": "application/json"});
                                        print(id);
                                        print(checkout.transId);
                                        print(checkout.source);
                                        print(checkout.ahiaPayStat);
                                        print(checkout.ahiaTransId);
                                        if (response.statusCode==200){
                                          Navigator.of(context).pushNamed('/CheckoutDone');
                                        }
                                        else{ setState(() {
                                          loading = false;
                                          return _scaffoldKey.currentState
                                              .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Error unable to checkout')));
                                        });

                                        }
                                      }
                                    },
                                    padding: EdgeInsets.symmetric(vertical: 14),
                                    color: Theme.of(context).hintColor,
                                    shape: StadiumBorder(),
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Text(
                                        'Pay with AhiaPay',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'Total: ${list.sum +shipping}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .merge(TextStyle(
                                          color:
                                              Theme.of(context).primaryColor)),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Stack(
                    fit: StackFit.loose,
                    alignment: AlignmentDirectional.centerEnd,
                    children: <Widget>[
                      SizedBox(
                        width: 320,
                        child: FlatButton(
                          onPressed: ()async {
                            setState(() {
                              loading=true;
                            });
                            initCheckout checkout=initCheckout();
                            var storage = FlutterSecureStorage();
                            var id = await storage.read(key: 'id');
                            checkout = await checkout.initCheckou(id, 'Pay with Card');
                            startPayment(checkout);
                          },
                          padding: EdgeInsets.symmetric(vertical: 14),
                          color: Theme.of(context).accentColor,
                          shape: StadiumBorder(),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Pay with credit card',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Total: ${list.sum + list.shipping}',
                          style: Theme.of(context).textTheme.headline6.merge(
                              TextStyle(color: Theme.of(context).primaryColor)),
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}
