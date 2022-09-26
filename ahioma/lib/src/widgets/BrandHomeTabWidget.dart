import 'package:ahioma/config/ui_icons.dart';
import 'package:ahioma/src/models/brand.dart';
import 'package:ahioma/src/models/product.dart';
import 'package:ahioma/src/widgets/FlashSalesCarouselWidget.dart';
import 'package:ahioma/src/widgets/HomeSliderWidget.dart';
import 'package:flutter/material.dart';
import 'package:ahioma/src/models/market.dart';

class BrandHomeTabWidget extends StatefulWidget {
  Market brand;
  int shops;
  ProductsList _productsList = new ProductsList();

  BrandHomeTabWidget({this.brand,this.shops});

  @override
  _BrandHomeTabWidgetState createState() => _BrandHomeTabWidgetState();
}

class _BrandHomeTabWidgetState extends State<BrandHomeTabWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
          // child: ListTile(
          //   dense: true,
          //   contentPadding: EdgeInsets.symmetric(vertical: 0),
          //   leading: Icon(
          //     UiIcons.flag,
          //     color: Theme.of(context).hintColor,
          //   ),
          //   title: Text(
          //     widget.brand.name,
          //     style: Theme.of(context).textTheme.display1,
          //   ),
          // ),
        ),
        // HomeSliderWidget(),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).hintColor.withOpacity(0.15),
                      offset: Offset(0, 3),
                      blurRadius: 10)
                ],
              ),
              child: ListView(
                shrinkWrap: true,
                primary: false,
                children: <Widget>[
                  ListTile(
                    leading: Icon(UiIcons.user_3),
                    title: Text(
                      'Market Profile',
                      style: Theme.of(context).textTheme.body2,
                    ),
                  ),
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
                          'Name:',
                          style: Theme.of(context).textTheme.body1,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            '${widget.brand.name.toUpperCase()}',
                            overflow: TextOverflow.visible,
                            softWrap: true,
                            style:
                            TextStyle(color: Theme.of(context).focusColor),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                          'Address:',
                          style: Theme.of(context).textTheme.body1,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            '${widget.brand.address} ',
                            overflow: TextOverflow.visible,
                            softWrap: true,
                            style:
                            TextStyle(color: Theme.of(context).focusColor),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                          'L.G.A:',
                          style: Theme.of(context).textTheme.body1,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            '${widget.brand.localGovernment} ',
                            overflow: TextOverflow.visible,
                            softWrap: true,
                            style:
                            TextStyle(color: Theme.of(context).focusColor),
                          ),
                        )
                      ],
                    ),
                  ),
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
                          'State:',
                          style: Theme.of(context).textTheme.body1,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            '${widget.brand.state}',
                            overflow: TextOverflow.visible,
                            softWrap: true,
                            style:
                            TextStyle(color: Theme.of(context).focusColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // ListTile(
                  //   onTap: () {
                  //     Navigator.of(context).pushNamed('/Help');
                  //   },
                  //   dense: true,
                  //   title: Row(
                  //     children: <Widget>[
                  //       Icon(
                  //         UiIcons.information,
                  //         size: 22,
                  //         color: Theme.of(context).focusColor,
                  //       ),
                  //       SizedBox(width: 10),
                  //       Text(
                  //         'Help & Support',
                  //         style: Theme.of(context).textTheme.body1,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            )),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        //   child: ListTile(
        //     dense: true,
        //     contentPadding: EdgeInsets.symmetric(vertical: 0),
        //     leading: Icon(
        //       UiIcons.trophy,
        //       color: Theme.of(context).hintColor,
        //     ),
        //     title: Text(
        //       'Featured Products',
        //       style: Theme.of(context).textTheme.display1,
        //     ),
        //   ),
        // ),
        // FlashSalesCarouselWidget(heroTag: 'brand_featured_products', productsList: widget._productsList.flashSalesList),
      ],
    );
  }
}
