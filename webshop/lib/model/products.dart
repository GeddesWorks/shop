import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:webshop/view/web_image.dart';

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
