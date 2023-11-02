import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product {
  List<String>? imageUrls;
  final String name;
  final String description;
  final double price;
  final String id;

  Product(
      {this.imageUrls,
      required this.id,
      required this.name,
      required this.description,
      required this.price});
}

class ProductModel {
  List<Product>? products;
  bool inProgress = false;
  bool displaySingle = false;
}
