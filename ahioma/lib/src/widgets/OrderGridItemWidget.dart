import 'package:ahioma/src/models/order.dart';
import 'package:ahioma/src/models/route_argument.dart';
import 'package:flutter/material.dart';
import 'package:ahioma/src/models/product.dart';

class OrderGridItemWidget extends StatelessWidget {
  const OrderGridItemWidget({
    Key key,
    @required this.order,
    @required this.heroTag,
  }) : super(key: key);

  final Order order;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      onTap: () {
        Navigator.of(context)
            .pushNamed('/Product', arguments: new RouteArgument(id: order.mainId, argumentsList: [order , heroTag]));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.10), offset: Offset(0, 4), blurRadius: 10)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: this.heroTag + order.id,
              child: Image.asset(order.image),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                order.name,
                style: Theme.of(context).textTheme.body2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                order.getPrice(),
                style: Theme.of(context).textTheme.title,
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 15),
            //   child: Row(
            //     children: <Widget>[
            //       // The title of the order
            //       Expanded(
            //         child: Text(
            //           '${order.product.sales} Sales',
            //           style: Theme.of(context).textTheme.body1,
            //           overflow: TextOverflow.fade,
            //           softWrap: false,
            //         ),
            //       ),
            //       Icon(
            //         Icons.star,
            //         color: Colors.amber,
            //         size: 18,
            //       ),
            //       // Text(
            //       //   order.product.rate.toString(),
            //       //   style: Theme.of(context).textTheme.body2,
            //       // )
            //     ],
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //   ),
            // ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
