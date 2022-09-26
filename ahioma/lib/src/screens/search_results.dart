import 'package:ahioma/config/ui_icons.dart';
import 'package:ahioma/src/models/market.dart';
import 'package:ahioma/src/models/order.dart';
import 'package:ahioma/src/models/product.dart';
import 'package:ahioma/src/models/route_argument.dart';
import 'package:ahioma/src/models/shop.dart';
import 'package:ahioma/src/screens/orders_products.dart';
import 'package:ahioma/src/services/search_service.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ahioma/src/widgets/DrawerWidget.dart';
import 'package:ahioma/src/widgets/MarketGridWidget.dart';
import 'package:ahioma/src/widgets/ProductGridItemWidget.dart';
import 'package:ahioma/src/widgets/SearchBarWidget.dart';
import 'package:ahioma/src/widgets/ShoppingCartButtonWidget.dart';
import 'package:ahioma/src/services/home_service.dart';
import 'package:flutter/material.dart';

import 'package:ahioma/src/widgets/ShopsGridWidget.dart';

class SearchResultWidget extends StatefulWidget {
  int currentTab;
  RouteArgument routeArgument;
  SearchValue _value;
  SearchResultWidget({Key key, this.routeArgument}) : super(key: key) {
    _value = this.routeArgument.argumentsList[0] as SearchValue;
  }

  @override
  _SearchResultWidgetState createState() => _SearchResultWidgetState();
}

class _SearchResultWidgetState extends State<SearchResultWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final OrderList _orderList = new OrderList();
  final SearchService search = SearchService();
  List<Product> _productsList = [];
  String searchWord;
  bool loaded;
  final searrch = TextEditingController();
  final SearchValue alue = SearchValue();
  final _scrollController = ScrollController();
  HomeMarket mart = HomeMarket();
  final _formKey = GlobalKey<FormState>();
  ShopsList brandsList;
  bool isLoading = false;
  int pageKey = 1;
  _onEndScroll() {
    setState(() {
      isLoading = true;
    });
    getResults();
    setState(() {
      pageKey++;
      isLoading = false;
      loaded=true;
    });
  }

  Future getResults() async {
    await search.getSearchProductsPagi(searchWord, pageKey.toString());
    setState(() {
      _productsList = search.lisst;
      mart.lisst = search.mart;
      loaded=true;
    });

  }

  Future getResultsMain() async {
    await search.getSearchProductsMain(widget._value.value, pageKey.toString());
    setState(() {
      _productsList = search.lisst;
      mart.lisst = search.mart;
      searchWord = widget._value.value;
      loaded=true;
      pageKey++;
    });

  }

  Future getResult() async {
    setState(() {
      _productsList = [];
      pageKey = 1;
      searchWord = searrch.text;
    });
    await search.getSearchProducts(searrch.text, pageKey.toString());
    setState(() {
      _productsList = search.lisst;
      mart.lisst = search.mart;
      loaded=true;
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    _scrollController.addListener(() {
      if (!isLoading &&
          _scrollController.position.maxScrollExtent ==
              _scrollController.offset) {
        _onEndScroll();
        loaded=false;
      }
    });
    getResultsMain();
    loaded=false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: widget.currentTab ?? 0,
        length: 3,
        child: Scaffold(
          key: _scaffoldKey,
          drawer: DrawerWidget(),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: new IconButton(
              icon: new Icon(UiIcons.return_icon,
                  color: Theme.of(context).hintColor),
              onPressed: () => Navigator.of(context).pop(),
            ),
//             leading: new IconButton(
//               icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
//               onPressed: () => _scaffoldKey.currentState.openDrawer(),
//             ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            // title: Text(
            //   'Search Results',
            //   style: Theme.of(context).textTheme.display1,
            // ),
            actions: <Widget>[
              Container(
                width: 250,
                margin: EdgeInsets.only(top: 10, bottom: 10, right: 20),
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        onFieldSubmitted: (value) {
                          if (_formKey.currentState.validate()) {
                            alue.value = searrch.text;
                            pageKey = 1;
                            getResult();
                            loaded=false;
                          }
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }

                          return null;
                        },
                        controller: searrch,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(
                              color:
                                  Theme.of(context).focusColor.withOpacity(0.8),
                              fontSize: 15),
                          prefixIcon: Icon(UiIcons.loupe,
                              size: 15, color: Theme.of(context).hintColor),
                          border:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          enabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          focusedBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      icon: Icon(UiIcons.settings_2,
                          size: 15,
                          color: Theme.of(context).hintColor.withOpacity(0.5)),
                    ),
                  ],
                ),
              )
            ],
            bottom: TabBar(
                indicatorPadding: EdgeInsets.all(1),
                labelPadding: EdgeInsets.symmetric(horizontal: 5),
                unselectedLabelColor: Theme.of(context).accentColor,
                labelColor: Theme.of(context).primaryColor,
                isScrollable: true,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).accentColor),
                tabs: [
                  Tab(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              color: Theme.of(context).accentColor, width: 1)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Products"),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              color: Theme.of(context).accentColor, width: 1)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Shops"),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              color: Theme.of(context).accentColor, width: 1)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Markets"),
                      ),
                    ),
                  ),
                ]),
          ),
          body: TabBarView(children: [
            Column(
              children: <Widget>[
                SizedBox(height: 15),
                Text(
                  'Search Results for "${search.valu}" ',
                  style: Theme.of(context).textTheme.display1,
                ),
                Text(
                  'in Products',
                  style: TextStyle(
                    fontSize: 13.0,
                  ),
                ),
                SizedBox(height: 15),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: StaggeredGridView.countBuilder(
                      controller: _scrollController,
                      primary: false,
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      itemCount: _productsList.isEmpty?1:_productsList.length,
                      itemBuilder: (BuildContext context, int index) {

                        if (_productsList.isEmpty&&loaded==true){
                          return Center(child: Container(child:Text('No products found')));
                        }
                        else if (_productsList.isEmpty){
                          return Center(child: Container(child:CircularProgressIndicator()));
                        }
                        else {
                          Product product = _productsList.elementAt(index);
                          return ProductGridItemWidget(
                            product: product,
                            heroTag: product.mainId,
                          );
                        }
                      },
//                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(index % 2 == 0 ? 1 : 2),
                      staggeredTileBuilder: (int index) =>
                          new StaggeredTile.fit(2),
                      mainAxisSpacing: 15.0,
                      crossAxisSpacing: 15.0,
                    ),
                  ),
                ),
              ],
            ),
            Column(children: <Widget>[
              SizedBox(height: 15),
              Text(
                'Search Results for "${search.valu}" ',
                style: Theme.of(context).textTheme.display1,
              ),
              Text(
                'in Shops',
                style: TextStyle(
                  fontSize: 13.0,
                ),
              ),
              SizedBox(height: 15),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: StaggeredGridView.countBuilder(
                    primary: false,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 15),
                    crossAxisCount: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? 2
                        : 4,
                    itemCount:search.list.isEmpty?1: search.list.length,
                    itemBuilder: (BuildContext context, int index) {

                       if (search.list.isEmpty&&loaded==true){
                        return Center(child: Container(child:Text('No shops found')));
                      }
                       else if (search.list.isEmpty){
                         return Center(child: Container(child:CircularProgressIndicator()));
                       }
                      else {
                        Shop brand = search.list.elementAt(index);
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('/Shop',
                                arguments: new RouteArgument(
                                    id: brand.id, argumentsList: [brand]));
                          },
                          child: Stack(
                            alignment: AlignmentDirectional.topCenter,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(10),
                                alignment: AlignmentDirectional.topCenter,
                                padding: EdgeInsets.all(20),
                                width: double.infinity,
                                height: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Theme.of(context)
                                              .hintColor
                                              .withOpacity(0.10),
                                          offset: Offset(0, 4),
                                          blurRadius: 10)
                                    ],
                                    gradient: LinearGradient(
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight,
                                        colors: [
                                          brand.color,
                                          brand.color.withOpacity(0.2),
                                        ])),
                              ),
                              Positioned(
                                right: -50,
                                bottom: -100,
                                child: Container(
                                  width: 220,
                                  height: 220,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.08),
                                    borderRadius: BorderRadius.circular(150),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: -30,
                                top: -60,
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(150),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 80, bottom: 10),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                width: 140,
                                height: 80,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(6),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Theme.of(context)
                                              .hintColor
                                              .withOpacity(0.15),
                                          offset: Offset(0, 3),
                                          blurRadius: 10)
                                    ]),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      brand.name,
                                      style: Theme.of(context).textTheme.body2,
                                      maxLines: 1,
                                      softWrap: false,
                                      overflow: TextOverflow.fade,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        // The title of the product
                                        // Expanded(
                                        //   child: Text(
                                        //     '${brand.products.length} Products',
                                        //     style: Theme.of(context).textTheme.body1,
                                        //     overflow: TextOverflow.fade,
                                        //     softWrap: false,
                                        //   ),
                                        // ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 18,
                                        ),
                                        // Text(
                                        //   brand.rate.toString(),
                                        //   style: Theme.of(context).textTheme.body2,
                                        // )
                                      ],
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                    },
//                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(index % 2 == 0 ? 1 : 2),
                    staggeredTileBuilder: (int index) =>
                        new StaggeredTile.fit(1),
                    mainAxisSpacing: 15.0,
                    crossAxisSpacing: 15.0,
                  ),
                ),
              )
            ]),
            Column(children: <Widget>[
              SizedBox(height: 15),
              Text(
                'Search Results for "${search.valu}" ',
                style: Theme.of(context).textTheme.display1,
              ),
              Text(
                'in Markets',
                style: TextStyle(
                  fontSize: 13.0,
                ),
              ),
              SizedBox(height: 15),
              Expanded(
                  child: StaggeredGridView.countBuilder(
                primary: false,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 15),
                crossAxisCount:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? 2
                        : 4,
                itemCount:search.mart.isEmpty?1: search.mart.length,
                itemBuilder: (BuildContext context, int index) {
                   if (search.mart.isEmpty&&loaded==true){
                    return Center(child: Container(child:Text('No markets found')));
                  }
                   else if (search.mart.isEmpty){
                     return Center(child: Container(child:CircularProgressIndicator()));
                   }
                  else {
                    Market market = search.mart.elementAt(index);
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed('/Brand',
                            arguments: new RouteArgument(
                                id: market.id, argumentsList: [market]));
                      },
                      child: Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(10),
                            alignment: AlignmentDirectional.topCenter,
                            padding: EdgeInsets.all(20),
                            width: double.infinity,
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context)
                                          .hintColor
                                          .withOpacity(0.10),
                                      offset: Offset(0, 4),
                                      blurRadius: 10)
                                ],
                                gradient: LinearGradient(
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                    colors: [
                                      market.color,
                                      market.color.withOpacity(0.2),
                                    ])),
                            child: Hero(
                              tag: market.id,
                              child: Image.network(
                                '${market.image}',
                                // color: Theme.of(context).primaryColor,
                                width: 80,
                              ),
                            ),
                          ),
                          Positioned(
                            right: -50,
                            bottom: -100,
                            child: Container(
                              width: 220,
                              height: 220,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.08),
                                borderRadius: BorderRadius.circular(150),
                              ),
                            ),
                          ),
                          Positioned(
                            left: -30,
                            top: -60,
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.12),
                                borderRadius: BorderRadius.circular(150),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 80, bottom: 10),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            width: 140,
                            height: 80,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context)
                                          .hintColor
                                          .withOpacity(0.15),
                                      offset: Offset(0, 3),
                                      blurRadius: 10)
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '${market.name}',
                                  style: Theme.of(context).textTheme.body2,
                                  maxLines: 1,
                                  softWrap: false,
                                  overflow: TextOverflow.fade,
                                ),
                                Row(
                                  children: <Widget>[
                                    // The title of the product
                                    Expanded(
                                      child: Text(
                                        '${market.state}',
                                        style: Theme.of(context).textTheme.body1,
                                        overflow: TextOverflow.fade,
                                        softWrap: false,
                                      ),
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 18,
                                    ),
                                    // Text(
                                    //   brand.rate.toString(),
                                    //   style: Theme.of(context).textTheme.body2,
                                    // )
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
//                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(index % 2 == 0 ? 1 : 2),
                staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
                mainAxisSpacing: 15.0,
                crossAxisSpacing: 15.0,
              ))
            ]),
          ]),
        ));
  }
}
