import 'package:ahioma/config/ui_icons.dart';
import 'package:ahioma/src/screens/account.dart';
import 'package:ahioma/src/screens/chat.dart';
import 'package:ahioma/src/screens/favorites.dart';
import 'package:ahioma/src/screens/home.dart';
import 'package:ahioma/src/screens/brands.dart';
import 'package:ahioma/src/screens/messages.dart';
import 'package:ahioma/src/screens/categories.dart';
import 'package:ahioma/src/screens/orders.dart';
import 'package:ahioma/src/widgets/DrawerWidget.dart';
import 'package:ahioma/src/widgets/FilterWidget.dart';
import 'package:ahioma/src/widgets/ShoppingCartButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:ahioma/src/screens/ahia_pay.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// ignore: must_be_immutable

class MyPageViewWidget extends StatefulWidget {
  final pageController;
  final Function(int pageIndex) onPageChanged;
  List<Widget> children;
  MyPageViewWidget({this.pageController, this.onPageChanged, this.children});
  @override
  _MyPageViewWidgetState createState() => _MyPageViewWidgetState();
}

class _MyPageViewWidgetState extends State<MyPageViewWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      children: widget.children,
      controller: widget.pageController,
      onPageChanged: (index) {
        widget.onPageChanged(index);
      },
    );
  }
}

class TabsWidget extends StatefulWidget {
  int currentTab;
  // int selectedTab = 2;
  // String currentTitle = 'Home';
  // Widget currentPage = HomeWidget();
  //
  TabsWidget({
    Key key,
    this.currentTab,
  }) : super(key: key);

  @override
  _TabsWidgetState createState() {
    return _TabsWidgetState();
  }
}

class _TabsWidgetState extends State<TabsWidget> {
  final GlobalKey<ScaffoldState> _scaffolKey = new GlobalKey<ScaffoldState>();
  int _currentIndex = 2;
  var id;
  final storage = FlutterSecureStorage();
 void callBackAcct() {
     Navigator.popAndPushNamed(context, '/Tabs', arguments: 1);
  }

  callBackAp() {
    Navigator.popAndPushNamed(context, '/Tabs', arguments: 3);
  }

  Future<String> getId() async {
    try {
      id = await storage.read(key: 'id');
      print("id is $id");
      return id;
    } catch (e) {
      print(e);
    }
  }

  String name;
  List<Widget> _children;
  void tabName(tabItem) {
    switch (tabItem) {
      case 0:
        name = 'Markets';
        break;
      case 1:
        name = 'Account';

        break;
      case 2:
        name = 'Home';
        break;
      case 3:
        name = 'AhiaPay';
        break;
      case 4:
        name = 'Categories';
        break;
      case 5:
        name = 'Chat';
        break;
      case 6:
        name = 'My Orders';
        break;
    }
  }

  PageController pageController = PageController();
  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
      tabName(index);
    });
  }

  @override
  initState() {
    getId();
    int name = 2;
    _children = [
      BrandsWidget(),
      AccountWidget(),
      HomeWidget(),
      AhiaPayWidget(),
      CategoriesWidget(),
      ChatWidget(),
      OrdersWidget()
    ];
    if (widget.currentTab != null) {
      tabName(widget.currentTab);

    }
    print(widget.currentTab);
    pageController = PageController(initialPage: widget.currentTab);

    super.initState();
  }

  // @override
  // void didUpdateWidget(TabsWidget oldWidget) {
  //   _selectTab(oldWidget.currentTab);
  //   super.didUpdateWidget(oldWidget);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffolKey,
      drawer: DrawerWidget(control: pageController),
      endDrawer: FilterWidget(),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
          onPressed: () => _scaffolKey.currentState.openDrawer(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          '$name',
          style: Theme.of(context).textTheme.display1,
        ),
        actions: <Widget>[
          FutureBuilder(
              future: getId(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
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
      ),
      body: MyPageViewWidget(

        children: _children,
        pageController: pageController,
        onPageChanged: (_currentIndex) {
          onPageChanged(_currentIndex);
        },
      ),
//      bottomNavigationBar: CurvedNavigationBar(
//        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//        buttonBackgroundColor: Theme.of(context).accentColor,
//        color: Theme.of(context).focusColor.withOpacity(0.2),
//        height: 60,
//        index: widget.selectedTab,
//        onTap: (int i) {
//          this._selectTab(i);
//        },
//        items: <Widget>[
//          Icon(
//            UiIcons.bell,
//            size: 23,
//            color: Theme.of(context).focusColor,
//          ),
//          Icon(
//            UiIcons.user_1,
//            size: 23,
//            color: Theme.of(context).focusColor,
//          ),
//          Icon(
//            UiIcons.home,
//            size: 23,
//            color: Theme.of(context).focusColor,
//          ),
//          Icon(
//            UiIcons.chat,
//            size: 23,
//            color: Theme.of(context).focusColor,
//          ),
//          Icon(
//            UiIcons.heart,
//            size: 23,
//            color: Theme.of(context).focusColor,
//          ),
//        ],
//      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).accentColor,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        iconSize: 22,
        elevation: 0,
        backgroundColor: Colors.transparent,
        selectedIconTheme: IconThemeData(size: 25),
        unselectedItemColor: Theme.of(context).hintColor.withOpacity(1),
        currentIndex: _currentIndex,
        onTap: (int index) async {
           if (index == 1 && id == 'guest') {
            Navigator.pushNamed(context, '/SignUp',
                arguments: (context) {
              Navigator.popAndPushNamed(context, '/Tabs', arguments: 1);
            });
          } else if (index == 3 && id == 'guest') {
            Navigator.pushNamed(context, '/SignUp',
                arguments: (context) {
                  Navigator.popAndPushNamed(context, '/Tabs', arguments: 3);
                });
          }
          else pageController.jumpToPage(index);
        },
        // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: Icon(UiIcons.folder_1),
            title: new Container(height: 0.0),
          ),
          BottomNavigationBarItem(
            icon: Icon(UiIcons.user_1),
            title: new Container(height: 0.0),
          ),
          BottomNavigationBarItem(
              title: new Container(height: 5.0),
              icon: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).accentColor.withOpacity(0.4),
                        blurRadius: 40,
                        offset: Offset(0, 15)),
                    BoxShadow(
                        color: Theme.of(context).accentColor.withOpacity(0.4),
                        blurRadius: 13,
                        offset: Offset(0, 3))
                  ],
                ),
                child: new Icon(UiIcons.home,
                    color: Theme.of(context).primaryColor),
              )),
          BottomNavigationBarItem(
            icon: new Icon(UiIcons.money),
            title: new Container(height: 0.0),
          ),
          BottomNavigationBarItem(
            icon: new Icon(UiIcons.layers),
            title: new Container(height: 0.0),
          ),
        ],
      ),
    );
  }
}
