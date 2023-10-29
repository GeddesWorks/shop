import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
        value.docs.forEach((element) async {
          products.add(Product(
              name: element["name"],
              description: element["description"] ?? "",
              price: element["price"],
              images: await getImages(element.id)));
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

  Future<List<Image>> getImages(String name) async {
    List<Image> images = List<Image>.empty(growable: true);

    try {
      await FirebaseStorage.instance
          .ref()
          .child(name)
          .listAll()
          .then((value) {
            value.items.forEach((element) {
              element.getDownloadURL().then((value) {
                images.add(Image.network(value));
              });
            });
          })
          .timeout(const Duration(seconds: 3))
          .catchError((error) => {
                print(error),
                images.add(Image.asset('images/GeddesWorksCutout.png'))
              });
    } catch (e) {
      images.add(Image.asset('images/GeddesWorksCutout.png'));
    }

    return images;
  }
}
