import 'package:ahioma/config/ui_icons.dart';
import 'package:ahioma/src/models/order.dart';
import 'package:ahioma/src/models/route_argument.dart';
import 'package:flutter/material.dart';
import 'package:ahioma/src/models/product.dart';


// ignore: must_be_immutable
class CartViewWidget extends StatefulWidget {
  String heroTag;
  CartItems order;
  VoidCallback onDismissed;

  CartViewWidget({Key key, this.heroTag, this.order, this.onDismissed}) : super(key: key);

  @override
  _CartViewWidgetState createState() => _CartViewWidgetState();
}

class _CartViewWidgetState extends State<CartViewWidget> {
  double subTotal;
  @override
  void initState() {
    subTotal= widget.order.price*widget.order.quant;
  }



  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).accentColor,
      focusColor: Theme.of(context).accentColor,
      highlightColor: Theme.of(context).primaryColor,
      onTap: () {
        Navigator.of(context).pushNamed('/Product',
            arguments: new RouteArgument(argumentsList: [this.widget.heroTag], id: this.widget.order.mainId));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.9),
          boxShadow: [
            BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 5, offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: widget.heroTag + widget.order.mainId,
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  image: DecorationImage(image: NetworkImage('${widget.order.image}'), fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(width: 15),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.order.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.subhead,
                        ),
                        SizedBox(height: 12),
                        Wrap(
                          spacing: 10,
                          children: <Widget>[
                            // Row(
                            //   children: <Widget>[
                            //     Icon(
                            //       UiIcons.calendar,
                            //       color: Theme.of(context).focusColor,
                            //       size: 20,
                            //     ),
                            //     SizedBox(width: 10),
                            //     Text(
                            //       widget.order.getDateTime(),
                            //       style: Theme.of(context).textTheme.body1,
                            //       overflow: TextOverflow.fade,
                            //       softWrap: false,
                            //     ),
                            //   ],
                            // ),
                            // Row(
                            //   children: <Widget>[
                            //     Icon(
                            //       UiIcons.line_chart,
                            //       color: Theme.of(context).focusColor,
                            //       size: 20,
                            //     ),
                            //     SizedBox(width: 10),
                            //     // Text(
                            //     //   widget.order.trackingNumber,
                            //     //   style: Theme.of(context).textTheme.body1,
                            //     //   overflow: TextOverflow.fade,
                            //     //   softWrap: false,
                            //     // ),
                            //   ],
                            // ),
                          ],
//                            crossAxisAlignment: CrossAxisAlignment.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(widget.order.getPrice(), style: TextStyle(color: Theme.of(context).accentColor,fontFamily: 'Roboto',fontWeight: FontWeight.w600,fontSize: 15.00),),
                      SizedBox(height: 6),
                      Chip(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        backgroundColor: Colors.transparent,
                        shape: StadiumBorder(side: BorderSide(color: Theme.of(context).focusColor)),
                        label: Text(
                          'x ${widget.order.quant}',
                          style: TextStyle(color: Theme.of(context).focusColor),
                        ),
                      ),
                      Text('Sub total: ${subTotal.toString()}', style: Theme.of(context).textTheme.subtitle1),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
