import 'package:ahioma/config/ui_icons.dart';
import 'package:ahioma/src/models/brand.dart';
import 'package:ahioma/src/models/category.dart';
import 'package:ahioma/src/models/market.dart';
import 'package:ahioma/src/models/product.dart';
import 'package:ahioma/src/models/slider.dart';
import 'package:ahioma/src/services/home_service.dart';
import 'package:ahioma/src/widgets/BrandsIconsCarouselWidget.dart';
import 'package:ahioma/src/widgets/CategoriesIconsCarouselWidget.dart';
import 'package:ahioma/src/widgets/CategorizedProductsWidget.dart';
import 'package:ahioma/src/widgets/FlashSalesCarouselWidget.dart';
import 'package:ahioma/src/widgets/FlashSalesWidget.dart';
import 'package:ahioma/src/widgets/HomeSliderWidget.dart';
import 'package:ahioma/src/widgets/MarketGridWidget.dart';
import 'package:ahioma/src/widgets/SearchBarWidget.dart';
import 'package:ahioma/src/widgets/BrandGridWidget.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';


class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> with  AutomaticKeepAliveClientMixin, TickerProviderStateMixin   {

  SliderList _sliderList = new SliderList();
  bool lading;
  Future <void> refreshHome()async{
   await getSlide();
   await getCategory();
  }
  Future getSlide() async {
    await _sliderList.getSliderList();
    setState(() {
      lading = false;
    });
  }
  List<Product> _productsOfCategoryList;
  List<Market> marketsList;
  List<Product> _productsOfBrandList;
  HomeCategoriesList _homeCategoriesList = new HomeCategoriesList();
  HomeMarket _marketList = new HomeMarket();
  HomeMoreProducts moreProducts =new HomeMoreProducts();
  List<Product> _productsList;

  Animation animationOpacity;
  AnimationController animationController;
  final ValueNotifier<int> loading = ValueNotifier<int>(0);


  Future getCategory()async{
    _productsOfCategoryList=[];
    await _homeCategoriesList.getCathegoryList();
    print(_homeCategoriesList.lisst);
    setState(() {
      _productsOfCategoryList = _homeCategoriesList.lisst.firstWhere((category) {
        return category.selected=true;
      }).products;
      loading.value += 1;
    });
    await _marketList.getMarket();
    setState(() {
      loading.value += 1;
    });

    await moreProducts.getProductList();
      setState(() {
        if(moreProducts.lisst.isNotEmpty){
          setState(() {
            _productsList = moreProducts.lisst;
            loading.value += 1;
          });
        }
        else {
          _productsList=_favoritesList;
        }

      });


      print (loading);
  }
List <Product>  _favoritesList = [
  // new Product(name:'Plant Vases', image:'img/home6.webp', price: 63.98),
  //   new Product(name:'Plant Vases', image:'img/home6.webp', price: 63.98),
  //   new Product(name:'Plant Vases', image:'img/home6.webp', price: 63.98),
  //   new Product(name:'Plant Vases', image:'img/home6.webp', price: 63.98),
  //   new Product(name:'Plant Vases', image:'img/home6.webp', price: 63.98),
  //   new Product(name:'Plant Vases', image:'img/home6.webp', price: 63.98),
  //   new Product(name:'Plant Vases', image:'img/home6.webp', price: 63.98),
  ];

  @override
  void initState() {
    getSlide();
    getCategory();
    animationController = AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    CurvedAnimation curve = CurvedAnimation(parent: animationController, curve: Curves.easeIn);
    animationOpacity = Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });

    animationController.forward();
    if(_homeCategoriesList.lisst.isNotEmpty)
    _productsOfCategoryList = _homeCategoriesList.lisst.firstWhere((category) {
      return category.selected;
    }).products;
    else {
      _productsOfCategoryList=_favoritesList;
    }
    if(moreProducts.lisst.isNotEmpty){
      _productsList = moreProducts.lisst;
    }
    else {
      _productsList=_favoritesList;
    }
    marketsList = _marketList.lisst;
    // _productsOfBrandList = _brandsList.list.firstWhere((brand) {
    //   return brand.selected;
    // }).products;
    super.initState();
  }

  // @override
  // dispose() {
  //   animationController.dispose(); // you need this
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return
      RefreshIndicator(
        onRefresh: (){
         return refreshHome();
        },
        child: ListView(
        addAutomaticKeepAlives: true,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SearchBarWidget(),
          ),
           HomeSliderWidget(list: _sliderList),
          // FlashSalesHeaderWidget(),
          // FlashSalesCarouselWidget(heroTag: 'home_flash_sales', productsList: _productsList.flashSalesList),
          // Heading (Recommended for you)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 0),
              leading: Icon(
                UiIcons.favorites,
                color: Theme.of(context).hintColor,
              ),
              title: Text(
                'Top Categories',
                style: Theme.of(context).textTheme.display1,
              ),
            ),
          ),
          ValueListenableBuilder(
            builder: (BuildContext context, int value, Widget child) {
              return StickyHeader(
                header: CategoriesIconsCarouselWidget(
                    heroTag: 'home_categories_1',
                    categoriesList: _homeCategoriesList,
                    onChanged: (id) {
                      setState(() {
                        animationController.reverse().then((f) {
                          _productsOfCategoryList = _homeCategoriesList.lisst
                              .firstWhere((category) {
                            return category.id == id;
                          }).products;
                          animationController.forward();
                        }
                        );
                      });
                    }),
                content: CategorizedProductsWidget(
                    animationOpacity: animationOpacity,
                    productsList: _productsOfCategoryList),
              );
            },
            valueListenable: loading
          ),



          // Heading (Markets)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 0),
              leading: Icon(
                UiIcons.flag,
                color: Theme.of(context).hintColor,
              ),
              title: Text(
                'Popular Virtual Markets',
                style: Theme.of(context).textTheme.display1,
              ),
            ),
          ),
          ValueListenableBuilder(
              builder: (BuildContext context, int value, Widget child) {
                return  MarketGridWidget(brandsList: _marketList);
              },
              valueListenable: loading
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 0),
              leading: Icon(
                UiIcons.flag,
                color: Theme.of(context).hintColor,
              ),
              title: Text(
                'Recommended for you ',
                style: Theme.of(context).textTheme.display1,
              ),
            ),
          ),
          CategorizedProductsWidget(animationOpacity: animationOpacity, productsList: _productsList),
          // StickyHeader(
          //   header: BrandsIconsCarouselWidget(
          //       heroTag: 'home_brand_1',
          //       brandsList: _brandsList,
          //       onChanged: (id) {
          //         setState(() {
          //           animationController.reverse().then((f) {
          //             _productsOfBrandList = _brandsList.list.firstWhere((brand) {
          //               return brand.id == id;
          //             }).products;
          //             animationController.forward();
          //           });
          //         });
          //       }),
          //   content: CategorizedProductsWidget(animationOpacity: animationOpacity, productsList: _productsOfBrandList),
          // ),
        ],
    ),
      );
//      ],
//    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
