import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:webshop/controller/product_controller.dart';
import 'package:webshop/model/products.dart';
import 'package:webshop/view/product_preview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  final logoCutout =
      Image.asset('images/GeddesWorksCutout.png', width: 50, height: 50);
  final logoFull = Image.asset('images/GeddesWorks.png');
  late ProductModel model;
  late ProductController con;

  @override
  void initState() {
    super.initState();
    model = ProductModel();
    con = ProductController(this);
    con.getProducts();
  }

  void callSetState(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = (screenWidth > 1200)
        ? 4
        : (screenWidth > 600)
            ? 3
            : 2;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            logoCutout,
            const Text('GeddesWorks Shop'),
          ],
        ),
        backgroundColor: Colors.grey,
      ),
      body: model.inProgress
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
              ),
              children: [
                for (Product product in model.products!)
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: product_preview(product),
                  ),
              ],
            ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}