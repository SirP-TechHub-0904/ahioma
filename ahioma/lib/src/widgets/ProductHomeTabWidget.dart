import 'package:ahioma/config/ui_icons.dart';
import 'package:ahioma/src/models/product.dart';
import 'package:ahioma/src/models/product_color.dart';
import 'package:ahioma/src/models/product_size.dart';
import 'package:ahioma/src/models/route_argument.dart';
import 'package:ahioma/src/models/shop.dart';
import 'package:ahioma/src/widgets/FlashSalesCarouselWidget.dart';
import 'package:flutter/material.dart';

class ProductHomeTabWidget extends StatefulWidget {
  Product product;
  String color;
  String size;
  ProductsList _productsList = new ProductsList();

  ProductHomeTabWidget({this.product});

  @override
  productHomeTabWidgetState createState() => productHomeTabWidgetState();
}

class productHomeTabWidgetState extends State<ProductHomeTabWidget> {
  String color;
  String size;

  void updateColor(String colo) {
    setState(() {
      color = colo;
    });
  }
  void updateSize(String siz) {
    setState(() {
      size = siz;
    });
  }

  @override
  Widget build(BuildContext context) {
    Shop shop = Shop(
        name: widget.product.shop,
        id:widget.product.shopId.toString()
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Text(
                  widget.product.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.display2,
                ),
              ),
              // Chip(
              //   padding: EdgeInsets.all(0),
              //   label: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: <Widget>[
              //       Text(widget.product.rate.toString(),
              //           style:
              //               Theme.of(context).textTheme.body2.merge(TextStyle(color: Theme.of(context).primaryColor))),
              //       Icon(
              //         Icons.star_border,
              //         color: Theme.of(context).primaryColor,
              //         size: 16,
              //       ),
              //     ],
              //   ),
              //   backgroundColor: Theme.of(context).accentColor.withOpacity(0.9),
              //   shape: StadiumBorder(),
              // ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(widget.product.getPrice(),
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w600,
                      fontSize: 20.00)),
              SizedBox(width: 10),
              // Text(
              //   widget.product.getPrice(myPrice: widget.product.price + 10.0),
              //   style: Theme.of(context)
              //       .textTheme
              //       .headline
              //       .merge(TextStyle(color: Theme.of(context).focusColor, decoration: TextDecoration.lineThrough)),
              // ),
              SizedBox(width: 10),
              Expanded(
                  child: InkWell(
                    onTap: (){
                      Navigator.of(context)
                          .pushNamed('/Shop', arguments: new RouteArgument(id: widget.product.shopId, argumentsList: [shop]));
                    },
                    child: Text('${widget.product.shop}',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w600,
                            fontSize: 15.00)),
                  )),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.9),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).focusColor.withOpacity(0.15),
                  blurRadius: 5,
                  offset: Offset(0, 2)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Select Color',
                      style: Theme.of(context).textTheme.body2,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              SelectColorWidget(
                  color: widget.product.color,
                  onSonChanged: (String name) {
                    updateColor(name);
                  })
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          margin: EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.9),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).focusColor.withOpacity(0.15),
                  blurRadius: 5,
                  offset: Offset(0, 2)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Select Size',
                      style: Theme.of(context).textTheme.body2,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              SelectSizeWidget(size: widget.product.size,onSonChanged: (String name){
              updateSize(name);
              },)
            ],
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        //   child: ListTile(
        //     dense: true,
        //     contentPadding: EdgeInsets.symmetric(vertical: 0),
        //     leading: Icon(
        //       UiIcons.box,
        //       color: Theme.of(context).hintColor,
        //     ),
        //     title: Text(
        //       'Related Poducts',
        //       style: Theme.of(context).textTheme.display1,
        //     ),
        //   ),
        // ),
        // FlashSalesCarouselWidget(
        //     heroTag: 'product_related_products', productsList: widget._productsList.flashSalesList),
      ],
    );
  }
}

typedef void IntCallback(String name);

class SelectColorWidget extends StatefulWidget {
  List<ProductColor> color;
  final IntCallback onSonChanged;
  SelectColorWidget({this.color, @required this.onSonChanged});

  @override
  _SelectColorWidgetState createState() => _SelectColorWidgetState();
}

class _SelectColorWidgetState extends State<SelectColorWidget> {
  ProductColorsList _productColorsList = new ProductColorsList();
  ProductColor colo;
  @override
  void initState() {
    // TODO: implement initState
    if (widget.color.isNotEmpty) {
      colo = widget.color.first;
    } else
      colo = colo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.color.isEmpty) {
      return SizedBox(
        height: 38,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('No color'),
        ),
      );
    } else
      return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: List.generate(widget.color.length, (index) {
          var _color = widget.color.elementAt(index);
          return buildColor(_color);
        }),
      );
  }

  SizedBox buildColor(ProductColor color) {
    return SizedBox(
      height: 38,
      child: RadioListTile<ProductColor>(
        title: Text(color.name),
        value: color,
        groupValue: colo,
        onChanged: (ProductColor value) {
          setState(() {
            colo = value;
            widget.onSonChanged(colo.name);
          });
        },
      ),
    );
    //   SizedBox(
    //   width: 38,
    //   height: 38,
    //   child: FilterChip(
    //     label: Text(''),
    //     padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
    //     backgroundColor: Theme.of(context).focusColor.withOpacity(0.05),
    //     selectedColor: Theme.of(context).focusColor.withOpacity(0.2),
    //     selected: color.selected,
    //     shape: StadiumBorder(),
    //     avatar: Text(''),
    //     onSelected: (bool value) {
    //       setState(() {
    //         color.selected = value;
    //       });
    //     },
    //   ),
    // );
  }
}
typedef void sizeCallback(String name);
class SelectSizeWidget extends StatefulWidget {
  List<ProductSize> size;
  final sizeCallback onSonChanged;
  SelectSizeWidget({this.size,@required this.onSonChanged});

  @override
  _SelectSizeWidgetState createState() => _SelectSizeWidgetState();
}

class _SelectSizeWidgetState extends State<SelectSizeWidget> {
  ProductSizesList _productSizesList = new ProductSizesList();

  ProductSize siz;
  @override
  void initState() {
    if (widget.size.isNotEmpty) {
      siz = widget.size.first;
    } else
      siz = siz;
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.size.isEmpty) {
      return SizedBox(
        height: 38,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('No size'),
        ),
      );
    } else
      return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: List.generate(widget.size.length, (index) {
          var _size = widget.size.elementAt(index);
          return buildSize(_size);
        }),
      );
  }

  SizedBox buildSize(ProductSize size) {
    return SizedBox(
      height: 38,
      child: RadioListTile<ProductSize>(
        title: Text(size.name),
        value: size,
        groupValue: siz,
        onChanged: (ProductSize value) {
          setState(() {
            siz = value;
            widget.onSonChanged(siz.name);
          });
        },
      ),
    );

    //   SizedBox(
    //   height: 38,
    //   child: RawChip(
    //     label: Text(size.code),
    //     labelStyle: TextStyle(color: Theme.of(context).hintColor),
    //     padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
    //     backgroundColor: Theme.of(context).focusColor.withOpacity(0.05),
    //     selectedColor: Theme.of(context).focusColor.withOpacity(0.2),
    //     selected: size.selected,
    //     shape: StadiumBorder(side: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.05))),
    //     onSelected: (bool value) {
    //       setState(() {
    //         size.selected = value;
    //       });
    //     },
    //   ),
    // );
  }
}
