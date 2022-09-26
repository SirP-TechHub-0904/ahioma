import 'package:ahioma/config/ui_icons.dart';
import 'package:ahioma/src/models/brand.dart';
import 'package:ahioma/src/models/product.dart';
import 'package:ahioma/src/models/route_argument.dart';
import 'package:ahioma/src/models/shop.dart';
import 'package:ahioma/src/widgets/BrandHomeTabWidget.dart';
import 'package:ahioma/src/widgets/DrawerWidget.dart';
import 'package:ahioma/src/widgets/ProductGridItemWidget.dart';
import 'package:ahioma/src/widgets/ProductsByShopsWidget.dart';
import 'package:ahioma/src/widgets/ReviewsListWidget.dart';
import 'package:ahioma/src/widgets/ShopHomeTabWidget.dart';
import 'package:ahioma/src/widgets/ShoppingCartButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShopWidget extends StatefulWidget {
  RouteArgument routeArgument;
  Shop _brand;

  ShopWidget({Key key, this.routeArgument}) {
    _brand = this.routeArgument.argumentsList[0] as Shop;
  }

  @override
  _ShopWidgetState createState() => _ShopWidgetState();
}

class _ShopWidgetState extends State<ShopWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _tabIndex = 0;
  int pageNum=1;
  Shop shop=Shop();
  bool loading;
  ShopsList _list = ShopsList();
  ProductsList list = ProductsList();
  final _scrollController = ScrollController();
  _onEndScroll() async{
    setState(()  {
      loading = true;
    });
    await list.getProductByShopId(pageNum.toString(),widget._brand.id);
    setState(() {
      pageNum++;
      loading = false;
    });
  }
  Future<Shop> getShop() async {
    try{

      await _list.getShopById(widget._brand.id);
      widget._brand=_list.shopp;
      await list.getProductByShopId(pageNum.toString(),widget._brand.id);
      pageNum++;
      return _list.shopp;
    }
    catch (e){
      print (e);
      // print(widget._brand.id);

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
      body: CustomScrollView(controller:_scrollController,slivers: <Widget>[
        SliverAppBar(
          snap: true,
          floating: true,
          automaticallyImplyLeading: false,
          leading: new IconButton(
            icon: new Icon(UiIcons.return_icon, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: <Widget>[
            new ShoppingCartButtonWidget(
                iconColor: Colors.black,
                labelColor: Theme.of(context).hintColor),
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
                      child: Image.network(
                        '${widget._brand.image}',
                        // color: Theme.of(context).primaryColor,
                        width: 80,
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
            unselectedLabelColor:
                Theme.of(context).primaryColor.withOpacity(0.8),
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w300),
            indicatorColor: Theme.of(context).primaryColor,
            tabs: [
              Tab(text: 'Home'),
              Tab(text: 'Products'),
              // Tab(text: 'Reviews'),
            ],
          ),
        ),
        FutureBuilder(
            future: getShop(),
            builder: (BuildContext context, AsyncSnapshot<Shop> snapshot) {
              if (!snapshot.hasData) return Container(child: SliverList(delegate: SliverChildListDelegate([ LinearProgressIndicator()]))); // still loading
              // alternatively use snapshot.connectionState != ConnectionState.done
              Shop shop = snapshot.data;
              return SliverList(
                delegate: SliverChildListDelegate([
                  Offstage(
                    offstage: 0 != _tabIndex,
                    child: Column(
                      children: <Widget>[
                        ShopHomeTabWidget(brand: widget._brand),
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
                          itemCount: list.lisst.isEmpty?1:list.lisst.length,
                          itemBuilder: (BuildContext context, int index) {

                            if (list.lisst.isEmpty){
                              return Center(child: Container(child: Text('No Products to view'),));
                            }

                            else {
                              Product brand = list.lisst.elementAt(index);
                              return  ProductGridItemWidget(
                                product: brand,
                                heroTag: 'products_by_category_grid',
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
              );
            })
      ]),
    );
  }
}
