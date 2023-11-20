import 'dart:convert';
import 'dart:js';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webshop/view/home_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../model/products.dart';

class ProductController {
  HomeScreenState state;
  ProductController(this.state);

  Future<void> getProducts() async {
    List<Product> products = List<Product>.empty(growable: true);

    state.callSetState(() {
      state.model.inProgress = true;
    });

    try {
      await FirebaseFirestore.instance
          .collection("product")
          .get()
          .then((value) {
        value.docs.forEach((element) {
          products.add(Product(
            id: element.id,
            name: element["name"],
            description: element["description"] ?? "",
            price: element["price"],
            imageUrls: List.from(element["imageUrls"]),
          ));
        });
      });

      state.callSetState(() {
        state.model.inProgress = false;
        state.model.products = products;
      });
    } catch (e) {
      state.callSetState(
        () {
          state.model.inProgress = false;
          state.model.products = [
            Product(
                id: "error",
                imageUrls: [
                  'https://imgs.search.brave.com/2ReQeXoSJNl54r5vmMTh340F_J3vLyVIjIziZ3fQHF8/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9jZG40/Lmljb25maW5kZXIu/Y29tL2RhdGEvaWNv/bnMvc2VjdXJpdHkt/MjgzLzY0LzEzLTEy/OC5wbmc'
                ],
                name: "Error getting products: $e",
                description: '',
                price: 0)
          ];
        },
      );
    }
  }

  void setDisplaySingle(bool value) {
    state.callSetState(() {
      state.model.displaySingle = value;
    });
  }
}
