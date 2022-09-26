import 'package:flutter/material.dart';

class ProductSize {
  String id ;
  String code;
  String name;
  bool selected;

  ProductSize({this.code, this.name, this.id});
}

class ProductSizesList {
  List<ProductSize> lisst;

  List<ProductSize> get list => lisst;

  ProductSizesList() {
    lisst = [

    ];
  }
  void clearSelection() {
    list.forEach((size) {
      size.selected = false;
    });
  }
}
