import 'dart:convert';
import 'package:http/http.dart';

class AttemptLogin {
  String email;
  String password;
  String loggin;
  Response response;
  String status;
  String id;
  String firstName;

  Map <String ,dynamic> toJson()=>{
    'email':email,
    'password':password
  };


  AttemptLogin({this.email,this.password});

  Future <String> login () async{


    try{

       response = await post(Uri.parse('http://api.ahioma.ng/api/v1/Account/Login'),headers:{'Content-Type':'application/json'},body:
        jsonEncode(toJson()));
       Map data = jsonDecode(response.body);
           if (response.statusCode == 200) {
         loggin = data['token'];
         id = data['userDto']['id'];
         firstName = data['userDto']['firstName'];
         status = response.statusCode.toString();
         print(id);
         return response.body.toString();

       }
    else{
    status = response.body.toString();
    }
    return null;


  }


    catch (e){
      print(e);
    }


}}