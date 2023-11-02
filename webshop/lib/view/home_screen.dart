import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:webshop/controller/email_controller.dart';
import 'package:webshop/controller/product_controller.dart';
import 'package:webshop/model/products.dart';
import 'package:webshop/view/product_preview.dart';

import 'footer_view.dart';

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
  late EmailController econ;

  @override
  void initState() {
    super.initState();
    model = ProductModel();
    con = ProductController(this);
    con.getProducts();
    econ = EmailController();
  }

  void callSetState(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth > 1200
        ? 4
        : screenWidth > 600
            ? 3
            : screenWidth > 400
                ? 2
                : 1;
    if (model.displaySingle) crossAxisCount = 1;
    if (screenWidth > 1200) con.setDisplaySingle(false);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            logoCutout,
            SizedBox(
                width: screenWidth > 1200
                    ? 16.0
                    : screenWidth > 600
                        ? 8.0
                        : 4.0),
            const Text('GeddesWorks Shop'),
          ],
        ),
        actions: [
          if (screenWidth < 1200 && screenWidth > 400) const Text("Large View"),
          if (screenWidth < 1200 && screenWidth > 400)
            Switch(
              value: model.displaySingle,
              onChanged: (value) {
                con.setDisplaySingle(value);
              },
            ),
        ],
        backgroundColor: Colors.grey,
      ),
      body: model.inProgress
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth > 1200 ? 16.0 : 8.0),
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: 4 / 3,
                        mainAxisSpacing: screenWidth > 1200 ? 20 : 10,
                        crossAxisSpacing: screenWidth > 1200 ? 20 : 10,
                      ),
                      children: [
                        for (Product product in model.products!)
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: product_preview(product, context),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
      floatingActionButton: screenWidth <= 600
          ? ElevatedButton(
              onPressed: () => econ.launchEmail(null),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
              child: Text('Contact Us'),
            )
          : null,
      bottomNavigationBar: SizedBox(
        height: screenWidth > 1200
            ? 100
            : screenWidth > 600
                ? 75
                : 50,
        child: Footer(),
      ),
    );
  }
}
