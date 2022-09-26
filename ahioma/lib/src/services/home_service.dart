import 'dart:convert';

import 'package:ahioma/config/ui_icons.dart';
import 'package:ahioma/src/models/market.dart';
import 'package:ahioma/src/models/product.dart';
import 'package:ahioma/src/models/shop.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomeCategory {
  String id;
  String name;
  bool selected;
  IconData icon;
  List<Product> products;
  HomeCategory({this.id, this.name, this.icon, this.selected, this.products});
}

class SearchValue {
  String value;

  SearchValue({this.value});
}

class HomeMarket {
  var lisst = <Market>[];

  MarketsList marketsList = MarketsList();
  var lisstt = <Market>[];
  Future<void> getMarket() async {
   lisstt = <Market>[];
    await marketsList.getMarkets();
    for (var item in marketsList.list) {
      lisstt.add(item);
    }
    print(lisstt);
    lisst = marketsList.list.sublist(0, 10);

    // http://api.ahioma.ng/api/v1/Home/ProductsList40
  }
}

class HomeMoreProducts {
  var lisst = <Product>[];
  var data;
  Response response;
  var slide;
  Future<void> getProductList() async {
    // lisst = <Product>[];
    try {
      response = await get(Uri.parse('http://api.ahioma.ng/api/v1/Home/ProductsList40'),
          headers: {"accept": "application/json"});
      data = jsonDecode(response.body);
      // for (var item in data){
      //   Slider slide = Slider(image: item['urlLink'].toString());
      //   _list.add(slide);
      if (response.statusCode.toString() == '200') {
        var item;
        for (item in data) {
          Product slide = Product(
              name: item['name'],
              price: item['price'],
              image: item['image'],
              market: item['market'],
              shop: item['shop'],
              mainId: item['id'].toString(),
              color: [],
              size: []);
          lisst.add(slide);
        }
      }
    } catch (e) {
      print(e);
      print((response.body));
      print((data));
    }
  }
}

class HomeCategoriesList {
  HomeCategory slide;
  List<HomeCategory> _list;
  Response response;
  Response responsee;
  var lisst = <HomeCategory>[];
  var data;
  var datta;
  IconData icon;
  List<HomeCategory> get list => _list;

  HomeCategoriesList() {
    this._list = lisst;
  }

  Future<void> getCathegoryList() async {
    var item;
    // lisst=[];
    try {
      response = await get(Uri.parse('http://api.ahioma.ng/api/v1/Home/CategoryHome'),
          headers: {"accept": "application/json"});
      data = jsonDecode(response.body);

      if (response.statusCode.toString() == '200') {
        for (item in data) {
          var cathe = <Product>[];
          try {
            responsee = await get(
                Uri.parse('http://api.ahioma.ng/api/v1/Home/ProductsListByCatID10?id=${item['id']}'),
                headers: {"accept": "application/json"});
            datta = jsonDecode(responsee.body);
            for (var ite in datta as List) {
              Product product = Product(
                  id: item['id'].toString(),
                  name: ite['name'],
                  price: ite['price'],
                  image: ite['image'],
                  market: ite['market'],
                  shop: ite['shop'],
                  mainId: ite['id'].toString(),
                  color: [],
                  size: []);
              cathe.add(product);
            }
          } catch (e) {
            print(e);
            print((responsee.body));
            print((datta));
            print(cathe);
          }

          getIcon(item['name']);
          bool selected;
          if (item['name'] == 'Phones and Accessories') {
            selected = true;
          } else
            selected = false;
          HomeCategory slide = HomeCategory(
              name: item['name'],
              id: item['id'].toString(),
              selected: selected,
              products: cathe,
              icon: icon);

          lisst.add(slide);
        }
      }
    } catch (e) {
      print(e);
      print((response.body));
      print((data));
      print(list);
    }
  }

  selectById(String id) {
    this._list.forEach((HomeCategory category) {
      category.selected = false;
      if (category.id == id) {
        category.selected = true;
      }
    });
  }

  getIcon(item) {
    switch (item) {
      case 'Phones & Accessories':
        icon = UiIcons.smartphone;
        break;
      case 'Groceries & Food items':
        icon = UiIcons.cutlery;
        break;
      case 'Books & Stationeries':
        icon = UiIcons.books;
        break;
      case 'Fashion & Jewelries':
        icon = UiIcons.jewelry;
        break;
      case 'Home & Interiors':
        icon = UiIcons.living_room;
    }
  }

  void clearSelection() {
    _list.forEach((category) {
      category.selected = false;
    });
  }
}
