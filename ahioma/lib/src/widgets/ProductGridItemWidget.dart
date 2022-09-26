import 'dart:convert';
import 'dart:math';
import 'package:ahioma/src/models/product.dart';
import 'package:ahioma/src/models/route_argument.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
class ProductGridItemWidget extends StatefulWidget {
  const ProductGridItemWidget({
    Key key,
    @required this.product,
    @required this.heroTag,
  }) : super(key: key);

  final Product product;
  final String heroTag;


  @override
  _ProductGridItemWidgetState createState() => _ProductGridItemWidgetState();
}

class _ProductGridItemWidgetState extends State<ProductGridItemWidget> {


  @override
  Widget build(BuildContext context) {
    String url;
    url=widget.product.image;
    void getImageUrl()async{
      Response response;
    try {
      await get(Uri.parse("http://api.ahioma.ng/api/v1/Products/${widget.product.mainId}") ,headers:
      {
        "accept": "application/json"
      });
      var data = jsonDecode(response.body);

      setState(() {
        url = data['imageUrl'].toString();
      });}
      catch(e){
      print(e);
      print(url);
      }
    }

    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      onTap: () {
        if (widget.product.image!=null){
          Navigator.of(context).pushNamed('/Product',
              arguments: new RouteArgument(argumentsList: [this.widget.product, this.widget.heroTag], id: this.widget.product.mainId));
          print(widget.product.mainId);
        }
        else {
          getImageUrl();
        }
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

              tag: this.widget.heroTag + widget.product.mainId,
              child:widget.product.image != null ?Image.network(url): Container(
                child: Column(
                  children: <Widget> [
                    Text('Unable to load image'),
                    Text('tap to reload'),
                    Icon(Icons.refresh)
                  ],
                ),
              )

            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                widget.product.name,
                style: Theme.of(context).textTheme.body2,
                softWrap: false,
                overflow: TextOverflow.fade,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                widget.product.getPrice(),
                style: TextStyle(color: Theme.of(context).accentColor,fontFamily: 'Roboto',fontWeight: FontWeight.w600,fontSize: 15.00),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: <Widget>[
                  // The title of the product
                  Expanded(
                    child: Text(
                      '${widget.product.market}',
                      style: Theme.of(context).textTheme.body1,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    ),
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 18,
                  ),
                  // Text(
                  //   product.rate.toString(),
                  //   style: Theme.of(context).textTheme.body2,
                  // )
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
