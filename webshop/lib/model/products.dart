import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product {
  final List<Image> images;
  final String name;
  final String description;
  final double price;

  Product(
      {required this.images,
      required this.name,
      required this.description,
      required this.price});
}

class ProductModel {
  List<Product>? products;
  bool inProgress = false;
}
