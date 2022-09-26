import 'package:ahioma/config/ui_icons.dart';
import 'package:ahioma/src/models/product.dart';
import 'package:ahioma/src/models/route_argument.dart';
import 'package:ahioma/src/widgets/DrawerWidget.dart';
import 'package:ahioma/src/widgets/ProductDetailsTabWidget.dart';
import 'package:ahioma/src/widgets/ProductHomeTabWidget.dart';
import 'package:ahioma/main.dart';
import 'package:ahioma/src/widgets/ShoppingCartButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProductWidget extends StatefulWidget {
  RouteArgument routeArgument;
  Product _product;
  String _heroTag;

  ProductWidget({Key key, this.routeArgument}) {
    _product = this.routeArgument.argumentsList[0] as Product;
    _heroTag = this.routeArgument.argumentsList[1] as String;
  }

  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int quantity=1;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _tabIndex = 0;
  final storage = FlutterSecureStorage();
  var id;
  MyApp app =MyApp();
  getId()async{
    id = await storage.read(key:'id');
  }
  callBackAcct() {
    Navigator.of(context).pushNamed('/Product',
        arguments: new RouteArgument(argumentsList: [widget._product, widget._heroTag], id: widget._product.mainId));
  }
  ProductsList pro = ProductsList();
  Future<Product> getProdct() async {
    int id = int.parse(widget._product.mainId);
    Product prod = await pro.getProductById(id);
    return prod;
  }

  @override
  void initState() {
    _tabController =
        TabController(length: 2, initialIndex: _tabIndex, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _tabIndex = _tabController.index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.9),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).focusColor.withOpacity(0.15),
                blurRadius: 5,
                offset: Offset(0, -2)),
          ],
        ),
        child: Row(
          children: <Widget>[
//             Expanded(
//               child: FlatButton(
//                   onPressed: () {
//                     setState(() {
// //                      this.cartCount += this.quantity;
//                     });
//                   },
//                   padding: EdgeInsets.symmetric(vertical: 14),
//                   color: Theme.of(context).accentColor,
//                   shape: StadiumBorder(),
//                   child: Icon(
//                     UiIcons.heart,
//                     color: Theme.of(context).primaryColor,
//                   )),
//             ),
            SizedBox(width: 10),
            FlatButton(
              onPressed: () {
                setState(() {
//                    this.cartCount += this.quantity;
                });
              },
              color: Theme.of(context).accentColor,
              shape: StadiumBorder(),
              child: Container(
                width: 240,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        onPressed:() async{
                          var storage = FlutterSecureStorage();
                          var uId = await storage.read(key: 'id');
                          String it;
                          String ite;
                           AddToCart add =AddToCart();
                           int pId=int.parse(widget._product.mainId);

                          if (id == 'guest') {
                            Navigator.popAndPushNamed(context, '/SignUp',
                                arguments: (context) {
                                  Navigator.popAndPushNamed(context, '/Tabs',
                                      arguments: 2);
                                  Navigator.of(context).pushNamed('/Product',
                                      arguments: new RouteArgument(argumentsList: [this.widget._product, this.widget._heroTag], id: this.widget._product.mainId));
                                });
                          }
                           else{
                            await add.addToCat(pId, uId,  it, ite, quantity);
                            return _scaffoldKey.currentState
                                .showSnackBar(SnackBar(
                                duration: Duration(seconds: 5),
                                content:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(add.message),
                                    FlatButton(onPressed: (){ Navigator.of(context).pushNamed('/Cart');}, child: Text('Go to cart',style:TextStyle(color:Theme.of(context).primaryColor,)),color:Theme.of(context).accentColor,)
                                  ],
                                )
                            )
                            );
                          }

              },

                        child: Text(
                          'Add to Cart',
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if(quantity==1){
                          setState(() {
                           quantity=1;
                          });
                        }
                       else setState(() {
                         quantity--;
                        });
                      },
                      iconSize: 30,
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      icon: Icon(Icons.remove_circle_outline),
                      color: Theme.of(context).primaryColor,
                    ),
                    Text('$quantity',
                        style: Theme.of(context).textTheme.subhead.merge(
                            TextStyle(color: Theme.of(context).primaryColor))),
                    IconButton(
                      onPressed: () {
                        setState(() {
                         quantity++;
                        });
                      },
                      iconSize: 30,
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      icon: Icon(Icons.add_circle_outline),
                      color: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: getProdct(),
        builder: (BuildContext context, AsyncSnapshot<Product> snapshot) {
          if (!snapshot.hasData) return Container(child:CircularProgressIndicator(),alignment: Alignment.center,); // still loading
          // alternatively use snapshot.connectionState != ConnectionState.done
          Product pro = snapshot.data;

          return CustomScrollView(slivers: <Widget>[
            SliverAppBar(
//          snap: true,
              floating: true,
//          pinned: true,
              automaticallyImplyLeading: false,
              leading: new IconButton(
                icon: new Icon(UiIcons.return_icon,
                    color: Theme.of(context).hintColor),
                onPressed: () => Navigator.of(context).pop(),
              ),
              actions: <Widget>[
                FutureBuilder(future: getId(),
                    builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                      if (!snapshot.hasData) return Container(); // still loading
                      // alternatively use snapshot.connectionState != ConnectionState.done
                      // final User userID = snapshot.data;
                      // return a widget here (you have to return a widget to the builder)
                      return new ShoppingCartButtonWidget(
                          id: id,
                          iconColor: Theme.of(context).hintColor,
                          labelColor: Theme.of(context).accentColor);
                    })
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
              backgroundColor: Theme.of(context).primaryColor,
              expandedHeight: 350,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: Hero(
                  tag: widget._heroTag + widget.routeArgument.id,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.scaleDown,
                            image: NetworkImage(pro.image),
                          ),
                        ),
                      ),
                      // Container(
                      //   width: double.infinity,
                      //   decoration: BoxDecoration(
                      //       gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                      //     Theme.of(context).primaryColor,
                      //     Colors.white.withOpacity(0),
                      //     Colors.white.withOpacity(0),
                      //     Theme.of(context).scaffoldBackgroundColor
                      //   ], stops: [
                      //     0,
                      //     0.4,
                      //     0.6,
                      //     1
                      //   ])),
                      // ),
                    ],
                  ),
                ),
              ),
              bottom: TabBar(
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelPadding: EdgeInsets.symmetric(horizontal: 10),
                  unselectedLabelColor: Theme.of(context).accentColor,
                  labelColor: Theme.of(context).primaryColor,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Theme.of(context).accentColor),
                  tabs: [
                    Tab(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.2),
                                width: 1)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Product"),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.2),
                                width: 1)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Detail"),
                        ),
                      ),
                    ),
                    // Tab(
                    //   child: Container(
                    //     padding: EdgeInsets.symmetric(horizontal: 5),
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(50),
                    //         border: Border.all(
                    //             color: Theme.of(context)
                    //                 .accentColor
                    //                 .withOpacity(0.2),
                    //             width: 1)),
                    //     child: Align(
                    //       alignment: Alignment.center,
                    //       child: Text("Review"),
                    //     ),
                    //   ),
                    // ),
                  ]),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Offstage(
                  offstage: 0 != _tabIndex,
                  child: ProductHomeTabWidget(product: pro),
                ),
                Offstage(
                  offstage: 1 != _tabIndex,
                  child: Column(
                    children: <Widget>[
                      ProductDetailsTabWidget(
                        product: pro,
                      )
                    ],
                  ),
                ),
                // Offstage(
                //   offstage: 2 != _tabIndex,
                //   child: Column(
                //     children: <Widget>[
                //       Padding(
                //         padding: const EdgeInsets.symmetric(
                //             horizontal: 20, vertical: 15),
                //         child: ListTile(
                //           dense: true,
                //           contentPadding: EdgeInsets.symmetric(vertical: 0),
                //           leading: Icon(
                //             UiIcons.chat_1,
                //             color: Theme.of(context).hintColor,
                //           ),
                //           title: Text(
                //             'Product Reviews',
                //             overflow: TextOverflow.fade,
                //             softWrap: false,
                //             style: Theme.of(context).textTheme.display1,
                //           ),
                //         ),
                //       ),
                //       ReviewsListWidget()
                //     ],
                //   ),
                // )
              ]),
            )
          ]);
        },
      ),
    );
  }
}


