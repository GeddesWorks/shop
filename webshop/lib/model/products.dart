import 'package:flutter/material.dart';

class Product {
  List<Image> images = [];
  String name = '';
  String description = '';
  double price = 0.0;
}

List<Product> getProducts() {
  Product Crystal = Product();
  Crystal.name = 'Crystal Dragon';
  Crystal.description = 'A dragon made of crystal';
  Crystal.price = 15.0;
  Crystal.images.add(Image.asset('images/GeddesWorks.png'));
  Crystal.images.add(Image.asset('images/GeddesWorksCutout.png'));

  return [
    Crystal,
    Crystal,
    Crystal,
    Crystal,
    Crystal,
    Crystal,
    Crystal,
    Crystal
  ];
}
