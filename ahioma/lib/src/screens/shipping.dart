import 'package:ahioma/config/ui_icons.dart';
import 'package:ahioma/src/models/product.dart';
import 'package:ahioma/src/widgets/CartItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ahioma/src/models/route_argument.dart';

class ShippingWidget extends StatefulWidget {
  @override
  _ShippingWidgetState createState() => _ShippingWidgetState();
}

class _ShippingWidgetState extends State<ShippingWidget> {
  ProductsList _productsList;
  final ValueNotifier<int> loadig = ValueNotifier<int>(0);
  Address adde = Address();
  double sum = 0;
  String card = 'Pay with Card';
  String aPay = 'Pay with AhiaPay';
  List<Address> listt;
  List<String> payMeth;
  String payMetho;
  Address dropdownValue;
  bool loading = false;
  bool checkedValue = false;
  final street = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  String deliveryMethod = 'AhiaXpress Delivery';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Address ade;
  Future<List<Address>> getItems() async {
    try {
      var storage = FlutterSecureStorage();
      var id = await storage.read(key: 'id');
      List<Address> ites;
      ites = await adde.getAdList(id);
      return ites;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _productsList = new ProductsList();
    payMeth = [card, aPay];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SizedBox buildAddress(Address payMethod) {
      return SizedBox(
        child: RadioListTile<Address>(
          title: Text('${payMethod.fullAddress}'),
          value: payMethod,
          groupValue: ade,
          onChanged: (Address value) async {
            await get(
                Uri.parse('http://api.ahioma.ng/api/CheckOut/MakeDefaultAddress?uid=${payMethod.uId}&aid=${payMethod.aId}'),
                headers: {"accept": "application/json"});
            ade = value;
            loadig.value += 1;
          },
        ),
      );
    }

    SizedBox buildColor(String payMethod) {
      return SizedBox(
        child: RadioListTile<String>(
          title: Text(payMethod),
          value: payMethod,
          groupValue: payMetho,
          onChanged: (String value) {
            setState(() {
              payMetho = value;
            });
          },
        ),
      );
    }

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
            'Shipping',
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
              margin: EdgeInsets.only(bottom: 130),
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
                          'Verify your Shipping details and click continue',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ),
                    Container(
                      child: CircularProgressIndicator(),
                      alignment: Alignment.center,
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
                                Navigator.of(context).pushNamed('/Checkout');
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
          'Shipping',
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.only(bottom: 15),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 10),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        subtitle: Text(
                          'verify and click continue',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ),
                    FutureBuilder(
                      future: getItems(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Address>> snapshot) {
                        if (!snapshot.hasData)
                          return Container(
                              alignment: Alignment.center,
                              child:
                                  CircularProgressIndicator()); // still loading
                        // alternatively use snapshot.connectionState != ConnectionState.done
                        listt = snapshot.data;
                        return ListView(
                            shrinkWrap: true,
                            primary: false,
                            children: <Widget>[
                              // Column(
                              //   children: [
                              //     DropdownButton<Address>(
                              //     value: dropdownValue,
                              //         icon: Icon(Icons.arrow_downward),
                              //         iconSize: 24,
                              //         elevation: 16,
                              //         style: TextStyle(color: Colors.deepPurple),
                              //         underline: Container(
                              //           height: 2,
                              //           color: Colors.deepPurpleAccent,
                              //         ),
                              //         onChanged: (Address newValue) async{
                              //        await get('http://api.ahioma.ng/api/CheckOut/MakeDefaultAddress?uid=${newValue.uId}&aid=${newValue.aId}',
                              //               headers: {"accept": "application/json"});
                              //           setState(() {
                              //             dropdownValue = newValue;
                              //           });
                              //         },
                              //         items: listt
                              //             .map<DropdownMenuItem<Address>>((Address value) {
                              //           return DropdownMenuItem<Address>(
                              //             value: value,
                              //             child: Expanded(
                              //               child: Column(
                              //                 children: [
                              //                   Text('${value.fullAddress}'),
                              //                 ],
                              //               ),
                              //             ),
                              //           );
                              //         }).toList(),
                              //     ),
                              //   ],
                              // ),
                              ValueListenableBuilder(
                                  builder: (BuildContext context, int value,
                                      Widget child) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          SizedBox(height: 5),
                                          Text('Address',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .display1),
                                          SizedBox(height: 20),
                                          Wrap(
                                            spacing: 8,
                                            runSpacing: 8,
                                            children: List.generate(
                                                listt.length, (index) {
                                              Address _color =
                                                  listt.elementAt(index);
                                              return buildAddress(_color);
                                            }),
                                          ),
                                          FlatButton(child: Text('Add new address',style: TextStyle(color: Colors.white),),onPressed: (){
                                            Navigator.of(context).pushNamed('/Address');
                                          },color: Theme.of(context).accentColor,)
                                        ],
                                      ),
                                    );
                                  },
                                  valueListenable: loadig),

                              // CheckboxListTile(
                              //   title: Text("Use your default address instead"),
                              //   value: checkedValue,
                              //   onChanged: (newValue) {
                              //     setState(() {
                              //       checkedValue = newValue;
                              //     });
                              //     //
                              //   },
                              //   controlAffinity: ListTileControlAffinity
                              //       .leading, //  <-- leading Checkbox
                              // ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    SizedBox(height: 25),
                                    Text('Delivery Method',
                                        style: Theme.of(context)
                                            .textTheme
                                            .display1),
                                    SizedBox(height: 20),
                                    RadioListTile<String>(
                                      title: Text(deliveryMethod),
                                      value: deliveryMethod,
                                      groupValue: deliveryMethod,
                                      onChanged: (String value) {
                                        setState(() {
                                          deliveryMethod = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),

                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Column(
                              //     children: [
                              //       SizedBox(height: 25),
                              //       Text('Payment Method',
                              //           style:
                              //               Theme.of(context).textTheme.display1),
                              //       SizedBox(height: 20),
                              //       Wrap(
                              //         spacing: 8,
                              //         runSpacing: 8,
                              //         children:
                              //             List.generate(payMeth.length, (index) {
                              //           String _color = payMeth.elementAt(index);
                              //           return buildColor(_color);
                              //         }),
                              //       ),
                              //     ],
                              //   ),
                              // )
                            ]);
                      },
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.15),
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
                                      if (ade == null) {
                                        return _scaffoldKey.currentState
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Address can\'t be empty')));
                                      }
                                      else Navigator.of(context).pushNamed(
                                          '/Checkout',
                                          arguments: RouteArgument(
                                              argumentsList: [ade]));
                                    },
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                    color: Theme.of(context).accentColor,
                                    shape: StadiumBorder(),
                                    child: Text(
                                      'Continue',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
      ),
    );
  }
}
