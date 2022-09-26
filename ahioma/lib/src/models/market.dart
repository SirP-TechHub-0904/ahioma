import 'dart:convert';
import 'dart:math';

import 'package:ahioma/src/models/product.dart';
import 'package:ahioma/src/models/shop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Market {
  String id ;
  String name;
  String image;
  String address;
  String localGovernment;
  List<Shop>shops;
  Color color=Colors.primaries[Random().nextInt(
      Colors.primaries.length)];
  String state;

  Market({this.id,this.name,this.image,this.state,this.shops,this.address,this.localGovernment});
}

class MarketsList {
  List<Market> _list;
  List<Market> get list => _list;
  var lisst = <Market>[];
  MarketsList(){
    this._list = lisst;
  }
  Response response;
  var data;

  Future <void> getMarkets() async {
    try {
      response = await get(Uri.parse('http://api.ahioma.ng/api/vi/Markets'),
          headers: {"accept": "application/json"});
      data = jsonDecode(response.body);
      if (response.statusCode.toString() == '200') {
        for (var item in data) {
          Market slide = Market(
              name: item['name'],
              id: item['id'].toString(),
            state: item['state'],
            image: 'https://ahioma.ng${item['imageUrl']}',
            shops: [],
            localGovernment: item['localGovernment'],
            address: item['address']

          );
          print(data);
          lisst.add(slide);
        }
      }
    }
    catch (e) {
      print(data);
      print(response.statusCode);
      print (list);
    }
  }
}