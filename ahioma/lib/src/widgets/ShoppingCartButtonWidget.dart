import 'dart:ui';

import 'package:ahioma/config/ui_icons.dart';
import 'package:flutter/material.dart';

class ShoppingCartButtonWidget extends StatelessWidget {
  const ShoppingCartButtonWidget({
    this.iconColor,
    this.labelColor,
    this.labelCount = 0,
    this.id,
    Key key,
  }) : super(key: key);

  final Color iconColor;
  final Color labelColor;
  final int labelCount;
  final String id;

  @override
  Widget build(BuildContext context) {
    callBackAp(){
      Navigator.of(context).pushNamed('/Cart');
    }
    return FlatButton(
      onPressed: () {
        if(id=='guest'){
          Navigator.popAndPushNamed(context, '/SignUp',
              arguments: callBackAp());
        }
       else Navigator.of(context).pushNamed('/Cart');
      },
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Icon(
              UiIcons.shopping_cart,
              color: this.iconColor,
              size: 28,
            ),
          ),
          // Container(
          //   child: Text(
          //     this.labelCount.toString(),
          //     textAlign: TextAlign.center,
          //     style: Theme.of(context).textTheme.caption.merge(
          //           TextStyle(color: Theme.of(context).primaryColor, fontSize: 9),
          //         ),
          //   ),
          //   padding: EdgeInsets.all(0),
          //   decoration: BoxDecoration(color: this.labelColor, borderRadius: BorderRadius.all(Radius.circular(10))),
          //   constraints: BoxConstraints(minWidth: 15, maxWidth: 15, minHeight: 15, maxHeight: 15),
          // ),
        ],
      ),
      color: Colors.transparent,
    );
  }
}
