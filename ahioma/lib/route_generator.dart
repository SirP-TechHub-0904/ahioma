import 'package:ahioma/src/models/route_argument.dart';
import 'package:ahioma/src/screens/brand.dart';
import 'package:ahioma/src/screens/brands.dart';
import 'package:ahioma/src/screens/cart.dart';
import 'package:ahioma/src/screens/categories.dart';
import 'package:ahioma/src/screens/category.dart';
import 'package:ahioma/src/screens/checkout.dart';
import 'package:ahioma/src/screens/checkout_done.dart';
import 'package:ahioma/src/screens/help.dart';
import 'package:ahioma/src/screens/languages.dart';
import 'package:ahioma/src/screens/on_boarding.dart';
import 'package:ahioma/src/screens/orders.dart';
import 'package:ahioma/src/screens/product.dart';
import 'package:ahioma/src/screens/search_results.dart';
import 'package:ahioma/src/screens/shop.dart';
import 'package:ahioma/src/screens/signin.dart';
import 'package:ahioma/src/screens/signup.dart';
import 'package:ahioma/src/screens/tabs.dart';
import 'package:ahioma/src/screens/ahia_pay.dart';
import 'package:flutter/material.dart';
import 'package:ahioma/src/screens/deposit.dart';
import 'package:ahioma/src/screens/withdrawal.dart';
import 'package:ahioma/src/screens/ahia_transfer.dart';
import 'package:ahioma/src/screens/shipping.dart';
import 'package:ahioma/src/screens/address.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => OnBoardingWidget());
      case '/SignUp':
        return MaterialPageRoute(builder: (_) => SignUpWidget(
          doAfter: args,
        ));
      case '/SignIn':
        return MaterialPageRoute(builder: (_) => SignInWidget(doAfter: args,));
      case '/Categories':
        return MaterialPageRoute(builder: (_) => CategoriesWidget());
      case '/Orders':
        return MaterialPageRoute(builder: (_) => OrdersWidget());
      case '/Brands':
        return MaterialPageRoute(builder: (_) => BrandsWidget());
      case '/Withdrawal':
        return MaterialPageRoute(builder: (_) => WithdrawalWidget(routeAgrument: args as RouteArgument));
      case '/AhiaPay':
        return MaterialPageRoute(builder: (_) => AhiaPayWidget());
      case '/Shipping':
        return MaterialPageRoute(builder: (_) => ShippingWidget());
      case '/Deposit':
        return MaterialPageRoute(builder: (_) => DepositWidget());
      case '/Address':
        return MaterialPageRoute(builder: (_) => AddressWidget());
      case '/AhiaTransfer':
        return MaterialPageRoute(builder: (_) => AhiaTransferWidget(routeArgument: args as RouteArgument));
//      case '/MobileVerification':
//        return MaterialPageRoute(builder: (_) => MobileVerification());
//      case '/MobileVerification2':
//        return MaterialPageRoute(builder: (_) => MobileVerification2());
      case '/Tabs':
        return MaterialPageRoute(
            builder: (_) => TabsWidget(
                  currentTab: args,
                ));
      case '/Category':
        return MaterialPageRoute(builder: (_) => CategoryWidget(routeArgument: args as RouteArgument));
      case '/Shop':
        return MaterialPageRoute(builder: (_) => ShopWidget(routeArgument: args as RouteArgument));
      case '/SearchResult':
        return MaterialPageRoute(builder: (_) => SearchResultWidget(routeArgument: args as RouteArgument,));
      case '/Brand':
        return MaterialPageRoute(builder: (_) => BrandWidget(routeArgument: args as RouteArgument));
      case '/Product':
        return MaterialPageRoute(builder: (_) => ProductWidget(routeArgument: args as RouteArgument));
//      case '/Food':
//        return MaterialPageRoute(
//            builder: (_) => FoodWidget(
//              routeArgument: args as RouteArgument,
//            ));
      case '/Cart':
        return MaterialPageRoute(builder: (_) => CartWidget());
      case '/Checkout':
        return MaterialPageRoute(builder: (_) => CheckoutWidget(routeAgrument: args as RouteArgument,));
      case '/CheckoutDone':
        return MaterialPageRoute(builder: (_) => CheckoutDoneWidget());
      case '/Help':
        return MaterialPageRoute(builder: (_) => HelpWidget());
      case '/Languages':
        return MaterialPageRoute(builder: (_) => LanguagesWidget());
//      case '/second':
//      // Validation of correct data type
//        if (args is String) {
//          return MaterialPageRoute(
//            builder: (_) => SecondPage(
//              data: args,
//            ),
//          );
//        }
//        // If args is not of the correct type, return an error page.
//        // You can also throw an exception while in development.
//        return _errorRoute();
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
