import 'package:flutter/material.dart';
import 'package:webshop/view/shop_home_screen.dart';

class ErrorController {
  ErrorController(this.context);

  final BuildContext context;

  void navigateToShopHomeScreen() {
    Navigator.pushNamed(context, ShopHomeScreen.routeName);
  }
}
