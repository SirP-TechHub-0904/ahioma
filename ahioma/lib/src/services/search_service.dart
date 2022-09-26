import 'dart:convert';

import 'package:ahioma/config/ui_icons.dart';
import 'package:ahioma/src/models/market.dart';
import 'package:ahioma/src/models/product.dart';
import 'package:ahioma/src/models/shop.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SearchService {
  String error;
  var lisst = <Product>[];
  var list = <Shop>[];
  var mart = <Market>[];
  bool loading;
  String valu;

  Future<void> getSearchProducts(String value, String key) async {
    list = [];
    lisst = [];
    mart = [];
    try {
      valu = value;
      Response response = await get(
          Uri.parse('http://api.ahioma.ng/api/vi/Search/GetAllSearch?PageNumber=$key&PageSize=10&searchString=$value'),
          headers: {"accept": "application/json"});
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        int i = 0;
        int o = 0;
        int t = 0;

        for (var item in data['productSearchDtos'] ) {
          Product product = Product(
              name: data['productSearchDtos'][i]['name'],
              image: data['productSearchDtos'][i]['productPicture'],
              mainId: data['productSearchDtos'][i]['id'].toString(),
              price: data['productSearchDtos'][i]['price'],
              color: [],
              size: []);
          lisst.add(product);
          i++;
        }
        for (var item in data['shopSearchDto']) {
          Shop shop = Shop(
            name: data['shopSearchDto'][o]['shop'],
            id: data['shopSearchDto'][o]['id'].toString(),
          );
          list.add(shop);
          o++;
        }
        for (var item in data['marketSearchDto']) {
          Market market = Market(
              name: data['marketSearchDto'][t]['market'],
              id: data['marketSearchDto'][t]['id'].toString(),
              image:
                  'https://cdn.pixabay.com/photo/2017/06/10/06/40/market-2389152_960_720.png',
              shops: [],
              state: 'Imo');
          mart.add(market);
          t++;
        }
        print(data['productSearchDtos']);
        print(list.runtimeType);
        print(data);
      } else if (data == null) {
        error = 'No search results found';
      } else if (response.reasonPhrase == 'Failed to fetch') {
        error = 'No Internet Connection';
      }
    } catch (e) {
      print(e);
      print(error);
    }
  }

  Future<void> getSearchProductsPagi(String value, String key) async {
    try {
      valu = value;
      Response response = await get(
          Uri.parse('http://api.ahioma.ng/api/vi/Search/GetAllSearch?PageNumber=$key&PageSize=10&searchString=$value'),
          headers: {"accept": "application/json"});
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        int i = 0;
        int o = 0;
        int t = 0;

        for (var item in data['productSearchDtos']) {
          Product product = Product(
              name: data['productSearchDtos'][i]['name'],
              image: data['productSearchDtos'][i]['productPicture'],
              mainId: data['productSearchDtos'][i]['id'].toString(),
              price: data['productSearchDtos'][i]['price'],
              color: [],
              size: []);
          lisst.add(product);
          i++;
        }
        print(data['productSearchDtos']);
        print(list.runtimeType);
        print(data);
      } else if (data == null) {
        error = 'No search results found';
      } else if (response.reasonPhrase == 'Failed to fetch') {
        error = 'No Internet Connection';
      }
    } catch (e) {
      print(e);
      print(error);
    }
  }

  Future<void> getSearchProductsMain(String value, String key) async {
    try {
      valu = value;
      Response response = await get(
          Uri.parse('http://api.ahioma.ng/api/vi/Search/GetAllSearch?PageNumber=$key&PageSize=10&searchString=$value'),
          headers: {"accept": "application/json"});
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        int i = 0;
        int o = 0;
        int t = 0;

        for (var item in data['productSearchDtos']) {
          Product product = Product(
              name: data['productSearchDtos'][i]['name'],
              image: data['productSearchDtos'][i]['productPicture'],
              mainId: data['productSearchDtos'][i]['id'].toString(),
              price: data['productSearchDtos'][i]['price'],
              color: [],
              size: []);
          lisst.add(product);
          i++;
        }
        for (var item in data['shopSearchDto']) {
          Shop shop = Shop(
            name: data['shopSearchDto'][o]['shop'],
            id: data['shopSearchDto'][o]['id'].toString(),
            image:
                'https://cdn.pixabay.com/photo/2017/06/10/06/40/market-2389152_960_720.png',
            description: '',
          );
          list.add(shop);
          o++;
        }
        for (var item in data['marketSearchDto']) {
          Market market = Market(
              name: data['marketSearchDto'][t]['market'],
              id: data['marketSearchDto'][t]['id'].toString(),
              image:
                  'https://cdn.pixabay.com/photo/2017/06/10/06/40/market-2389152_960_720.png',
              shops: [],
              state: 'Imo');
          mart.add(market);
          t++;
        }
        print(data['productSearchDtos']);
        print(list.runtimeType);
        print(data);
      } else if (data == null) {
        error = 'No search results found';
      } else if (response.reasonPhrase == 'Failed to fetch') {
        error = 'No Internet Connection';
      }
    } catch (e) {
      print(e);
      print(error);
    }
  }
}
