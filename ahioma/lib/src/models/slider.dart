import 'dart:convert';

import 'package:http/http.dart';

class Slider {
  String image;
  String button = '/';
  String description = '';

  Slider({this.image, this.button, this.description});
}

class SliderList {
  Response response;
  var data;
  var lisst = <Slider>[];
  List<Slider> _list;
  List<Slider> get list => _list;
  Map item;

  SliderList() {
    _list = lisst;
  }

  Future<void> getSliderList() async {
    lisst=[];
    try {
      response = await get(Uri.parse('http://api.ahioma.ng/api/v1/Banners/Index'),
          headers: {"accept": "application/json"});
      data = jsonDecode(response.body);
      // for (var item in data){
      //   Slider slide = Slider(image: item['urlLink'].toString());
      //   _list.add(slide);
      if (response.statusCode.toString() == '200') {
        for (item in data) {
          final slide = Slider(
              image: item['urlLink'].toString(),
              button: '/',
              description: 'hello');
          lisst.add(slide);
        }
      }
    } catch (e) {
      print(e);
      print((response.body));
      print((data));

      print(item);
      print(list);
    }
  }
}
