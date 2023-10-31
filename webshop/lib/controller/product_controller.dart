import 'dart:convert';
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
    List<String> names = List<String>.empty(growable: true);
    var images = new Map<String, List<Image>>();

    state.callSetState(() {
      state.model.inProgress = true;
    });

    try {
      await FirebaseFirestore.instance
          .collection("product")
          .get()
          .then((value) {
        value.docs.forEach((element) async {
          names.add(element.id);
        });
      });

      await FirebaseFirestore.instance
          .collection("product")
          .get()
          .then((value) {
        value.docs.forEach((element) async {
          products.add(Product(
            id: element.id,
            name: element["name"],
            description: element["description"] ?? "",
            price: element["price"],
            // images: await getImages(element.id)));
          ));
        });
      });

      var ref = FirebaseStorage.instance.ref();
      var list = await ref.listAll();

      for (var prefix in list.prefixes) {
        var values = await prefix.listAll();
        images[prefix.name] = List<Image>.empty(growable: true);
        for (var value in values.items) {
          var url = await value.getDownloadURL();
          images[prefix.name]!
              .add(Image(image: NetworkImage(url), fit: BoxFit.cover));
        }
      }

      // names.forEach((name) async {
      //   await FirebaseStorage.instance
      //       .ref()
      //       .child(name)
      //       .listAll()
      //       .then((value) {
      //     value.items.forEach((element) {
      //       element.getDownloadURL().then((value) {
      //         products[names.indexOf(name)].images?.add(Image.network(value));
      //         print(value);
      //       });
      //     });
      //   });
      // });
      for (int i = 0; i < products.length; i++) {
        products[i].images = images[products[i].id];
      }

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
