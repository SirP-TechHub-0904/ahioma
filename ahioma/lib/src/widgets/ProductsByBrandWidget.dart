import 'package:ahioma/config/ui_icons.dart';
import 'package:ahioma/src/models/brand.dart';
import 'package:ahioma/src/models/product.dart';
import 'package:ahioma/src/models/shop.dart';
import 'package:ahioma/src/widgets/FavoriteListItemWidget.dart';
import 'package:ahioma/src/widgets/ProductGridItemWidget.dart';
import 'package:ahioma/src/widgets/SearchBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ahioma/src/models/market.dart';

import 'ShopsGridWidget.dart';

class ProductsByBrandWidget extends StatefulWidget {
  final Market brand;
 final  ShopsList list= ShopsList();

  ProductsByBrandWidget({Key key, this.brand}) : super(key: key);

  @override
  _ProductsByBrandWidgetState createState() => _ProductsByBrandWidgetState();
}

class _ProductsByBrandWidgetState extends State<ProductsByBrandWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
              '${widget.brand.name} Shops',
              overflow: TextOverflow.fade,
              softWrap: false,
              style: Theme.of(context).textTheme.display1,
            ),
          ),
        ),
        ShopGridWidget(

          brandsList: widget.list,
          // heroTag: 'products_by_category_grid',
        )
      ],
    );
  }
}
