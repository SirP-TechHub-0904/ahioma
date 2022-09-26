import 'package:ahioma/config/ui_icons.dart';
import 'package:ahioma/src/models/route_argument.dart';
import 'package:ahioma/src/services/home_service.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  SearchBarWidget({
    Key key,
  }) : super(key: key);
  final search = TextEditingController();
  final SearchValue alue=SearchValue();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.10), offset: Offset(0, 4), blurRadius: 10)
        ],
      ),
      child: Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[
          Form(
            key: _formKey,
            child: TextFormField(
              onFieldSubmitted: (value){
             if (_formKey.currentState.validate()) {
                alue.value=search.text;
                Navigator.of(context).pushNamed('/SearchResult', arguments: RouteArgument(argumentsList: [alue]));
              }
             },
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }

                return null;
              },
              controller: search,
              decoration: InputDecoration(

                hintText: 'Search',
                hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.8)),
                prefixIcon: Icon(UiIcons.loupe, size: 20, color: Theme.of(context).hintColor),
                border: UnderlineInputBorder(borderSide: BorderSide.none),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
          // IconButton(
          //   onPressed: () {
          //     Scaffold.of(context).openEndDrawer();
          //
          //   },
          //   icon: Icon(UiIcons.settings_2, size: 20, color: Theme.of(context).hintColor.withOpacity(0.5)),
          // ),
        ],
      ),
    );
  }
}
