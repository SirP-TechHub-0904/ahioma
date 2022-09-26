// import 'package:ahioma/src/models/product.dart';
import 'package:ahioma/src/models/category.dart';
import 'package:ahioma/src/models/product.dart';
import 'package:ahioma/src/services/home_service.dart';
import 'package:ahioma/src/widgets/ProductGridItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CategorizedProductsWidget extends StatefulWidget {
  const CategorizedProductsWidget({
    Key key,
    @required this.animationOpacity,
    @required List<Product> productsList,
  })  : _productsList = productsList,
        super(key: key);

  final Animation animationOpacity;
  final List<Product> _productsList;

  @override
  _CategorizedProductsWidgetState createState() => _CategorizedProductsWidgetState();
}

class _CategorizedProductsWidgetState extends State<CategorizedProductsWidget> {
  int _current = 0;
  HomeCategoriesList _homeCategoriesList = new HomeCategoriesList();
  bool loading;
  @override
  Widget build(BuildContext context) {
    if (widget._productsList.isEmpty){

      return LinearProgressIndicator();
    }
   else  return FadeTransition(
      opacity: widget.animationOpacity,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: new StaggeredGridView.countBuilder(
          primary: false,
          shrinkWrap: true,
          crossAxisCount: 4,
          itemCount: widget._productsList.length,
          itemBuilder: (BuildContext context, int index) {
            Product product = widget._productsList.elementAt(index);
            // if(product.image!=null) {
              return ProductGridItemWidget(

                product: product,
                heroTag: 'categorized_products_grid',
              );
            // }
            // else return Column(
            //   children: <Widget>[
            //     Text('error loading product'),
            //     FlatButton.icon(onPressed:(){
            //       setState(() {
            //       loading=false;
            //       });
            //     } , icon: Icon(Icons.refresh), label: Text('Tap to reload'))
            //   ],
            // );
          },
//              staggeredTileBuilder: (int index) => new StaggeredTile.count(2, index.isEven ? 2 : 1),
          staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
          mainAxisSpacing: 15.0,
          crossAxisSpacing: 15.0,
        ),
      ),
    );
  }
}
