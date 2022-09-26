import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:ahioma/src/models/user.dart';


class UserModel extends Model {
  User currentUser;
  var user;
  Response response;
  Future <void> getCurrentUser(id) async{
    var data;
    try{
      response= await get(Uri.parse('http://api.ahioma.ng/api/v1/Profile/GetUserInfo?userid=$id'),
          headers:
          {
          "accept": "application/json"
          });
      data = jsonDecode(response.body);
      if(response.statusCode==200){
       return User.advanced(firstName:data['firstName'], email:data['user']['email'],dateOfBirth: DateTime.parse(data['dob']), avatar:'https://cdn.onlinewebfonts.com/svg/img_568656.png',
           address: data['userAddresses'][0]['address'], userState:UserState.available,lastName: data['surname']);
      }
    }
    catch(e){
      print(e);
      print(user);
    }

  }
  void login ( user){
    currentUser=user;
  }
  User get currentUserr{
    return currentUser;
  }
}