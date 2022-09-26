import 'package:flutter/material.dart';

class ProductColor {
  String id;
  String name;
  bool selected;

  ProductColor({this.name,this.id});
}

class ProductColorsList {
  List<ProductColor> lisst;

  List<ProductColor> get list => lisst;

  ProductColorsList() {
    lisst = [

    ];
  }

  void clearSelection() {
    lisst.forEach((color) {
      color.selected = false;
    });
  }
}
