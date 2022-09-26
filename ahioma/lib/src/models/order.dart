
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ahioma/src/models/product.dart';
import 'package:intl/intl.dart' show DateFormat;

enum OrderState { unpaid, toBeShipped, shipped, inDispute }

class Track {
  String id = UniqueKey().toString();
  String description;
  String currentLocation;
  DateTime dateTime;

  Track(this.description, this.currentLocation, this.dateTime);

  static List<Track> getTrackingList() {
    return [
      new Track('Your Order in local post', 'United State', DateTime.now().subtract(Duration(days: 1))),
      new Track('Your Order arrived in destination', 'United State', DateTime.now().subtract(Duration(days: 5))),
      new Track('Order in aeroport', 'France', DateTime.now().subtract(Duration(days: 8))),
      new Track('Your order oversea in china', 'China', DateTime.now().subtract(Duration(days: 10))),
    ];
  }
}

class Order extends Product{
  String id;
  String name;
  String mainId;
  int quantity;
  double price;
  String trackingNumber='';
  DateTime dateTime;
  OrderState orderState;
  String image='img/ic_launcher.png';
  // List<Track> tracking = Track.getTrackingList();

  Order({this.mainId, this.quantity,this.id,this.trackingNumber,this.dateTime,this.name,this.price});

  getDateTime() {
    return DateFormat('yyyy-MM-dd HH:mm').format(this.dateTime);
  }
  String getPricee({double myPrice}) {
    if (myPrice != null) {
      return "₦${myPrice.toStringAsFixed(2)}";
    }
    return "₦${this.price.toStringAsFixed(2)}";
  }
}

class OrderList {
  Response response;
  List<Order> _list=[];

  List<Order> get list => _list;

  Future<List<Order>>getOrders(String uId,int pageNum,int stat)async{
 print(uId);
    try{
     _list =[];
      response = await get(Uri.parse('http://api.ahioma.ng/api/Orders/GetUserOrderByItemAndStatus?PageNumber=$pageNum&PageSize=10&userid=$uId&status=$stat'),
          headers: {"accept": "application/json"});
      var data = jsonDecode(response.body);
      if(response.statusCode.toString()=='200'){
        print(uId);
        int o=0;
        for(var item in data as List){
          DateTime date = DateTime.parse(item['dateOfOrder']);
          Order add = Order(
              id: item['id'].toString(),
    mainId: item['productId'].toString(),
    quantity: item['quantity'],
    name: item['productName'],
    trackingNumber: item['trackCode'],
            price: item['price'],
            dateTime: date


          );
          o++;
          _list.add(add);
        }print(_list);return _list;
      }
    }
    catch(e){
      print(e);
    }
  }
}
