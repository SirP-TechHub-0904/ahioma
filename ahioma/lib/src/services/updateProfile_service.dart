import 'dart:convert';

import 'package:http/http.dart';

class Update {
  String email;
  String phoneNumber;
  String password;
  String surname = '';
  String firstName = '';
  String otherNames = '';
  String dob;
  String dateRegistered;
  String role = '';
  String nextOfKin = '';
  String nextOfKinPhoneNumber = '';
  String secQuestion = '';
  String secAnswer = '';
  String status;

  Update(
      {this.firstName,
      this.otherNames,
      this.surname,
        this.dob,
      this.nextOfKin,
      this.nextOfKinPhoneNumber,
      this.secQuestion,
      this.secAnswer});
  Future<void> getRegistered(String id) async {
    String code;
    Map<String, dynamic> toJson() => {
          "surname": surname,
          "firstName": firstName,
          "otherNames": otherNames,
          "nextOfKin": nextOfKin,
          "nextOfKinPhoneNumber": nextOfKinPhoneNumber,
          "dob": dob,
          "securityQuestion": secQuestion,
          "securityAnswer": secAnswer
        };

    try {
      Response response = await put(
          Uri.parse('http://api.ahioma.ng/api/v1/Profile/UpdateProfile?uid=$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(toJson()),
      );
      Map data = jsonDecode(response.body);
      code = (response.statusCode).toString();
      // reason = (response.reasonPhrase);
      print(data);
      status = code;
    } catch (e) {
      print(e);
      print(status);
    }
  }
}
class NewAddress{

  String address;
 String state;
  String localGovernment;
  String status;
 var defaultt = true;
 NewAddress({this.address,this.state,this.localGovernment});


  Future<void>addAddress(String uId) async {

    Map<String, dynamic> toJson() => {

      "id": 0,
      "address": address,
      "state": state,
      "localGovernment": localGovernment,
      "longitude": "",
      "latitiude": "",
      "zipcode": "",
      "userId": uId,
      "userProfileId": 0,
    };

    try {
      Response response = await post(Uri.parse('http://api.ahioma.ng/api/v1/Profile/NewAdressAndMakeItDefault?uid=$uId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(toJson()),
      );
      var data = jsonDecode(response.body);
      status = (data).toString();
      // reason = (response.reasonPhrase);
      print(data);

    } catch (e) {
      print(e);
      print(status);
    }
  }

}
class UpdateAddress {
  String address;
  String state;
  String localGovernment;
  String code;

  UpdateAddress({this.address,this.state,this.localGovernment});

  Future<void>addAddress(String uId,int aId,) async {

    Map<String, dynamic> toJson() => {

      "id": 0,
      "address": address,
      "state": state,
      "localGovernment": localGovernment,
      "longitude": "",
      "latitiude": "",
      "zipcode": "",
      "userId": uId,
      "userProfileId": 0,
      "default":true
    };

    try {
      Response response = await put(Uri.parse('http://api.ahioma.ng/api/v1/Profile/UpdateAdressAndMakeItDefault?aid=$aId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(toJson()),
      );
      var data = jsonDecode(response.body);
      code = (response.statusCode).toString();
      // reason = (response.reasonPhrase);
      print(data);

    } catch (e) {
      print(e);
      print(code);
    }
  }
}
