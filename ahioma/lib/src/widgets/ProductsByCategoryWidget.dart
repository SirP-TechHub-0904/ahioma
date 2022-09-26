import 'dart:convert';

import 'package:ahioma/config/ui_icons.dart';
import 'package:ahioma/src/models/category.dart';
import 'package:ahioma/src/models/product.dart';
import 'package:ahioma/src/screens/favorites.dart';
import 'package:ahioma/src/widgets/FavoriteListItemWidget.dart';
import 'package:ahioma/src/widgets/ProductGridItemWidget.dart';
import 'package:ahioma/src/widgets/SearchBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';


class ProductsByCategoryWidget extends StatefulWidget {
  SubCategory subCategory;
  ProductsList productsList;
  ScrollController controller;
  ProductsByCategoryWidget({Key key, this.subCategory,this.productsList,this.controller}) : super(key: key);

  @override
  _ProductsByCategoryWidgetState createState() => _ProductsByCategoryWidgetState();
}

class _ProductsByCategoryWidgetState extends State<ProductsByCategoryWidget> {
  var products = [];
 int pageKey = 1;
 bool loading;

  @override
  void initState() {
      _fetchPage(pageKey);
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    var pics;

    // TODO: Implement the function's body.
    try{
      Response response = await get(Uri.parse('http://api.ahioma.ng/api/v1/Products/GetAllProductsAsyncByPageSizeAndSubCategoryId?PageNumber=$pageKey&PageSize=100&id=${widget.subCategory.id}'),
                headers: {"accept": "application/json"});
            var data = jsonDecode(response.body);
               for (var ite in data){
                 Product product = Product(mainId: ite['id'].toString(),name: ite['name'],image: ite['productPictures'][0]['picturePath'],price: ite['price']);
                 products.add(product);
                 setState(() {
                   loading = false;
                 });
               }
    }

    catch (e){
      print (e);
    }
  }
  String layout = 'grid';
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
              '${widget.subCategory.name} Category',
              overflow: TextOverflow.fade,
              softWrap: false,
              style: Theme.of(context).textTheme.display1,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    setState(() {
                      this.layout = 'list';
                    });
                  },
                  icon: Icon(
                    Icons.format_list_bulleted,
                    color: this.layout == 'list' ? Theme.of(context).accentColor : Theme.of(context).focusColor,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      this.layout = 'grid';
                    });
                  },
                  icon: Icon(
                    Icons.apps,
                    color: this.layout == 'grid' ? Theme.of(context).accentColor : Theme.of(context).focusColor,
                  ),
                )
              ],
            ),
          ),
        ),

        // Offstage(
        //   offstage: this.layout != 'grid',
        //   child: RefreshIndicator(
        //     onRefresh: () => Future.sync(
        //       // 2
        //           () => _pagingController.refresh(),
        //     ),
        //     child: PagedGridView(
        //       pagingController: _pagingController,
        //       scrollDirection: Axis.vertical,
        //       shrinkWrap: true,
        //       primary: false,
        //       gridDelegate:SliverGridDelegate() ,
        //       builderDelegate: PagedChildBuilderDelegate<Product>(
        //         itemBuilder: (context, product, index) => ProductGridItemWidget(
        //           product: product,
        //           heroTag: 'products_by_category_grid',
        //         ),
        //       ),
        //       // separatorBuilder: (context, index) {
        //       //   return SizedBox(height: 10);
        //       // },
        //       // itemBuilder: (context, index) {
        //       //   // TODO replace with products list item
        //       //   return FavoriteListItemWidget(
        //       //     heroTag: 'products_by_category_list',
        //       //     product: widget.subCategory.products.elementAt(index),
        //       //     onDismissed: () {
        //       //       setState(() {
        //       //         widget.subCategory.products.removeAt(index);
        //       //       });
        //       //     },
        //       //   );
        //       // },
        //     ),
        //   ),
        // ),
        Offstage(
          offstage: this.layout != 'grid',
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: new StaggeredGridView.countBuilder(
              controller: widget.controller,
              primary: false,
              shrinkWrap: true,
              crossAxisCount: 4,
              itemCount: widget.productsList.lisst.length,
              itemBuilder: (BuildContext context, int index) {
                Product product = widget.productsList.lisst.elementAt(index);
                return ProductGridItemWidget(
                  product: product,
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
