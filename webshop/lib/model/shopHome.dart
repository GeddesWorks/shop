import 'package:flutter/material.dart';
import 'package:webshop/view/shop_home_screen.dart';

import 'products.dart';

class HomeShopModel {
  List<Product>? products;
  bool inProgress = false;
  bool displaySingle = false;
  Widget shopScreen = ShopHomeScreen();
  double screenWidth = 0;
  int crossAxisCount = 0;
}
