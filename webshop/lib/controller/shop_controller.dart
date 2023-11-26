import 'package:flutter/material.dart';
import 'package:webshop/model/products.dart';
import 'package:webshop/view/product_view.dart';
import 'package:webshop/view/shop_home_screen.dart';

class ShopController {
  ShopHomeScreenState state;
  ShopController(this.state);

  void setDisplaySingle(bool value) {
    state.callSetState(() {
      state.model.displaySingle = value;
    });
  }

  void navigateToProductView(Product product) {
    Navigator.pushNamed(state.context, ProductView.routeName,
        arguments: product);
  }

  void navigateToShopHomeScreen() {
    Navigator.pushNamed(state.context, ShopHomeScreen.routeName);
  }
}
