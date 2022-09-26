import 'package:ahioma/config/ui_icons.dart';
import 'package:ahioma/src/models/category.dart';
import 'package:ahioma/src/models/route_argument.dart';
import 'package:ahioma/src/widgets/DrawerWidget.dart';
import 'package:ahioma/src/widgets/ProductsByCategoryWidget.dart';
import 'package:ahioma/src/widgets/ShoppingCartButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ahioma/src/models/product.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CategoryWidget extends StatefulWidget {
  RouteArgument routeArgument;
  Category _category;

  SubCategoriesList _subCath = SubCategoriesList();
  CategoryWidget({Key key, this.routeArgument}) {
    _category = this.routeArgument.argumentsList[0] as Category;
    _subCath = this.routeArgument.argumentsList[1] as SubCategoriesList;
  }

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final ProductsList productList = ProductsList();
  final CategoriesList _categoriesList = CategoriesList();
  var products = <Product>[];
  int pageKey = 1;
  final _scrollController = ScrollController();
  final storage = FlutterSecureStorage();
  String id;
  Future <String> getId() async {
    id = await storage.read(key: 'login').toString();
    return id;
  }

  bool isLoading;
  final GlobalKey _key = GlobalKey();
  _onEndScroll() {
    setState(() {
      isLoading = true;
    });
    _fetchPage();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    print (widget.routeArgument.id);
    _scrollController.addListener(() {
      if (!isLoading &&
          _scrollController.position.maxScrollExtent ==
              _scrollController.offset) {
        _onEndScroll();
      }
    });
    _tabController = TabController(
        length: widget._subCath.subCath.length,
        initialIndex: widget.routeArgument.id,
        vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  Future<List<Product>> _fetchPage() async {


    // TODO: Implement the function's body.
    try {
      Response response = await get(
          Uri.parse(
              'http://api.ahioma.ng/api/v1/Products/GetAllProductsAsyncByPageSizeAndSubCategoryId?PageNumber=$pageKey&PageSize=20&id=${widget._category.subCath.elementAt(widget.routeArgument.id).id}'),
          headers: {"accept": "application/json"});
      var data = jsonDecode(response.body);
      for (var ite in data) {
        Product product = Product(
            mainId: ite['id'].toString(),
            name: ite['name'],
            image: ite['productPicture'],
            price: ite['price']);
        products.add(product);
      }
      productList.lisst = products;
      return products;
    } catch (e) {
      print(e);
    }
  }

  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _handleTabSelection() async {
    if (_tabController.indexIsChanging) {
      setState(() {
        widget.routeArgument.id = _tabController.index;
        productList.lisst = [];
        pageKey = 1;
      });

      productList.lisst = [];
      products = [];
      await _fetchPage();
      setState(() {
        productList.lisst = products;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (!snapshot.hasData)
                    return Container(
                        child: Center(
                            child:
                                CircularProgressIndicator())); // still loading
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
          backgroundColor: Theme.of(context).accentColor.withOpacity(0.9),
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
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                              color:
                                  Theme.of(context).hintColor.withOpacity(0.10),
                              offset: Offset(0, 4),
                              blurRadius: 10)
                        ],
                        gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              Theme.of(context).accentColor,
                              Theme.of(context).focusColor,
                            ])),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Hero(
                          tag: widget._category.id,
                          child: Icon(
                            widget._category.icon,
                            color: Theme.of(context).primaryColor,
                            size: 70,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          widget._category.name,
                          style: Theme.of(context).textTheme.title.merge(
                              TextStyle(color: Theme.of(context).primaryColor)),
                        )
                      ],
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
              )),
          bottom: TabBar(
            controller: _tabController,
            indicatorWeight: 5,
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelColor:
                Theme.of(context).primaryColor.withOpacity(0.6),
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w300),
            isScrollable: true,
            indicatorColor: Theme.of(context).primaryColor,
            tabs: List.generate(widget._category.subCath.length, (index) {
              return Tab(text: widget._category.subCath.elementAt(index).name);
            }),
          ),
        ),
        SliverToBoxAdapter(
          child: FutureBuilder(
              future: _fetchPage(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Product>> snapshot) {
                if (!snapshot.hasData)
                  return Container(
                      child: Center(
                          child: CircularProgressIndicator())); // still loading
                // alternatively use snapshot.connectionState != ConnectionState.done
                // final User userID = snapshot.data;
                // return a widget here (you have to return a widget to the builder)
                return ProductsByCategoryWidget(
                  subCategory: widget._subCath.subCath
                      .elementAt(widget.routeArgument.id),
                  productsList: productList,
                );
              }),
        )
      ]),
    );
  }
}
