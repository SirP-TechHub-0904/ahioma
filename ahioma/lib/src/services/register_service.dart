import 'dart:convert';

import 'package:http/http.dart';


class Register {
  String email;
  String phoneNumber;
  String password;
  String surname;
  String firstName ;
  String otherNames = ' ';
  DateTime dateRegister = DateTime.now();
  String dateRegistered;
  String role = 'Customer';
  String nextOfKin = ' ';
  String nextOfKinPhoneNumber = ' ';
  String refereeName =' ';
  String refereePhone = ' ';
  String contactAddress = ' ';
  String altPhoneNumber = ' ';
  String state = '';
  String localGovernment =' ';
  String status;
  String reason;




  Register(
  {
    this.email,
    this.phoneNumber,
    this.password,
    this.firstName,
    this.surname
}

 
      );
  Future <void> getRegistered () async{
    dateRegistered = dateRegister.toString();
    String code;
    Map <String,dynamic> toJson() => {

      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      "confirmPassword": password,
      "surname": surname,
      "firstName": firstName,
      "otherNames": otherNames,
      "dateRegistered": dateRegistered,
      "role": role,
      "nextOfKin": nextOfKin,
      "nextOfKinPhoneNumber": nextOfKinPhoneNumber,
      "refereeName": refereeName,
      "refereePhone": refereePhone,
      "contactAddress": contactAddress,
      "altPhoneNumber": altPhoneNumber,
      "state": state,
      "localGovernment": localGovernment
    };

    try {

    Response response = await post(Uri.parse('http://api.ahioma.ng/api/v1/Account/Register'),
      headers: {
      'Content-Type':'application/json'
      },
      body: jsonEncode(toJson()),
    );
     Map data = jsonDecode(response.body);
     code  = (response.statusCode).toString();
    // reason = (response.reasonPhrase);
     print(data);
      status = code ;
  }
  catch(e){
      print (e);
      print(status);
    }
  }
}