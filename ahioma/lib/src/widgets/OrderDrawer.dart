import 'package:ahioma/config/ui_icons.dart';
import 'package:ahioma/src/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'dart:convert';

class OrderDrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<OrderDrawerWidget> {
  User _user = new User.init();
  var id;
  var email;
  var storage;
  var name;
  callBackOd(){
    Navigator.of(context).pushNamed('/Orders');}
  callBackSe(){
    Navigator.of(context).pushNamed('/Tabs', arguments: 1);}
  Map <String,dynamic> toJson() => {

    'email': email,};

  Future <User> userDetails() async {
    storage = FlutterSecureStorage();
    id = await storage.read(key: 'id');
    email = await storage.read(key: 'email');
    name = await storage.read(key: 'firstName');
    return User.basic(name,'https://www.searchpng.com/wp-content/uploads/2019/02/Deafult-Profile-Pitcher.png', email,UserState.available);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView(
        children: <Widget>[
          FutureBuilder(future: userDetails(),
              builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                if (!snapshot.hasData) return Container(); // still loading
                // alternatively use snapshot.connectionState != ConnectionState.done
                final User userID = snapshot.data;
                // return a widget here (you have to return a widget to the builder)
                return GestureDetector(
                  onTap: () {
                    if(id=='guest'){
                      Navigator.popAndPushNamed(context, '/SignUp',
                          arguments: (){
                            Navigator.of(context).pushNamed('/Tabs', arguments: 1);});
                    }
                    else{
                      Navigator.of(context).pushNamed('/Tabs', arguments: 1);
                    }
                  },
                  child: UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: Theme
                          .of(context)
                          .hintColor
                          .withOpacity(0.1),
//              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35)),
                    ),
                    accountName: Text(
                      '${userID.firstName}',
                      style: Theme
                          .of(context)
                          .textTheme
                          .title,
                    ),
                    accountEmail: Text(
                      '${userID.email}',
                      style: Theme
                          .of(context)
                          .textTheme
                          .caption,
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Theme
                          .of(context)
                          .accentColor,
                      backgroundImage: NetworkImage('${userID.avatar}'),
                    ),
                  ),
                );
              }
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Tabs', arguments: 2);
            },
            leading: Icon(
              UiIcons.home,
              color: Theme
                  .of(context)
                  .focusColor
                  .withOpacity(1),
            ),
            title: Text(
              "Home",
              style: Theme
                  .of(context)
                  .textTheme
                  .subhead,

            ),
          ),
          // ListTile(
          //   onTap: () {
          //     Navigator.of(context).pushNamed('/Tabs', arguments: 0);
          //   },
          //   leading: Icon(
          //     UiIcons.bell,
          //     color: Theme.of(context).focusColor.withOpacity(1),
          //   ),
          //   title: Text(
          //     "Notifications",
          //     style: Theme.of(context).textTheme.subhead,
          //   ),
          // ),
          ListTile(
            onTap: () {
              if(id=='guest'){
                Navigator.popAndPushNamed(context, '/SignUp',
                    arguments: () {Navigator.of(context).pushNamed('/Orders');});
              }
              else Navigator.of(context).pushNamed('/Orders', arguments: 1);
            },
            leading: Icon(
              UiIcons.inbox,
              color: Theme
                  .of(context)
                  .focusColor
                  .withOpacity(1),
            ),
            title: Text(
              "My Orders",
              style: Theme
                  .of(context)
                  .textTheme
                  .subhead,
            ),
          ),
          // ListTile(
          //   onTap: () {
          //     Navigator.of(context).pushNamed('/Tabs', arguments: 4);
          //   },
          //   leading: Icon(
          //     UiIcons.heart,
          //     color: Theme.of(context).focusColor.withOpacity(1),
          //   ),
          //   title: Text(
          //     "Wish List",
          //     style: Theme.of(context).textTheme.subhead,
          //   ),
          // ),
          ListTile(
            dense: true,
            title: Text(
              "Products",
              style: Theme
                  .of(context)
                  .textTheme
                  .body1,
            ),
            trailing: Icon(
              Icons.remove,
              color: Theme
                  .of(context)
                  .focusColor
                  .withOpacity(0.3),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Tabs', arguments: 4);
            },
            leading: Icon(
              UiIcons.folder_1,
              color: Theme
                  .of(context)
                  .focusColor
                  .withOpacity(1),
            ),
            title: Text(
              "Categories",
              style: Theme
                  .of(context)
                  .textTheme
                  .subhead,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Tabs', arguments: 0);
            },
            leading: Icon(
              UiIcons.folder_1,
              color: Theme
                  .of(context)
                  .focusColor
                  .withOpacity(1),
            ),
            title: Text(
              "Markets",
              style: Theme
                  .of(context)
                  .textTheme
                  .subhead,
            ),
          ),
          ListTile(
            dense: true,
            title: Text(
              "Application Preferences",
              style: Theme
                  .of(context)
                  .textTheme
                  .body1,
            ),
            trailing: Icon(
              Icons.remove,
              color: Theme
                  .of(context)
                  .focusColor
                  .withOpacity(0.3),
            ),
          ),
          // ListTile(
          //   onTap: () {
          //     Navigator.of(context).pushNamed('/Help');
          //   },
          //   leading: Icon(
          //     UiIcons.information,
          //     color: Theme
          //         .of(context)
          //         .focusColor
          //         .withOpacity(1),
          //   ),
          //   title: Text(
          //     "Help & Support",
          //     style: Theme
          //         .of(context)
          //         .textTheme
          //         .subhead,
          //   ),
          // ),
          ListTile(
            onTap: () {
              if(id=='guest'){
                Navigator.popAndPushNamed(context, '/SignUp',
                    arguments: (){
                      Navigator.of(context).pushNamed('/Tabs', arguments: 1);});
              }
              else Navigator.of(context).pushNamed('/Tabs', arguments: 1);
            },
            leading: Icon(
              UiIcons.settings_1,
              color: Theme
                  .of(context)
                  .focusColor
                  .withOpacity(1),
            ),
            title: Text(
              "Settings",
              style: Theme
                  .of(context)
                  .textTheme
                  .subhead,
            ),
          ),
          // ListTile(
          //   onTap: () {
          //     Navigator.of(context).pushNamed('/Languages');
          //   },
          //   leading: Icon(
          //     UiIcons.planet_earth,
          //     color: Theme.of(context).focusColor.withOpacity(1),
          //   ),
          //   title: Text(
          //     "Languages",
          //     style: Theme.of(context).textTheme.subhead,
          //   ),
          // ),
          ListTile(
            onTap: () async {
              if(id=='guest'){
                Navigator.popAndPushNamed(context, '/',
                );
              }
              else await post(Uri.parse('http://api.ahioma.ng/api/v1/Account/Logout'),
                headers: {
                  'Content-Type':'application/json'
                },
                body: jsonEncode(toJson()),
              );
              await  storage.write(key: 'login', value:'a');
              Navigator.of(context).popAndPushNamed('/SignIn');
            },
            leading: Icon(
              UiIcons.upload,
              color: Theme
                  .of(context)
                  .focusColor
                  .withOpacity(1),
            ),
            title: Text(
              "Log out",
              style: Theme
                  .of(context)
                  .textTheme
                  .subhead,
            ),
          ),
          ListTile(
            dense: true,
            title: Text(
              "Version 0.0.1",
              style: Theme
                  .of(context)
                  .textTheme
                  .body1,
            ),
            trailing: Icon(
              Icons.remove,
              color: Theme
                  .of(context)
                  .focusColor
                  .withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }
}
