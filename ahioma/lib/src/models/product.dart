import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ahioma/src/models/product_color.dart';
import 'package:ahioma/src/models/product_size.dart';
import 'package:ahioma/src/models/order.dart';

class Product {
  String id;
  String mainId;
  String name;
  String image;
  String shop;
  double price;
  int shopId;
  String market;
  String description;
  int quantity;
  int sales;
  double rate;
  double discount;
  List<ProductColor> color = [];
  List<ProductSize> size = [];

  Product(
      {this.mainId,
      this.shopId,
      this.id,
      this.name,
      this.image,
      this.market = '',
      this.price,
      this.shop,
      this.color,
      this.size,
      this.description});

  String getPrice({double myPrice}) {
    if (myPrice != null) {
      return "₦${myPrice.toStringAsFixed(2)}";
    }
    return "₦${this.price.toStringAsFixed(2)}";
  }
}

class ProductsList {
  List<Product> _flashSalesList;
  List<Product> _list;
  List<Product> _categorized;
  List<Product> _favoritesList;
  List<Product> _cartList;
  Product product;

  set categorized(List<Product> value) {
    _categorized = value;
  }

  List<Product> get categorized => _categorized;

  List<Product> get list => _list;
  List<Product> get flashSalesList => _flashSalesList;
  List<Product> get favoritesList => _favoritesList;
  List<Product> get cartList => _cartList;
  Product slide;
  Response response;
  var lisst = <Product>[];
  var color = <ProductColor>[];
  var size = <ProductSize>[];
  var data;
  Future <void> getProductByShopId(String pageNum,String id)async{
    int pageDum = int.parse(pageNum);
    int idd = int.parse(id);
    try{
      Response response = await get(
          Uri.parse('http://api.ahioma.ng/api/v1/Products/GetAllProductsByPageSizeAndShopId?PageNumber=$pageDum&PageSize=10&id=$id'),
          headers: {"accept": "application/json"});
      var data = jsonDecode(response.body);
      for(var item in data['data'] as List){
        Product shop = Product(
          name: item['name'],
          mainId: item['id'].toString(),
          image: item['productPicture'],
          shop: item['tenant'],
          price: item['price']
        );
        lisst.add(shop);
      }
    }
    catch(e){

    }
  }
  Future<Product> getProductById(int id) async {
    try {
      response = await get(Uri.parse('http://api.ahioma.ng/api/v1/Products/$id'),
          headers: {"accept": "application/json"});
      data = jsonDecode(response.body);
      Product pro;
      if (response.statusCode.toString() == '200') {
        int o = 0;
        int i=0;
        if (data['productColors'] != []) {
          for (var item in data['productColors']) {
            ProductColor colo = ProductColor(
                name: data['productColors'][i]['itemColor'],
                id: data['productColors'][i]['id'].toString());
            color.add(colo);
            i++;
          }
        }
        else color = [];
        if (data['productSizes'] != []) {
          for (var item in data['productSizes']) {
            ProductSize siz = ProductSize(
                name: data['productSizes'][o]['itemSize'],
                id: data['productSizes'][o]['id'].toString());
            size.add(siz);
            o++;
          }
        }
        else size =[];
         pro = Product(
          name: data['name'],
          mainId: data['id'].toString(),
          description: data['fullDescription'],
          image: data['productPicture'],
          price: data['price'],
          color: color,
          shop: data['tenant'],
          shopId:data['tenantId'],
          size: size,
        );
      }
      return pro;
    } catch (e) {
      print(e);
      print((response.body));
      print((data));
      print(list);
    }
  }

  ProductsList() {
    _flashSalesList = [
      // new Product('Maxi Dress For Women Summer', 'img/pro1.webp', 25, 36.12, 200, 130, 4.3, 12.1),
      // new Product('Black Checked Retro Hepburn Style', 'img/pro2.webp', 60, 12.65, 200, 63, 5.0, 20.2),
      // new Product('Robe pin up Vintage Dress Autumn', 'img/pro3.webp', 10, 66.96, 200, 415, 4.9, 15.3),
      // new Product('Elegant Casual Dress', 'img/pro4.webp', 80, 63.98, 200, 2554, 3.1, 10.5),
    ];

    _list = lisst;
    _favoritesList = [
      // new Product('Plant Vases', 'img/home6.webp', 80, 63.98, 200, 2554, 3.1, 10.5),
      // new Product('Maxi Dress For Women Summer', 'img/pro1.webp', 25, 36.12, 200, 130, 4.3, 12.1),
      // new Product('Foldable Silicone Colander Fruit Vegetable', 'img/home10.webp', 80, 63.98, 200, 2554, 3.1, 10.5),
      // new Product('Robe pin up', 'img/pro3.webp', 10, 66.96, 200, 415, 4.9, 15.3),
      // new Product('Wrist Watch', 'img/watch5.webp', 80, 63.98, 200, 2554, 3.1, 10.5),
      // new Product('Alarm Waterproof Sports Army', 'img/watch9.webp', 80, 63.98, 200, 2554, 3.1, 10.5),
      // new Pro'duct('Black Checked Retro Hepburn Style', 'img/pro2.webp', 60, 12.65, 200, 63, 5.0, 20.2),
    ];

    _cartList = [
      // new Product('Plant Vases', 'img/home6.webp', 80, 63.98, 200, 2554, 3.1, 10.5),
      // new Product('Maxi Dress For Women Summer', 'img/pro1.webp', 25, 36.12, 200, 130, 4.3, 12.1),
      // new Product('Foldable Silicone Colander Fruit Vegetable', 'img/home10.webp', 80, 63.98, 200, 2554, 3.1, 10.5),
      // new Product('Robe pin up', 'img/pro3.webp', 10, 66.96, 200, 415, 4.9, 15.3),
      // new Product('Wrist Watch', 'img/watch5.webp', 80, 63.98, 200, 2554, 3.1, 10.5),
      // new Product('Alarm Waterproof Sports Army', 'img/watch9.webp', 80, 63.98, 200, 2554, 3.1, 10.5),
      // new Product('Black Checked Retro Hepburn Style', 'img/pro2.webp', 60, 12.65, 200, 63, 5.0, 20.2),
    ];
  }
}
class AddToCart{
  String message;
  Response response;
  Future<void>addToCat(int pId,String uId,String itemColor,String itemSze,int quantity)async{
    if(itemColor==null){
      itemColor = '';
    }
    if(itemSze==null){
      itemSze = '';
    }
    var data;
    try{
      response = await get(Uri.parse('http://api.ahioma.ng/api/v1/Carts/AddToCart?pid=$pId&uId=$uId&itemcolor=$itemColor&itemsize=$itemSze&quantity=$quantity'),
        headers: {"accept": "application/json"});
    data = jsonDecode(response.body);
   if(data.toString()=='success'){
     message='Added to cart';
   }
    }
    catch(e){

    }
  }
}
class CartItems extends Product{
  int cartId;
  String mainId;
  double price;
  String image;
  String name;
  int quant;
  double sum;
  double shipping;
  Response response;
  String error;
  String message;

  var ites=<CartItems>[];
  CartItems({this.name,this.image,this.cartId,this.price,this.mainId,this.quant});


  String getPrice({double myPrice}) {
    if (myPrice != null) {
      return "₦${myPrice.toStringAsFixed(2)}";
    }
    return "₦${this.price.toStringAsFixed(2)}";
  }

  Future<List>getCartItems(String uId)async{

    try{
      ites=[];
      response = await get(Uri.parse('http://api.ahioma.ng/api/v1/Carts/MyCart?uId=$uId'),
          headers: {"accept": "application/json"});
     var data = jsonDecode(response.body);
      if(response.statusCode.toString()=='200'){
        int i = 0;
        int o=0;
           for(var item in data['productCarts']){
             CartItems items =CartItems(
               name: data['productCarts'][i]['product']['name'],
               cartId: data['productCarts'][i]['id'],
               mainId: data['productCarts'][i]['productId'].toString(),
               price: data['productCarts'][i]['product']['price'],
               quant: data['productCarts'][i]['quantity'],
               image: data['productCarts'][i]['product']['productPictures'][o]['picturePath']
             );
             sum = data['sum'];
             shipping = data['logistic'];
             ites.add(items);
             i++;
           }return ites;
      }
    }
    catch(e){
     print(e);
    }
    }



  Future<void>updateQty(int cId,int quantity)async{
    var data;
    try{
      response = await get(Uri.parse('http://api.ahioma.ng/api/v1/Carts/UpdateQuantity?cid=$cId&quantity=$quantity'),
          headers: {"accept": "application/json"});
      data = jsonDecode(response.body);
      if(data.toString()=='success'){
        message='Quantity updated';
      }
    }
    catch(e){

    }
  }

  }
  class Address{
  int aId;
  String uId;
  String fullAddress;
  String street;
  String lga;
  String state;
  var address =<Address>[];
  Response response;

  Address({this.aId,this.uId,this.fullAddress});

  Future <List<Address>> getAdList(String uID)async{
    var data;
    int o=0;
    address=[];
    try{

      response = await put(Uri.parse('http://api.ahioma.ng/api/CheckOut/ListUserAddress?uid=$uID'),
          headers: {"accept": "application/json"});
      print(response.body);
      data = jsonDecode(response.body);

      if(response.statusCode.toString()=='200'){
        print(data);
        for(var item in data){
          Address add =Address(
            aId: data[o]['id'],
            fullAddress: data[o]['address'],
              uId: uID
          );
          o++;
          address.add(add);
        }
      }
      return address;
    }
    catch(e){
  print(e);
    }
  }
  Future<void>updateQty(int cId,int quantity)async{
    var data;
    try{
      response = await get(Uri.parse('http://api.ahioma.ng/api/v1/Carts/UpdateQuantity?cid=$cId&quantity=$quantity'),
          headers: {"accept": "application/json"});
      data = jsonDecode(response.body);
      if(data.toString()=='success'){

      }
    }
    catch(e){

    }
  }
  }


