import 'package:ahioma/config/ui_icons.dart';
import 'package:ahioma/src/models/brand.dart';
import 'package:ahioma/src/models/product.dart';
import 'package:ahioma/src/models/shop.dart';
import 'package:ahioma/src/widgets/FavoriteListItemWidget.dart';
import 'package:ahioma/src/widgets/ProductGridItemWidget.dart';
import 'package:ahioma/src/widgets/SearchBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductsByShopsWidget extends StatefulWidget {
 final Shop brand;
  ProductsByShopsWidget({Key key, this.brand}) : super(key: key);

  @override
  _ProductsByShopsWidgetState createState() => _ProductsByShopsWidgetState();
}

class _ProductsByShopsWidgetState extends State<ProductsByShopsWidget> {
  String layout = 'grid';
  ProductsList product = ProductsList();
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: SearchBarWidget(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 10),
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            leading: Icon(
              UiIcons.box,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              '${widget.brand.name} Products',
              overflow: TextOverflow.fade,
              softWrap: false,
              style: Theme.of(context).textTheme.display1,
            ),
          ),
        ),
        Offstage(
          offstage: this.layout != 'list',
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            primary: false,
            itemCount: product.lisst.length,
            separatorBuilder: (context, index) {
              return SizedBox(height: 10);
            },
            itemBuilder: (context, index) {
              // TODO replace with products list item
              return FavoriteListItemWidget(
                heroTag: 'products_by_category_list',
                product: product.lisst.elementAt(index),
                // onDismissed: () {
                //   setState(() {
                //     widget.brand.products.removeAt(index);
                //   });
                // },
              );
            },
          ),
        ),
        Offstage(
          offstage: this.layout != 'grid',
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: new StaggeredGridView.countBuilder(
              primary: false,
              shrinkWrap: true,
              crossAxisCount: 4,
              itemCount: product.lisst.length,
              itemBuilder: (BuildContext context, int index) {
                Product produt = product.lisst.elementAt(index);
                return ProductGridItemWidget(
                  product: produt,
                  heroTag: 'products_by_category_grid',
                );
              },
//                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(index % 2 == 0 ? 1 : 2),
              staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
              mainAxisSpacing: 15.0,
              crossAxisSpacing: 15.0,
            ),
          ),
        ),
      ],
    );
  }
}
