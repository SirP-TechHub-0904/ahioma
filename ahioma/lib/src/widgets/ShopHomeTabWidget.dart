import 'package:ahioma/config/ui_icons.dart';
import 'package:ahioma/src/models/brand.dart';
import 'package:ahioma/src/models/product.dart';
import 'package:ahioma/src/models/shop.dart';
import 'package:ahioma/src/widgets/FlashSalesCarouselWidget.dart';
import 'package:ahioma/src/widgets/HomeSliderWidget.dart';
import 'package:flutter/material.dart';

class ShopHomeTabWidget extends StatefulWidget {
  Shop brand;
  ProductsList _productsList = new ProductsList();

  ShopHomeTabWidget({this.brand});

  @override
  _ShopHomeTabWidgetState createState() => _ShopHomeTabWidgetState();
}

class _ShopHomeTabWidgetState extends State<ShopHomeTabWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            leading: Icon(
              UiIcons.flag,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              widget.brand.name,
              style: Theme.of(context).textTheme.display1,
            ),
          ),
        ),
//         Container(
//           margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//           height: 200,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: NetworkImage('${widget.brand.banner}'), fit: BoxFit.contain),
//             borderRadius: BorderRadius.circular(6),
//             boxShadow: [
//               BoxShadow(
//                   color: Theme.of(context).hintColor.withOpacity(0.2),
//                   offset: Offset(0, 4),
//                   blurRadius: 9)
//             ],
//           ),
// //                   child: Container(
// //                     alignment: AlignmentDirectional.bottomEnd,
// //                     width: double.infinity,
// //                     padding: const EdgeInsets.symmetric(horizontal: 20),
// //                     child: Container(
// //                       width: config.App(context).appWidth(40),
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.stretch,
// //                         mainAxisSize: MainAxisSize.max,
// //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                         children: <Widget>[
// //                           Text(
// //                             slide.description,
// //                             style: Theme.of(context).textTheme.title.merge(TextStyle(height: 0.8)),
// //                             textAlign: TextAlign.right,
// //                             overflow: TextOverflow.fade,
// //                             maxLines: 3,
// //                           ),
// //                           FlatButton(
// //                             onPressed: () {
// // //                              Navigator.of(context).pushNamed('/Checkout');
// //                             },
// //                             padding: EdgeInsets.symmetric(vertical: 5),
// //                             color: Theme.of(context).accentColor,
// //                             shape: StadiumBorder(),
// //                             child: Text(
// //                               slide.button,
// //                               textAlign: TextAlign.start,
// //                               style: TextStyle(color: Theme.of(context).primaryColor),
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
//         ),
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
                      'Shop Profile',
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
                            '${widget.brand.address}',
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
                          'Description:',
                          style: Theme.of(context).textTheme.body1,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            '${widget.brand.description} ',
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
                          'Contact Us:',
                          style: Theme.of(context).textTheme.body1,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            '${widget.brand.phoneNo}',
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
        // FlashSalesCarouselWidget(
        //     heroTag: 'brand_featured_products',
        //     productsList: widget._productsList.flashSalesList),
      ],
    );
  }
}
