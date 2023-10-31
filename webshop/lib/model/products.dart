import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product {
  List<Image>? images;
  final String name;
  final String description;
  final double price;
  final String id;

  Product(
      {this.images,
      required this.id,
      required this.name,
      required this.description,
      required this.price});
}

class ProductModel {
  List<Product>? products;
  bool inProgress = false;
}
