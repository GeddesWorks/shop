import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:webshop/view/home_screen.dart';

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
              name: element["name"],
              description: element["description"] ?? "",
              price: element["price"],
              images: [
                Image.asset('images/GeddesWorks.png'),
                Image.asset('images/GeddesWorksCutout.png')
              ]));
        });

        state.callSetState(() {
          state.model.inProgress = false;
          state.model.products = products;
        });
      });
    } catch (e) {
      state.callSetState(
        () {
          state.model.inProgress = false;
          state.model.products = [
            Product(
                images: [Image.asset('images/GeddesWorksCutout.png')],
                name: "Error getting products: $e",
                description: '',
                price: 0)
          ];
        },
      );
    }
  }
}
