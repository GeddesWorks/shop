import 'package:flutter/material.dart';
import 'package:webshop/model/products.dart';
import 'package:webshop/view/product_preview.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  static const routeName = '/home';

  final logoCutout =
      Image.asset('images/GeddesWorksCutout.png', width: 50, height: 50);
  final logoFull = Image.asset('images/GeddesWorks.png');

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = (screenWidth > 1200)
        ? 4
        : (screenWidth > 600)
            ? 3
            : 2;

    List<Product> products = getProducts();

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
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
        ),
        children: [
          for (Product product in products)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: product_preview(product),
            ),
        ],
      ),
    );
  }
}
