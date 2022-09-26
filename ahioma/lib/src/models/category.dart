import 'dart:convert';

import 'package:ahioma/config/ui_icons.dart';
import 'package:ahioma/src/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Category {
  String id;
  String name;
  bool selected;
  IconData icon;
  List<Product> products;
  List<SubCategory> subCath;
  Category({this.id, this.name,this.subCath});

}

class SubCategory {
  String id;
  String name;
  bool selected;
  List<Product> products=[];

  SubCategory({this.id,this.name, this.selected,this.products});
}

class CategoriesList {
  Category slide;
  List<Category> _list;
  Response response;
  Response responsee;
  var lisst = <Category>[];
  var data;
  var datta;
  var dattta;
  IconData icon;
  List<Category> get list => _list;
  var item;
  var ite;
  var cathe = <Product>[];
  var sub =[];


  CategoriesList() {
    this._list = lisst;
    // new Category('Man', UiIcons.shoe_1, true, [
    //   new Product('Zogaa FlameSweater', 'img/man1.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Men Polo Shirt Brand Clothing', 'img/man2.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Polo Shirt for Men', 'img/man3.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Men\'s Sport Pants Long Summer', 'img/man4.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Men\'s Hoodies Pullovers Striped', 'img/man5.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Men Double Breasted Suit Vests', 'img/man6.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Puimentiua Summer Fashion', 'img/man7.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Casual Sweater fashion Jacket', 'img/man8.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    // ]),
    // new Category('Women', UiIcons.shoe, false, [
    //   new Product('Summer Fashion Women Dress', 'img/pro5.webp', 25, 19.64, 200, 130, 4.3, 12.1),
    //   new Product('Women Half Sleeve', 'img/pro6.webp', 60, 94.36, 200, 42, 5.0, 20.2),
    //   new Product('Elegant Plaid Dresses Women Fashion', 'img/pro7.webp', 10, 15.73, 200, 415, 4.9, 15.3),
    //   new Product('Maxi Dress For Women Summer', 'img/pro1.webp', 25, 19.64, 200, 130, 4.3, 12.1),
    //   new Product('Black Checked Retro Hepburn Style', 'img/pro2.webp', 60, 94.36, 200, 63, 5.0, 20.2),
    //   new Product('Robe pin up Vintage Dress Autumn', 'img/pro3.webp', 10, 15.73, 200, 415, 4.9, 15.3),
    //   new Product('Elegant Casual Dress', 'img/pro4.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    // ]),
    // new Category('Child', UiIcons.baby_changing, false, [
    //   new Product('Fashion Baby Sequins Party Dance Ballet', 'img/baby1.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Children Martin Boots PU Leather', 'img/baby2.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Baby Boys Denim Jacket', 'img/baby3.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Mom and Daughter Matching Women', 'img/baby4.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Unicorn Pajamas Winter Flannel Family', 'img/baby5.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Party Decorations Kids', 'img/baby6.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    // ]),
    // new Category('Car', UiIcons.car_1, false, [
    //   new Product('Yosoo Knee pad Elastic', 'img/sport4.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Spring Hand Grip Finger Strength', 'img/sport5.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Knee Sleeves', 'img/sport6.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Brothock Professional basketball socks', 'img/sport7.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('New men s running trousers', 'img/sport8.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Cotton Elastic Hand Arthritis', 'img/sport9.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Spring Half Finger Outdoor Sports', 'img/sport10.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    // ]),
    // new Category('Fourniture', UiIcons.living_room, false, [
    //   new Product('Cooking Tools Set Premium', 'img/home1.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Reusable Metal Drinking Straws', 'img/home2.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Absorbent Towel Face', 'img/home3.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Pair Heat Resistant Thick Silicone', 'img/home4.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Electric Mosquito Killer Lamp', 'img/home5.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Terrarium Hydroponic Plant Vases', 'img/home6.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Steel Cutlery Set Gold Cutlery', 'img/home7.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Silicone Kitchen Organizer Insulated ', 'img/home8.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Non Stick Wooden Handle Silicone ', 'img/home9.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Foldable Silicone Colander Fruit Vegetable', 'img/home10.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Adjustable Sprinkler Plastic Water Sprayer ', 'img/home11.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    // ]),
    // new Category('Watch', UiIcons.watch, false, [
    //   new Product('Men Wrist Watch Stainless', 'img/watch1.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Reef Tiger RT Mens Sport Watches', 'img/watch2.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Sport watch Waterproof', 'img/watch3.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Sport Watch Black Military', 'img/watch4.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Digital Waterproof Wrist Watch', 'img/watch5.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Digital Display Bracelet Watch', 'img/watch6.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Men Sports Watch Silicone Watchband', 'img/watch7.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Fashion Waterproof Men Digital Watches', 'img/watch8.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Alarm Waterproof Sports Army', 'img/watch9.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    // ]),
    // new Category('Media', UiIcons.home_cinema, false, [
    //   new Product('Electric Mosquito Killer Lamp', 'img/home5.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Terrarium Hydroponic Plant Vases', 'img/home6.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Steel Cutlery Set Gold Cutlery', 'img/home7.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Silicone Kitchen Organizer Insulated ', 'img/home8.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Non Stick Wooden Handle Silicone ', 'img/home9.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Foldable Silicone Colander Fruit Vegetable', 'img/home10.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Adjustable Sprinkler Plastic Water Sprayer ', 'img/home11.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    // ]),
    // new Category('Sport', UiIcons.sport, false, [
    //   new Product('Back Shoulder Posture Correction', 'img/sport1.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Ankle Support Brace Elasticity', 'img/sport2.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Men Women Swimming Goggles', 'img/sport3.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Yosoo Knee pad Elastic', 'img/sport4.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Spring Hand Grip Finger Strength', 'img/sport5.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Knee Sleeves', 'img/sport6.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Brothock Professional basketball socks', 'img/sport7.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('New men s running trousers', 'img/sport8.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Cotton Elastic Hand Arthritis', 'img/sport9.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Spring Half Finger Outdoor Sports', 'img/sport10.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    // ]),
    // new Category('Travel', UiIcons.tent, false, [
    //   new Product('Cooking Tools Set Premium', 'img/home1.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Reusable Metal Drinking Straws', 'img/home2.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Absorbent Towel Face', 'img/home3.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Pair Heat Resistant Thick Silicone', 'img/home4.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Electric Mosquito Killer Lamp', 'img/home5.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Terrarium Hydroponic Plant Vases', 'img/home6.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Steel Cutlery Set Gold Cutlery', 'img/home7.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Silicone Kitchen Organizer Insulated ', 'img/home8.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Non Stick Wooden Handle Silicone ', 'img/home9.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Foldable Silicone Colander Fruit Vegetable', 'img/home10.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Adjustable Sprinkler Plastic Water Sprayer ', 'img/home11.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    // ]),
    // new Category('Tool', UiIcons.tool, false, [
    //   new Product('Men Wrist Watch Stainless', 'img/watch1.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Reef Tiger RT Mens Sport Watches', 'img/watch2.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Sport watch Waterproof', 'img/watch3.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Sport Watch Black Military', 'img/watch4.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Digital Waterproof Wrist Watch', 'img/watch5.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Digital Display Bracelet Watch', 'img/watch6.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Men Sports Watch Silicone Watchband', 'img/watch7.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Fashion Waterproof Men Digital Watches', 'img/watch8.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Alarm Waterproof Sports Army', 'img/watch9.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    // ]),
    // new Category('Game', UiIcons.game, false, [
    //   new Product('Back Shoulder Posture Correction', 'img/sport1.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Ankle Support Brace Elasticity', 'img/sport2.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Men Women Swimming Goggles', 'img/sport3.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Yosoo Knee pad Elastic', 'img/sport4.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Spring Hand Grip Finger Strength', 'img/sport5.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Knee Sleeves', 'img/sport6.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Brothock Professional basketball socks', 'img/sport7.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('New men s running trousers', 'img/sport8.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Cotton Elastic Hand Arthritis', 'img/sport9.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Spring Half Finger Outdoor Sports', 'img/sport10.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    // ]),
    // new Category('Home', UiIcons.vacuum, false, [
    //   new Product('Cooking Tools Set Premium', 'img/home1.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Reusable Metal Drinking Straws', 'img/home2.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Absorbent Towel Face', 'img/home3.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Pair Heat Resistant Thick Silicone', 'img/home4.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Electric Mosquito Killer Lamp', 'img/home5.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Terrarium Hydroponic Plant Vases', 'img/home6.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Steel Cutlery Set Gold Cutlery', 'img/home7.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Silicone Kitchen Organizer Insulated ', 'img/home8.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Non Stick Wooden Handle Silicone ', 'img/home9.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Foldable Silicone Colander Fruit Vegetable', 'img/home10.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    //   new Product('Adjustable Sprinkler Plastic Water Sprayer ', 'img/home11.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
    // ]),
  }

  Future<void> getCathegoryList() async {
 lisst=[];
    // this is for getting the categories
    try {

    responsee = await get(Uri.parse('http://api.ahioma.ng/api/v1/Categories/GetCategories'),
          headers: {"accept": "application/json"});
      dattta = jsonDecode(responsee.body);

      if (responsee.statusCode.toString() == '200') {

        for (item in dattta) {
          var subb =<SubCategory>[];
          //this is for getting sub categories
          // try{
          //   response = await get('http://api.ahioma.ng/api/v1/Products/GetAllProductsByPageSizeAndCategoryId?PageNumber=1&PageSize=20&id=${ite['id']}',
          //       headers: {"accept": "application/json"});
          //   data = jsonDecode(response.body);
          //   if (response.statusCode.toString()=='200'){
          //
          //   }
          // }
          // catch(e){
          //
          // }
          try{
            response = await get(Uri.parse('http://api.ahioma.ng/api/v1/Categories/GetSubCategoryByCategoryId?id=${item['id']}'),
                headers: {"accept": "application/json"});
            data = jsonDecode(response.body);
            if (response.statusCode.toString()=='200'){
              // sub = data[data.indexOf('subCategories')];
              for(ite in data){
                // try {
                //   response = await get('http://api.ahioma.ng/api/v1/Products/GetAllProductsByPageSizeAndSubCategoryId?PageNumber=1&PageSize=10&id=${ite['id']}',
                //       headers: {"accept": "application/json"});
                //   data = jsonDecode(response.body);
                //

                //
                //     for(var item in datta){
                //       var img = data['productPictures'];
                //       Product product = Product(mainId: item['id'].toString(),name: item['name'],image: img['picturePath']);
                //       cathe.add(product);
                //     }
                //
                //   }
                // }
                // catch(e){
                //
                // }
                String name;
                if(ite['name']!=null){
                  name = ite['name'];
                }
                else name = 'undifined';
                SubCategory sub = SubCategory(name:name,selected: true,id: ite['id'].toString());
                subb.add(sub);
                print (ite['name']);
              }
            }
          }
          catch (e){
           print(e);
           print (subb);
          }
          Category slide = Category(
              name: item['name'],
              id: item['id'].toString(),
              subCath: subb
          );

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
    this._list.forEach((Category category) {
      category.selected = false;
      if (category.id == id) {
        category.selected = true;
      }
    });
  }

  getIcon(item){
      switch(item){
        case 'Phones and Accessories': icon = UiIcons.smartphone;
        break;
        case 'Groceries and Food items': icon = UiIcons.cutlery;
        break;
        case 'Books and Stationeries' : icon = UiIcons.books;
        break;
        case 'Fashion and Jewelries' : icon = UiIcons.jewelry;
        break;
        case 'Home and Interiors' : icon = UiIcons.living_room;
      }
    }
  void clearSelection() {
    _list.forEach((category) {
      category.selected = false;
    });
  }
}

class SubCategoriesList {
  List<SubCategory> _list;

  List<SubCategory> get list => _list;
  List<SubCategory> subCath=[];

  SubCategoriesList() {
    this._list = [
      // new SubCategory(name:'All Products', selected:true,
          // [
        // new Product('Zogaa FlameSweater', 'img/man1.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        // new Product('Men Polo Shirt Brand Clothing', 'img/man2.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        // new Product('Polo Shirt for Men', 'img/man3.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        // new Product('Men\'s Sport Pants Long Summer', 'img/man4.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        // new Product('Men\'s Hoodies Pullovers Striped', 'img/man5.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        // new Product('Men Double Breasted Suit Vests', 'img/man6.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        // new Product('Puimentiua Summer Fashion', 'img/man7.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
        // new Product('Casual Sweater fashion Jacket', 'img/man8.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      // ]
      // ),
      // new SubCategory('Sweater', false, [
      //   new Product('Summer Fashion Women Dress', 'img/pro5.webp', 25, 19.64, 200, 130, 4.3, 12.1),
      //   new Product('Women Half Sleeve', 'img/pro6.webp', 60, 94.36, 200, 42, 5.0, 20.2),
      //   new Product('Elegant Plaid Dresses Women Fashion', 'img/pro7.webp', 10, 15.73, 200, 415, 4.9, 15.3),
      //   new Product('Maxi Dress For Women Summer', 'img/pro1.webp', 25, 19.64, 200, 130, 4.3, 12.1),
      //   new Product('Black Checked Retro Hepburn Style', 'img/pro2.webp', 60, 94.36, 200, 63, 5.0, 20.2),
      //   new Product('Robe pin up Vintage Dress Autumn', 'img/pro3.webp', 10, 15.73, 200, 415, 4.9, 15.3),
      //   new Product('Elegant Casual Dress', 'img/pro4.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      // ]),
      // new SubCategory('Jacket', false, [
      //   new Product('Fashion Baby Sequins Party Dance Ballet', 'img/baby1.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('Children Martin Boots PU Leather', 'img/baby2.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('Baby Boys Denim Jacket', 'img/baby3.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('Mom and Daughter Matching Women', 'img/baby4.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('Unicorn Pajamas Winter Flannel Family', 'img/baby5.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('Party Decorations Kids', 'img/baby6.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      // ]),
      // new SubCategory('Socks', false, [
      //   new Product('Yosoo Knee pad Elastic', 'img/sport4.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('Spring Hand Grip Finger Strength', 'img/sport5.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('Knee Sleeves', 'img/sport6.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('Brothock Professional basketball socks', 'img/sport7.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('New men s running trousers', 'img/sport8.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('Cotton Elastic Hand Arthritis', 'img/sport9.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('Spring Half Finger Outdoor Sports', 'img/sport10.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      // ]),
      // new SubCategory('Trousers', false, [
      //   new Product('Cooking Tools Set Premium', 'img/home1.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('Reusable Metal Drinking Straws', 'img/home2.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('Absorbent Towel Face', 'img/home3.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('Pair Heat Resistant Thick Silicone', 'img/home4.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('Electric Mosquito Killer Lamp', 'img/home5.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('Terrarium Hydroponic Plant Vases', 'img/home6.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('Adjustable Sprinkler Plastic Water Sprayer ', 'img/home11.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      // ]),
      // new SubCategory('Shirt', true, [
      //   new Product('Zogaa FlameSweater', 'img/man1.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('Men Polo Shirt Brand Clothing', 'img/man2.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('Polo Shirt for Men', 'img/man3.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('Men\'s Sport Pants Long Summer', 'img/man4.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('Men\'s Hoodies Pullovers Striped', 'img/man5.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('Men Double Breasted Suit Vests', 'img/man6.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('Puimentiua Summer Fashion', 'img/man7.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('Casual Sweater fashion Jacket', 'img/man8.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      // ]),
      // new SubCategory('Sweater', false, [
      //   new Product('Summer Fashion Women Dress', 'img/pro5.webp', 25, 19.64, 200, 130, 4.3, 12.1),
      //   new Product('Women Half Sleeve', 'img/pro6.webp', 60, 94.36, 200, 42, 5.0, 20.2),
      //   new Product('Elegant Plaid Dresses Women Fashion', 'img/pro7.webp', 10, 15.73, 200, 415, 4.9, 15.3),
      //   new Product('Maxi Dress For Women Summer', 'img/pro1.webp', 25, 19.64, 200, 130, 4.3, 12.1),
      //   new Product('Black Checked Retro Hepburn Style', 'img/pro2.webp', 60, 94.36, 200, 63, 5.0, 20.2),
      //   new Product('Robe pin up Vintage Dress Autumn', 'img/pro3.webp', 10, 15.73, 200, 415, 4.9, 15.3),
      //   new Product('Elegant Casual Dress', 'img/pro4.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      // ]),
      // new SubCategory('Jacket', false, [
      //   new Product('Fashion Baby Sequins Party Dance Ballet', 'img/baby1.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('Children Martin Boots PU Leather', 'img/baby2.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('Baby Boys Denim Jacket', 'img/baby3.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('Mom and Daughter Matching Women', 'img/baby4.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('Unicorn Pajamas Winter Flannel Family', 'img/baby5.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('Party Decorations Kids', 'img/baby6.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      // ]),
      // new SubCategory('Socks', false, [
      //   new Product('Yosoo Knee pad Elastic', 'img/sport4.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('Spring Hand Grip Finger Strength', 'img/sport5.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('Knee Sleeves', 'img/sport6.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('Brothock Professional basketball socks', 'img/sport7.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('New men s running trousers', 'img/sport8.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('Cotton Elastic Hand Arthritis', 'img/sport9.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('Spring Half Finger Outdoor Sports', 'img/sport10.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      // ]),
      // new SubCategory('Trousers', false, [
      //   new Product('Cooking Tools Set Premium', 'img/home1.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('Reusable Metal Drinking Straws', 'img/home2.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('Absorbent Towel Face', 'img/home3.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('Pair Heat Resistant Thick Silicone', 'img/home4.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('Electric Mosquito Killer Lamp', 'img/home5.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('Terrarium Hydroponic Plant Vases', 'img/home6.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      //   new Product('Adjustable Sprinkler Plastic Water Sprayer ', 'img/home11.webp', 80, 42.63, 200, 2554, 3.1, 10.5),
      // ]),
    ];
  }

  selectById(String id) {
    this._list.forEach((SubCategory subCategory) {
      subCategory.selected = false;
      if (subCategory.id == id) {
        subCategory.selected = true;
      }
    });
  }

  void clearSelection() {
    _list.forEach((category) {
      category.selected = false;
    });
  }
}
