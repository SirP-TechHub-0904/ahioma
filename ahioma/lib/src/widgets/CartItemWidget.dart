import 'package:ahioma/src/models/product.dart';
import 'package:ahioma/src/models/route_argument.dart';
import 'package:flutter/material.dart';
import 'package:ahioma/config/ui_icons.dart';

class CartItemWidget extends StatefulWidget {
  String heroTag;
  CartItems product;
  VoidCallback onDismissed;

  CartItemWidget({Key key, this.product, this.heroTag,this.onDismissed}) : super(key: key);

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  int quant;
  CartItems it = CartItems();
  @override
  void initState() {
    // TODO: implement initState
  quant = widget.product.quant;
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(this.widget.product.hashCode.toString()),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Icon(
              UiIcons.trash,
              color: Colors.white,
            ),
          ),
        ),
      ),
      onDismissed: (direction) {
        // Remove the item from the data source.
        setState(() {
          widget.onDismissed();
        });

        // Then show a snackbar.
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text("The ${widget.product.name} is removed from cart")));
      },
      child: InkWell(
        splashColor: Theme.of(context).accentColor,
        focusColor: Theme.of(context).accentColor,
        highlightColor: Theme.of(context).primaryColor,
        onTap: () {
          Navigator.of(context).pushNamed('/Product',
              arguments: RouteArgument(id: widget.product.mainId, argumentsList: [widget.product as Product, widget.heroTag]));
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
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
                tag: widget.heroTag + widget.product.cartId.toString(),
                child: Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    image: DecorationImage(image: NetworkImage(widget.product.image), fit: BoxFit.cover),
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
                            widget.product.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.subhead,
                          ),
                          Text(
                            widget.product.getPrice(),
                              style: TextStyle(color: Theme.of(context).accentColor,fontFamily: 'Roboto',fontWeight: FontWeight.w600,fontSize: 15.00),
                          ),
                          Text(
                            'swipe to delete',
                            maxLines: 2,
                            style: Theme.of(context).textTheme.body1,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          onPressed: () async {
                            quant++;
                            await it.updateQty(widget.product.cartId ,quant);
                            setState(() {
                              quant  = quant;
                            });
                          },
                          iconSize: 30,
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          icon: Icon(Icons.add_circle_outline),
                          color: Theme.of(context).hintColor,
                        ),
                        Text(quant.toString(), style: Theme.of(context).textTheme.subhead),
                        IconButton(
                          onPressed: () async{
                            if(quant==1){
                              setState(() {
                                quant=1;
                              });
                            }else{
                            quant--;
                            await it.updateQty(widget.product.cartId ,quant);
                            setState(() {
                              quant  = quant;
                            });}
                          },
                          iconSize: 30,
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          icon: Icon(Icons.remove_circle_outline),
                          color: Theme.of(context).hintColor,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  incrementQuantity(int quantity) {
    if (quantity <= 99) {
      return ++quantity;
    } else {
      return quantity;
    }
  }

  decrementQuantity(int quantity) {
    if (quantity > 1) {
      return --quantity;
    } else {
      return quantity;
    }
  }
}
