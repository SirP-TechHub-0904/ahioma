import 'package:ahioma/src/models/order.dart';
import 'package:ahioma/src/widgets/OrderDrawer.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ahioma/config/ui_icons.dart';
import 'package:ahioma/src/widgets/ShoppingCartButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ahioma/src/widgets/OrderListItemWidget.dart';

class OrdersWidget extends StatefulWidget {
  int currentTab;
  OrdersWidget({Key key, this.currentTab}) : super(key: key);
  @override
  _OrdersWidgetState createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {
  bool loading=false;
  bool isLoading=false;
  var uId;
  int pageNum=1;
  int pageNumm=1;
  int pageNummm=1;
  int pageNummmm=1;
  int pageNummmmm=1;
  OrderList list = OrderList();
  List<Order> processing =[];
  List<Order> cancled = [];
  List<Order> completed=[];
  List<Order> reversed=[];
  List<Order> outOfStock=[];
  final _scrollController = ScrollController();
  Future<void> getOderList() async {
  try{
    setState(() {
      loading=true;
    });
    var storage = FlutterSecureStorage();
    uId = await storage.read(key: 'id');
    completed = await list.getOrders(uId, pageNum, 1);
    pageNum++;
    processing = await list.getOrders(uId, pageNumm, 4);
    pageNumm++;
    reversed = await list.getOrders(uId, pageNummm,3);
    pageNummm++;
    cancled  = await list.getOrders(uId, pageNummmm, 6);
    pageNummmm++;
    outOfStock  = await list.getOrders(uId, pageNummmmm, 7);
    pageNummmmm++;

    setState(() {
      loading=false;
    });
  }
  catch(e){
print (e);
  }
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final OrderList _orderList = new OrderList();
  @override
  void initState() {
    getOderList();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
        initialIndex: widget.currentTab ?? 0,
        length: 5,
        child:  Builder(builder:(context) {
      final index = DefaultTabController.of(context).index;
      var item;
      _onEndScroll() async {

          isLoading = true;
          switch (index) {
            case 0:
              var lit = await list.getOrders(uId, pageNum, 1);
              for (item in lit){
                completed.add(item);
              }
              setState(() {
                isLoading=false;
                pageNum++;
              });

              break;
            case 1:
              var lit = await list.getOrders(uId, pageNumm, 4);
              for (item in lit){
                processing.add(item);
              }
              setState(() {
                isLoading=false;
                pageNumm++;
              });

              break;
            case 2:
              var lit = await list.getOrders(uId, pageNummm, 3);
              for (item in lit){
                reversed.add(item);
              }
              setState(() {
                isLoading=false;
                pageNummm++;
              });
              break;
            case 3:
              var lit = await list.getOrders(uId, pageNummmm, 6);
              for (item in lit){
                cancled.add(item);
              }
              setState(() {
                isLoading=false;
                pageNummmm++;
              });
              break;
            case 4:
              var lit = await list.getOrders(uId, pageNummmmm, 7);
              for (item in lit){
                outOfStock.add(item);
              }
              setState(() {
                isLoading=false;
                pageNummmmm++;
              });
              break;
          // case 5:
          //   name = 'Chat';
          //   widget.currentPage = ChatWidget();
          //   break;

          }
      }


      _scrollController.addListener(() {
        if (!isLoading &&
            _scrollController.position.maxScrollExtent ==
                _scrollController.offset) {
          _onEndScroll();
        }
      });
          return Scaffold(
             key: _scaffoldKey,
            drawer: OrderDrawerWidget(),
            appBar: AppBar(
              automaticallyImplyLeading: false,
//        leading: new IconButton(
//          icon: new Icon(UiIcons.return_icon, color: Theme.of(context).hintColor),
//          onPressed: () => Navigator.of(context).pop(),
//        ),
              leading: new IconButton(
                icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
                onPressed: () => _scaffoldKey.currentState.openDrawer(),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                'My Orders',
                style: Theme.of(context).textTheme.display1,
              ),
              actions: <Widget>[
                new ShoppingCartButtonWidget(
                    iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
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
              bottom: TabBar(
                  indicatorPadding: EdgeInsets.all(10),
                  labelPadding: EdgeInsets.symmetric(horizontal: 5),
                  unselectedLabelColor: Theme.of(context).accentColor,
                  labelColor: Theme.of(context).primaryColor,
                  isScrollable: true,
                  indicator: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Theme.of(context).accentColor),
                  tabs: [
                    Tab(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Theme.of(context).accentColor, width: 1)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Completed"),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Theme.of(context).accentColor, width: 1)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Processing"),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Theme.of(context).accentColor, width: 1)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Reversed"),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Theme.of(context).accentColor, width: 1)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Canceled"),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Theme.of(context).accentColor, width: 1)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Out of stock"),
                        ),
                      ),
                    ),
                  ]),
            ),
            body: TabBarView(
                children: [
              Column(
                children: [
                  Expanded(
                      child: StaggeredGridView.countBuilder(
                        controller: _scrollController,
                        primary: false,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 15),
                        crossAxisCount:
                        MediaQuery.of(context).orientation == Orientation.portrait
                            ? 1
                            : 2,
                        itemCount: completed.length,
                        itemBuilder: (BuildContext context, int index) {
                          Order market = completed.elementAt(index);
                          return OrderListItemWidget(order: market,heroTag: market.mainId);
                        },
//                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(index % 2 == 0 ? 1 : 2),
                        staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
                        mainAxisSpacing: 15.0,
                        crossAxisSpacing: 15.0,
                      )),
                ],
              ),
              Column(
                children: [
                  Expanded(
                      child: StaggeredGridView.countBuilder(
                        controller: _scrollController,
                        primary: false,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 15),
                        crossAxisCount:
                        MediaQuery.of(context).orientation == Orientation.portrait
                            ? 1
                            : 2,
                        itemCount: processing.length,
                        itemBuilder: (BuildContext context, int index) {
                          Order market = processing.elementAt(index);
                          return OrderListItemWidget(order: market,heroTag: market.mainId,);
                        },
//                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(index % 2 == 0 ? 1 : 2),
                        staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
                        mainAxisSpacing: 15.0,
                        crossAxisSpacing: 15.0,
                      )),
                ],
              ),
              Column(
                children: [
                  Expanded(
                      child: StaggeredGridView.countBuilder(
                        controller: _scrollController,
                        primary: false,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 15),
                        crossAxisCount:
                        MediaQuery.of(context).orientation == Orientation.portrait
                            ? 1
                            : 2,
                        itemCount: reversed.length,
                        itemBuilder: (BuildContext context, int index) {
                          Order market = reversed.elementAt(index);
                          return OrderListItemWidget(order: market,heroTag: market.mainId);
                        },
//                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(index % 2 == 0 ? 1 : 2),
                        staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
                        mainAxisSpacing: 15.0,
                        crossAxisSpacing: 15.0,
                      )),
                ],
              ),
              Column(
                children: [
                  Expanded(
                      child: StaggeredGridView.countBuilder(
                        controller: _scrollController,
                        primary: false,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 15),
                        crossAxisCount:
                        MediaQuery.of(context).orientation == Orientation.portrait
                            ? 1
                            : 2,
                        itemCount: cancled.length,
                        itemBuilder: (BuildContext context, int index) {
                          Order market = cancled.elementAt(index);
                          return OrderListItemWidget(order: market,heroTag: market.mainId);
                        },
//                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(index % 2 == 0 ? 1 : 2),
                        staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
                        mainAxisSpacing: 15.0,
                        crossAxisSpacing: 15.0,
                      )),
                ],
              ),
              Column(
                children: [
                  Expanded(
                      child: StaggeredGridView.countBuilder(
                        controller: _scrollController,
                        primary: false,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 15),
                        crossAxisCount:
                        MediaQuery.of(context).orientation == Orientation.portrait
                            ? 1
                            : 2,
                        itemCount: outOfStock.length,
                        itemBuilder: (BuildContext context, int index) {
                          Order market = outOfStock.elementAt(index);
                          return  OrderListItemWidget(order: market,heroTag: market.mainId);
                        },
//                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(index % 2 == 0 ? 1 : 2),
                        staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
                        mainAxisSpacing: 15.0,
                        crossAxisSpacing: 15.0,
                      )),
                ],
              ),
            ]),
          );
        }));
  }
}
