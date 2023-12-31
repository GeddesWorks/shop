import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:webshop/view/web_image.dart';

class Product {
  List<String>? imageUrls;
  List<String>? primaryUrls;
  final String name;
  final String description;
  final double price;
  final String id;
  final bool ship;
  final bool paint;

  Product(
      {this.imageUrls,
      this.primaryUrls,
      required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.ship,
      required this.paint});
}
