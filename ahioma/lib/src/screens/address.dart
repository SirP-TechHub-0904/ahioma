import 'package:ahioma/config/ui_icons.dart';
import 'package:ahioma/src/models/user.dart';
import 'package:ahioma/src/widgets/ProfileSettingsDialog.dart';
import 'package:ahioma/src/widgets/SearchBarWidget.dart';
import 'package:ahioma/src/widgets/UpdateAdressDialogue.dart';
import 'package:flutter/material.dart';
import 'package:ahioma/src/models/product.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ahioma/src/widgets/AddressDialogue.dart';

class AddressWidget extends StatefulWidget {
  @override
  _AddressWidgetState createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  User _user = new User.init().getCurrentUser();
  Address adde = Address();
  var id;
  Future<List<Address>> getItems() async {
    try {
      var storage = FlutterSecureStorage();
      var id = await storage.read(key: 'id');
      List<Address> ites;
      ites = await adde.getAdList(id);
      return ites;
    } catch (e) {
      print(e);
    }
  }

  Future<String> getId() async {
    var storage = FlutterSecureStorage();
    id = await storage.read(key: 'id');
    return id;
  }

  @override
  void initState() {
    // TODO: implement initState
    getId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon:
              new Icon(UiIcons.return_icon, color: Theme.of(context).hintColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Address',
          style: Theme.of(context).textTheme.display1,
        ),
        actions: <Widget>[
          // Container(
          //     width: 30,
          //     height: 30,
          //     margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
          //     child: InkWell(
          //       borderRadius: BorderRadius.circular(300),
          //       onTap: () {
          //         Navigator.of(context).pushNamed('/Tabs', arguments: 1);
          //       },
          //       child: CircleAvatar(
          //         backgroundImage: AssetImage('img/user2.jpg'),
          //       ),
          //     )),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 7),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SearchBarWidget(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: <Widget>[
                  // Expanded(
                  //   child: Column(
                  //     children: <Widget>[
                  //       Text(
                  //         'Addresses',
                  //         textAlign: TextAlign.left,
                  //         style: Theme.of(context).textTheme.display2,
                  //       ),
                  //     ],
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //   ),
                  // ),
                ],
              ),
            ),
            FutureBuilder(
              future: getItems(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Address>> snapshot) {
                if (!snapshot.hasData)
                  return Container(
                    child: CircularProgressIndicator(),
                  ); // still loading
                // alternatively use snapshot.connectionState != ConnectionState.done
                var userID = snapshot.data;
                return Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                            color:
                                Theme.of(context).hintColor.withOpacity(0.15),
                            offset: Offset(0, 3),
                            blurRadius: 10)
                      ],
                    ),
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      itemCount: userID.length,
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 15);
                      },
                      itemBuilder: (context, index) {
                        Address item = userID.elementAt(index);
                        print(item.aId);
                        return Container(
                          child: ListView(
                            shrinkWrap: true,
                            primary: false,
                            children: <Widget>[
                              ListTile(
                                leading: Icon(UiIcons.user_1),
                                title: Text(
                                  'Address',
                                  style: Theme.of(context).textTheme.body2,
                                ),
                                trailing: ButtonTheme(
                                  padding: EdgeInsets.all(0),
                                  minWidth: 50.0,
                                  height: 25.0,
                                  child: UpdateAddressDialog(
                                    user: _user,
                                    address: item,
                                    uId: id,
                                    onChanged: () {
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                              ListTile(
                                onTap: () {},
                                dense: true,
                                title: Text(
                                  '${item.fullAddress}',
                                  style: Theme.of(context).textTheme.body1,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ));
              },
            ),
            FutureBuilder(
              future: getId(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (!snapshot.hasData) return Container(); // still loading
                // alternatively use snapshot.connectionState != ConnectionState.done
                var userID = snapshot.data;
                return Column(
                  children: [
                    ListTile(
                      title: Center(
                        child: AddressDialog(
                          user: _user,
                          uId: userID,
                          onChanged: () {
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
