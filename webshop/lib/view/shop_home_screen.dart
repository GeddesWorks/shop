import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:webshop/controller/email_controller.dart';
import 'package:webshop/controller/product_controller.dart';
import 'package:webshop/controller/shop_controller.dart';
import 'package:webshop/model/shopHome.dart';
import 'package:webshop/model/products.dart';
import 'package:webshop/view/product_preview.dart';

import 'headers.dart';

class ShopHomeScreen extends StatefulWidget {
  const ShopHomeScreen({super.key});

  static const routeName = '/shopHome';

  @override
  State<StatefulWidget> createState() {
    return ShopHomeScreenState();
  }
}

class ShopHomeScreenState extends State<ShopHomeScreen> {
  final logoCutout =
      Image.asset('images/GeddesWorksCutout.png', width: 50, height: 50);
  final logoFull = Image.asset('images/GeddesWorks.png');
  late HomeShopModel model;
  late ShopController con;
  late EmailController econ;
  late ProductController pcon;

  @override
  void initState() {
    super.initState();
    model = HomeShopModel();
    con = ShopController(this);
    pcon = ProductController(this);
    econ = EmailController();
    pcon.getProducts();
  }

  void callSetState(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    model.screenWidth = MediaQuery.of(context).size.width;
    model.crossAxisCount = model.screenWidth > 1200
        ? 4
        : model.screenWidth > 600
            ? 3
            : model.screenWidth > 400
                ? 2
                : 1;

    return Scaffold(
      appBar: ShopAppBar(this),
      body: model.inProgress
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.all(model.screenWidth > 1200 ? 16.0 : 8.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: model.crossAxisCount,
                        childAspectRatio: 4 / 3,
                        mainAxisSpacing: model.screenWidth > 1200 ? 20 : 10,
                        crossAxisSpacing: model.screenWidth > 1200 ? 20 : 10,
                      ),
                      itemCount: model.products?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: product_preview(
                              model.products![index], context, this),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: model.screenWidth <= 600
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
        height: model.screenWidth > 1200
            ? 100
            : model.screenWidth > 600
                ? 75
                : 50,
        child: Footer(),
      ),
    );
  }
}
