import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart' show DateFormat;

class User {
  String id;
  String firstName='';
  String lastName='';
  String email='';
  String otherNames='';
  // String gender;
  DateTime dateOfBirth;
  String avatar;
  String address='';
  String phoneNumber='';
  UserState userState;
  Response response;
  String NOK='';
  String nokNumber='';
  String secQuestion='';
  String secAnswer='';
  String bankName='';
  String accountNum='';
  String acctName='';

  User.advanced(
      {this.firstName='',
      this.email='',
      this.dateOfBirth,
      this.avatar,
      this.address='',
      this.userState,
      this.lastName='',
      this.phoneNumber='',
      this.response,
      this.otherNames='',
      this.NOK='',
      this.nokNumber='',
      this.secAnswer='',
      this.secQuestion='',
      this.id,this.accountNum='',this.acctName='',this.bankName=''});

  User.basic(this.firstName, this.avatar, this.email, this.userState);

  User.init();
  Future<User> getCurrentMainUser (String uId) async {
    String id;
    String firstName='';
    String lastName='';
    String email=' ';
    String otherNames=' ';
    // String gender;
    DateTime dateOfBirth=DateTime.now();
    String avatar;
    String address=' ';
    String phoneNumber=' ';
    UserState userState;

    String NOK=' ';
    String nokNumber=' ';
    String secQuestion=' ';
    String secAnswer=' ';
    String bankName=' ';
    String accountNum=' ';
    String acctName=' ';

    var data;
    print (id);
    try {
      response = await get(
          Uri.parse('http://api.ahioma.ng/api/v1/Profile/GetUserInfo?userid=$uId'),
          headers: {"accept": "application/json"});
      data = jsonDecode(response.body);
      print(response.body);
      if(data['firstName']!=null){
        firstName=data['firstName'];
        print(firstName);
      }
      else firstName='';
      if(data['surname']!=null){
        lastName=data['surname'];
        print(lastName);
      }
      else lastName='';
      if(data['user']['email']!=null){
        email=data['user']['email'];
        print(email);
      }
      else email='';
      if(data['otherNames']==null){
       otherNames='';
      }
      else{
        otherNames=data['otherNames'];
        print(otherNames);
      }
      if(data['dob']==null){
        dateOfBirth = DateTime.now();
      }
      else{
        dateOfBirth=DateTime.parse(data['dob']);
        print(dateOfBirth);
      }
      if(data['nextOfKin']!=null){
        NOK=data['nextOfKin'];
      }
      else NOK='';
      if(data['user']['phoneNumber']!=null){
        phoneNumber=data['user']['phoneNumber'];
      }
      else phoneNumber='';
      if(data['securityQuestion']!=null){
        secQuestion=data['securityQuestion'];
      }
      else secQuestion='';
      if(data['securityAnswer']!=null){
        secAnswer=data['securityAnswer'];
      }
      else secAnswer='';
      if(data['bankName']!=null){
        bankName=data['bankName'];
      }
      else bankName='';
      if(data['accountNumber']!=null){
        accountNum=data['accountNumber'];
      }
      else accountNum='';
      if(data['accountName']!=null){
        acctName=data['accountName'];
      }
      else acctName='';
      return User.advanced(
          id: uId,
          firstName: firstName,
          lastName: lastName,
          otherNames: otherNames,
          email: email,
          dateOfBirth: dateOfBirth,
          avatar: '',
          address: address,
          userState: UserState.available,
          NOK: NOK,
          nokNumber: nokNumber,
          phoneNumber: phoneNumber,
          secQuestion: secQuestion,
          secAnswer: secAnswer,
          bankName:data['bankName'],
          accountNum:data['accountNumber'],
        acctName: data['accountName']
      );

    } catch (e) {
      print(e);
    }
  }

  User getCurrentUser() {
    return User.advanced(
        firstName: '',
        email: 'email',
        dateOfBirth: DateTime(1993, 12, 31),
        avatar: '',
        address: '',
        userState: UserState.available);
  }

  getDateOfBirth() {
    return DateFormat('yyyy-MM-dd').format(this.dateOfBirth);
  }

  getDrawerUser() async {
    print(await otherFunction());
  }

  otherFunction() async {
    final User user = await userDetails();
    return user;
  }

  Future<User> userDetails() async {
    var storage = FlutterSecureStorage();
    id = await storage.read(key: 'id');
    email = await storage.read(key: 'email');
  }
}

enum UserState { available, away, busy }
