import 'package:ahioma/src/models/brand.dart';
import 'package:ahioma/src/models/category.dart';
import 'package:ahioma/src/models/market.dart';
import 'package:ahioma/src/services/home_service.dart';
import 'package:ahioma/src/widgets/BrandGridWidget.dart';
import 'package:ahioma/src/widgets/DrawerWidget.dart';
import 'package:ahioma/src/widgets/SearchBarWidget.dart';
import 'package:ahioma/src/widgets/ShoppingCartButtonWidget.dart';
import 'package:flutter/material.dart';

class BrandsWidget extends StatefulWidget {
  @override
  _BrandsWidgetState createState() => _BrandsWidgetState();
}

class _BrandsWidgetState extends State<BrandsWidget> with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  HomeMarket _brandsList = new HomeMarket();
  MarketsList _marketsList = MarketsList();
  bool loading;
  SubCategoriesList _subCategoriesList = new SubCategoriesList();
  Future getMarket()async{
  if (_brandsList.lisstt.isEmpty){
  await _marketsList.getMarkets();
  setState(() {
  loading = true;
  });
  }}
  @override
  void initState() {
    // TODO: implement initState
   getMarket();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(_marketsList.list.isEmpty){
      return Center(child: Container(child: CircularProgressIndicator(),));
    }
    else return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Wrap(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SearchBarWidget(),
          ),
          BrandGridWidget(brandsList: _marketsList),
        ],
      ),
    );

      // drawer: DrawerWidget(),
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   leading: new IconButton(
      //     icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
      //     onPressed: () => _scaffoldKey.currentState.openDrawer(),
      //   ),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   title: Text(
      //     'Markets',
      //     style: Theme.of(context).textTheme.display1,
      //   ),
      //   actions: <Widget>[
      //     new ShoppingCartButtonWidget(
      //         iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
      //     Container(
      //         width: 30,
      //         height: 30,
      //         margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
      //         child: InkWell(
      //           borderRadius: BorderRadius.circular(300),
      //           onTap: () {
      //             Navigator.of(context).pushNamed('/Tabs', arguments: 1);
      //           },
      //           child: CircleAvatar(
      //             backgroundImage: AssetImage('img/user2.jpg'),
      //           ),
      //         )),
      //   ],
      // ),


  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
