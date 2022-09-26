import 'package:ahioma/config/ui_icons.dart';
import 'package:ahioma/src/models/route_argument.dart';
import 'package:flutter/material.dart';
import 'package:ahioma/src/services/ahia_pay_services.dart';

// ignore: must_be_immutable
class TransactionListItemWidget extends StatefulWidget {
  String heroTag;
  Transactions transaction;


  TransactionListItemWidget({Key key, this.heroTag, this.transaction}) : super(key: key);

  @override
  _TransactionListItemWidgetState createState() => _TransactionListItemWidgetState();
}

class _TransactionListItemWidgetState extends State<TransactionListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).accentColor,
      focusColor: Theme.of(context).accentColor,
      highlightColor: Theme.of(context).primaryColor,
      onTap: () {

      },
      child: Container(

        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.9),
          boxShadow: [
            BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.5), blurRadius: 15, offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Hero(
            //   tag: widget.heroTag + widget.transaction.transId,
            //   child: Container(
            //     height: 60,
            //     width: 60,
            //     // decoration: BoxDecoration(
            //     //   btransactionRadius: BtransactionRadius.all(Radius.circular(5)),
            //     //   image: DecorationImage(image: AssetImage(widget.transaction.product.image), fit: BoxFit.cover),
            //     // ),
            //   ),
            // ),
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
                          '${widget.transaction.description}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.subhead,
                        ),
                        SizedBox(height: 12),
                        Wrap(
                          spacing: 10,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  UiIcons.calendar,
                                  color: Theme.of(context).focusColor,
                                  size: 20,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  '${widget.transaction.datOfTransaction}',
                                  style: Theme.of(context).textTheme.body1,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  UiIcons.line_chart,
                                  color: Theme.of(context).focusColor,
                                  size: 20,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  '${widget.transaction.trackCode}',
                                  style: Theme.of(context).textTheme.body1,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                ),
                              ],
                            ),
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
                      Text('${widget.transaction.amount}', style: Theme.of(context).textTheme.display1),
                      SizedBox(height: 6),
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
