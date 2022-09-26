// import 'package:ahioma/config/app_config.dart';
import 'dart:convert';
import 'dart:math';

import 'package:ahioma/src/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Shop {
  String id;
  String name='';
  String image='';
  List<Product> products=[];
  String description='';
  String address='';
  String phoneNo='';
  String banner='';
  Color color=Colors.primaries[Random().nextInt(
      Colors.primaries.length)];
  var data;

  Shop({this.id,this.name,this.image,this.products,this.description,this.address,this.phoneNo,this.banner});


}

class ShopsList {

  Shop shopp = Shop();
  List<Shop> _list;
var lisst=<Shop>[];
  List<Shop> get list => _list;
 Shop get shoppp => shopp;
  ShopsList() {
    _list = [

    ];
  }

  Future <void> getShopById(String id)async{
    var data;
    int idd = int.parse(id);
    print(id);
    try{
      Response response = await get(Uri.parse('http://api.ahioma.ng/api/v1/Profile/GetTenantInfo?id=$idd'),headers:
      {
        "accept": "application/json"
      });
      data = jsonDecode(response.body);
      String image;
      if(data['logoUri']=='No LOGO'){
        image = 'https://cdn.pixabay.com/photo/2017/06/10/06/40/market-2389152_960_720.png';

      }
      else{
        image=data['logoUri'];
      }
      Shop shop = Shop(
        name: data['businessName'],
        description: data['businessDescription'],
        phoneNo: data['phone'],
        address: data['tenantAddress'],
        image: image,
        id: data['id'].toString(),
        products: [],
        banner: data['bannerUri']
      );
      shopp=shop;
    }
    catch(e){
      print(e);
    }
  }


  Future <void> getShopsByMart(String num,String id)async{
    int dum = int.parse(num);
    int idd = int.parse(id);
    int fum=10;
    try{
      Response response = await get(Uri.parse('http://api.ahioma.ng/api/vi/Markets/GetAllShopsByMarketId?PageNumber=$dum&PageSize=$fum&id=$idd'),headers:
      {
        "accept": "application/json"
      });
      var data = jsonDecode(response.body);
      if (response.statusCode==200){
        int i=0;

        for(var item in data as List){
          String image;
          if(item['shopLogo']!=null){
            image=item['shopLogo'];
          }
          else{
            image = 'https://cdn.pixabay.com/photo/2017/06/10/06/40/market-2389152_960_720.png';
          }
          Shop shop= Shop(
              name:item['businessName'].toString().toUpperCase(),
              image: image,
              id:item['shopId'].toString(),
            address: '',
            products: [],
            description: ''
          );
          lisst.add(shop);
          i++;
        }
      }
    }
    catch(e){
      print (e);
    }
  }
}
