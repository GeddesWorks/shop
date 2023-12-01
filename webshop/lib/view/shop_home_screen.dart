import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:webshop/controller/email_controller.dart';
import 'package:webshop/controller/product_controller.dart';
import 'package:webshop/controller/shop_controller.dart';
import 'package:webshop/model/constants.dart';
import 'package:webshop/model/shopHome.dart';
import 'package:webshop/model/products.dart';
import 'package:webshop/view/product_preview.dart';
import 'package:webshop/view/web_image.dart';

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
  final List<Image> welcomeImageAssets = [
    Image.asset('images/welcomeImages/1.jpeg'),
    Image.asset('images/welcomeImages/2.jpeg'),
    Image.asset('images/welcomeImages/3.jpeg'),
    Image.asset('images/welcomeImages/4.jpeg'),
    Image.asset('images/welcomeImages/5.jpeg'),
  ];
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Wrap(
              children: welcomeImageAssets
                  .map(
                    (item) => Container(
                      width: 0,
                      height: 0,
                      color: Colors.white,
                      child: item,
                    ),
                  )
                  .toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: model.screenWidth > 1200
                  ? Row(
                      children: [
                        welcomeImages(context, model.screenWidth / 2),
                        topInfo(context, model.screenWidth / 2),
                      ],
                    )
                  : Column(
                      children: [
                        welcomeImages(context, model.screenWidth / 2),
                        topInfo(context, model.screenWidth / 2),
                      ],
                    ),
            ),
            model.inProgress
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding:
                        EdgeInsets.all(model.screenWidth > 1200 ? 16.0 : 8.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                printShopDisclaimer,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            )
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

  Widget topInfo(context, screenWidth) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: screenWidth,
        height: ((screenWidth * .9) / 5) * 2.9,
        child: Container(
          color: Colors.grey.shade200,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                printShopAbout,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 8.0),
              Text(
                printShopInstructions,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 8.0),
              Text(
                printShopPaymentInstructions,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget welcomeImages(context, screenWidth) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: screenWidth * .9,
          height: ((screenWidth * .9) / 5) * 4,
          child: Swiper(
            viewportFraction: .8,
            scale: .9,
            autoplay: true,
            autoplayDelay: 5000,
            itemCount: welcomeImageAssets.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: welcomeImageAssets[index],
              );
            },
          ),
        ),
      ),
    );
  }
}
