import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart' show DateFormat;

class AhiaPay {
  String walletId;
  String userId;
  String ledgerBalance;
  String withdrawableBalance;
  Response response;

  AhiaPay(
      {this.userId,
      this.walletId,
      this.withdrawableBalance,
      this.ledgerBalance});

  Future<AhiaPay> getCurrentWallet(id) async {
    var data;
    try {
      response = await get(
          Uri.parse('http://api.ahioma.ng/api/v1/Wallets/AhiaPayBalance?uid=$id'),
          headers: {"accept": "application/json"});
      data = jsonDecode(response.body);
      return AhiaPay(
        userId: id,
        walletId: data['id'].toString(),
        ledgerBalance: data['balance'].toString(),
        withdrawableBalance: data['withdrawBalance'].toString(),
      );
    } catch (e) {
      print(e);
    }
  }
}

class Transactions {
  String transId;
  String userId;
  String walletId;
  String note;
  String amount;
  String transactionType;
  String status;
  String description;
  String trackCode;
  String datOfTransaction;
  Transactions(
      {this.transId,
      this.walletId,
      this.userId,
      this.description,
      this.amount,
      this.note,
      this.status,
      this.trackCode,
      this.transactionType,
      this.datOfTransaction});
}

class TransactionList {
  var lisst = [];
  Response response;
  List<Transactions> get list => lisst;

  Future<List> getTransactions(id, pageNumber) async {
    var data;
    try {
      response = await get(
          Uri.parse('http://api.ahioma.ng/api/v1/Wallets/TransactionHistory?PageNumber=$pageNumber&PageSize=10&uid=$id'),
          headers: {"accept": "application/json"});
      data = jsonDecode(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        for (var item in data) {
          print(item['description']);
          Transactions trans = Transactions(
              transId: item['id'].toString(),
              userId: id,
              walletId: item['walletId'].toString(),
              note: item['note'],
              amount: item['amount'].toString(),
              status: item['status'].toString(),
              description: item['description'],
              trackCode: item['trackCode'],
              datOfTransaction: item['dateOfTransaction']);
          lisst.add(trans);
        }
      }
      return lisst;
    } catch (e) {
      print(e);
    }
  }
}

class Deposit {
  String walletId;
  String transId;
  String userId;
  int amount;
  String email;
  String phone;
  String firstName;
  String lastName;
  Response response;
  Deposit(
      {this.amount,
      this.transId,
      this.userId,
      this.walletId,
      this.email,
      this.firstName,
      this.lastName});
  Future<Deposit> beginDeposit(String id, int amount) async {
    var data;
    try {
      response = await post(
          Uri.parse('http://api.ahioma.ng/api/Transaction/InitializeDeposit?uid=$id&amount=$amount'),
          headers: {"accept": "application/json"});
      data = jsonDecode(response.body);
      return Deposit(
          userId: id,
          walletId: data['walletId'].toString(),
          transId: data['transactionId'].toString(),
          email: data['email'],
          amount: amount,
          firstName: data['firstName'],
          lastName: data['surname']);
    } catch (e) {
      print(e);
    }
  }
}

class UpdateDeposit {
  String walletId;
  String transId;
  String userId;
  int amount;
  String email;
  String phone;
  Response response;
  Future<void> updateDeposit(String userId, int transId, int status) async {
    var data;
    try {
      response = await put(
          Uri.parse('http://api.ahioma.ng/api/Transaction/UpdateDepositAterPayment?uid=$userId&tid=$transId&status=$status'),
          headers: {"accept": "application/json"});
      data = jsonDecode(response.body);
    } catch (e) {
      print(e);
    }
  }
}

class AhiaTransfer {
  String message = '';
  Response response;

  Future<void> ahiaTransfer(
      String userId, int amount, String number, String note) async {
    var data;
    try {
      response = await post(
          Uri.parse('http://api.ahioma.ng/api/v1/Wallets/AhiaPayTransfer?sid=$userId&amount=$amount&phoneNumber=$number&note=$note'),
          headers: {"accept": "application/json"});
      data = jsonDecode(response.body);
      print(data);
      message = data.toString();
    } catch (e) {
      print(e);
    }
  }
}

class initWithdrawal {
  String message;
  Response response;
  Future<void> initWithdraw(String id,double amount) async {
    var data;
    try {
      response = await post(
          Uri.parse('http://api.ahioma.ng/api/Transaction/InitializeWithdrawalToBank?uid=$id&amount=$amount'),
          headers: {"accept": "application/json"});
          data = jsonDecode(response.body);
          if (data['status']=="Success"){
            message = '';
          }
          else{
            message=data['status'];
          }
    } catch (e) {
      print(e);
    }
  }
}
class Withdraw{
  String message;
  Response response;
  Future<void> withdraw(String id,String amount) async {
    var data;
    try {
      response = await put(
          Uri.parse('http://api.ahioma.ng/api/Transaction/WithdrawalToBank?uid=$id&iamount=$amount'),
          headers: {"accept": "application/json"});
      data = jsonDecode(response.body);
      message= data.toString();
    } catch (e) {
      print(e);
    }
  }

}
class initCheckout{
String status;
String source;
String transRef;
String transId;
String custRef;
String orderId;
String ahiaPayStat;
String ahiaTransId;
String transType;
String amount;
String email;
String firstName;
String lastName;

initCheckout({this.amount,this.transId,this.email,this.status,this.ahiaPayStat,this.ahiaTransId,this.custRef,this.orderId,this.source,this.transRef,this.transType,this.lastName,this.firstName});
  Response response;
  Future<initCheckout>initCheckou(String uId,String payMeth) async {
    var data;
    try {
      response = await put(
          Uri.parse('http://api.ahioma.ng/api/CheckOut/InitializeCheckOut?uid=$uId&paymentMethod=$payMeth'),
          headers: {"accept": "application/json"});
      data = jsonDecode(response.body);
      if (response.statusCode==200){

       initCheckout checkout = initCheckout(
         amount: data['amount'],
         status: data['status'] ,
         source: data['source'],
         transId: data['transaction_id'],
         email:data['email'],
         ahiaPayStat: data['ahiapaystatus'],
         ahiaTransId: data['transaction_id'],
         custRef: data['customerRef'],
         orderId: data['orderid'],
         transRef: data['tranxRef'],
         transType: data['transactiontype'],
         lastName: data['surname'],
         firstName: data['firstname']
       );
       return checkout;
      }
    } catch (e) {
      print(e);
    }
  }
}
class Bank {
  String bankName;
  String code;
  Response response;
  var bankList =<Bank>[];
  Bank({this.bankName,this.code});


  Future<List<Bank>>getBanks() async {
    var data;
    int o=0;
    try {
      response = await put(
          Uri.parse('http://api.ahioma.ng/api/Transaction/GetBankList'),
          headers: {"accept": "application/json"});
      data = jsonDecode(response.body);
      if (response.statusCode==200){
        for (var item in data){
          Bank bank =Bank(
            bankName:data[o]['bankName'],
            code:data[o]['bankCode']
          );
          bankList.add(bank);
          o++;
        }
      }
    }
  catch(e){
     print (e);
  }
  return bankList;
  }
}
