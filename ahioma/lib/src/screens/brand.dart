import 'package:ahioma/config/ui_icons.dart';
import 'package:ahioma/src/models/market.dart';
import 'package:ahioma/src/models/route_argument.dart';
import 'package:ahioma/src/widgets/BrandHomeTabWidget.dart';
import 'package:ahioma/src/widgets/DrawerWidget.dart';
import 'package:ahioma/src/widgets/ReviewsListWidget.dart';
import 'package:ahioma/src/widgets/ShoppingCartButtonWidget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:ahioma/src/models/shop.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:ahioma/src/models/market.dart';

class BrandWidget extends StatefulWidget {
  RouteArgument routeArgument;
  Market _brand;

  BrandWidget({Key key, this.routeArgument}) {
    _brand = this.routeArgument.argumentsList[0] as Market;
  }

  @override
  _BrandWidgetState createState() => _BrandWidgetState();
}

class _BrandWidgetState extends State<BrandWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _tabIndex = 0;
  final storage = FlutterSecureStorage();
  var id;
  getId() async {
    id = await storage.read(key: 'login');
  }

  ShopsList shop = ShopsList();
  int pageNum = 1;
  bool loading;
  _onEndScroll() {
    setState(() {
      loading = true;
    });
    getShopsByMartId();
    // setState(() {
    //   pageNum++;
    //   loading = false;
    // });
  }

  Future<void> getShopsByMartId() async {
    try{
      loading = true;
      await shop.getShopsByMart(pageNum.toString(), widget._brand.id);
      setState(() {
        loading = false;
        pageNum++;
      });
    }
    catch(e){
      print(e);
    }

  }

  @override
  void initState() {

    _scrollController.addListener(() {
      if (!loading &&
          _scrollController.position.maxScrollExtent ==
              _scrollController.offset) {
        _onEndScroll();
      }
    });
    _tabController =
        TabController(length: 2, initialIndex: _tabIndex, vsync: this);
    _tabController.addListener(_handleTabSelection);
    getShopsByMartId();

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
    if (shop.lisst.isEmpty) {
      return Scaffold(
          key: _scaffoldKey,
          drawer: DrawerWidget(),
          body:
              CustomScrollView(controller: _scrollController, slivers: <Widget>[
            SliverAppBar(
              snap: true,
              floating: true,
              automaticallyImplyLeading: false,
              leading: new IconButton(
                icon: new Icon(UiIcons.return_icon,
                    color: Theme.of(context).primaryColor),
                onPressed: () => Navigator.of(context).pop(),
              ),
              actions: <Widget>[
                FutureBuilder(
                    future: getId(),
                    builder:
                        (BuildContext context, AsyncSnapshot<void> snapshot) {
                      if (!snapshot.hasData)
                        return Container(); // still loading
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
              backgroundColor: widget._brand.color,
              expandedHeight: 250,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: Stack(
                  children: <Widget>[
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                            widget._brand.color,
                            Theme.of(context).primaryColor.withOpacity(0.5),
                          ])),
                      child: Center(
                        child: Hero(
                          tag: widget._brand.id,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(
                                '${widget._brand.image}',
                                // color: Theme.of(context).primaryColor,
                                width: 80,
                              ),
                              ListTile(
                                dense: true,
                                // contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 0),
                                title: Text(
                                  widget._brand.name,
                                  style: Theme.of(context).textTheme.display1,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: -60,
                      bottom: -100,
                      child: Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(300),
                        ),
                      ),
                    ),
                    Positioned(
                      left: -30,
                      top: -80,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.09),
                          borderRadius: BorderRadius.circular(150),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              bottom: TabBar(
                controller: _tabController,
                indicatorWeight: 5,
                indicatorSize: TabBarIndicatorSize.label,
                unselectedLabelColor: Colors.black45,
                labelColor: Colors.black,
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w300),
                indicatorColor: Colors.black,
                tabs: [
                  Tab(text: 'Home'),
                  Tab(text: 'Shops'),
                ],
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([LinearProgressIndicator()]))
          ]));
    } else
      return Scaffold(
        key: _scaffoldKey,
        drawer: DrawerWidget(),
        body: CustomScrollView(controller: _scrollController, slivers: <Widget>[
          SliverAppBar(
            snap: true,
            floating: true,
            automaticallyImplyLeading: false,
            leading: new IconButton(
              icon: new Icon(UiIcons.return_icon,
                  color: Theme.of(context).primaryColor),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: <Widget>[
              FutureBuilder(
                  future: getId(),
                  builder:
                      (BuildContext context, AsyncSnapshot<void> snapshot) {
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
            backgroundColor: widget._brand.color,
            expandedHeight: 250,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                          widget._brand.color,
                          Theme.of(context).primaryColor.withOpacity(0.5),
                        ])),
                    child: Center(
                      child: Hero(
                        tag: widget._brand.id,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(
                              '${widget._brand.image}',
                              // color: Theme.of(context).primaryColor,
                              width: 80,
                            ),
                            ListTile(
                              dense: true,
                              // contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 0),
                              title: Text(
                                widget._brand.name,
                                style: Theme.of(context).textTheme.display1,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: -60,
                    bottom: -100,
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(300),
                      ),
                    ),
                  ),
                  Positioned(
                    left: -30,
                    top: -80,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.09),
                        borderRadius: BorderRadius.circular(150),
                      ),
                    ),
                  )
                ],
              ),
            ),
            bottom: TabBar(
              controller: _tabController,
              indicatorWeight: 5,
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelColor: Colors.black45,
              labelColor: Colors.black,
              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w300),
              indicatorColor: Colors.black,
              tabs: [
                Tab(text: 'Home'),
                Tab(text: 'Shops'),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Offstage(
                offstage: 0 != _tabIndex,
                child: Column(
                  children: <Widget>[
                    BrandHomeTabWidget(brand: widget._brand),
                  ],
                ),
              ),
              Offstage(
                offstage: 1 != _tabIndex,
                child: Container(
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
                      itemCount: shop.lisst.length,
                      itemBuilder: (BuildContext context, int index) {
                        Shop brand = shop.lisst.elementAt(index);
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
                                child: Hero(
                                  tag: brand.id,
                                  child: Image.network(
                                    '${brand.image}',
                                    // color: Theme.of(context).primaryColor,
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
                                      brand.name,
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
                                            '${brand.products.length} Products',
                                            style: Theme.of(context)
                                                .textTheme
                                                .body1,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
//                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(index % 2 == 0 ? 1 : 2),
                      staggeredTileBuilder: (int index) =>
                          new StaggeredTile.fit(1),
                      mainAxisSpacing: 15.0,
                      crossAxisSpacing: 15.0,
                    ),
                  ),
                ),
              ),
              Offstage(
                offstage: 2 != _tabIndex,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        leading: Icon(
                          UiIcons.chat_1,
                          color: Theme.of(context).hintColor,
                        ),
                        title: Text(
                          'Users Reviews',
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: Theme.of(context).textTheme.display1,
                        ),
                      ),
                    ),
                    ReviewsListWidget()
                  ],
                ),
              )
            ]),
          )
        ]),
      );
  }
}
