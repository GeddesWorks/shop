import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:webshop/controller/email_controller.dart';
import 'package:webshop/controller/productView_controller.dart';
import 'package:webshop/model/constants.dart';
import 'package:webshop/model/productView.dart';
import 'package:webshop/model/products.dart';
import 'package:webshop/view/web_image.dart';

import 'headers.dart';

class ProductView extends StatefulWidget {
  const ProductView({
    required this.product,
    super.key,
  });

  static const routeName = '/productView';

  final Product product;

  @override
  State<StatefulWidget> createState() {
    return ProductViewState();
  }
}

class ProductViewState extends State<ProductView> {
  late ProductViewModel model;
  late ProductViewController con;
  late EmailController emailCon;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    model = ProductViewModel(product: widget.product);
    con = ProductViewController(this);
    emailCon = EmailController();
  }

  void callSetState(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: genericAppBar(context),
      body: SingleChildScrollView(
        child: screenWidth > 1200
            ? Row(
                children: [
                  imageView(screenWidth / 2),
                  productInfo(screenWidth / 2),
                ],
              )
            : Column(
                children: [
                  imageView(screenWidth),
                  productInfo(screenWidth),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      printShopDisclaimer,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget productInfo(double screenWidth) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.product.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(),
            Text(
              '\$ ${model.product.price.toString()}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16.0),
            Text(
              model.product.description,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (model.product.paint)
                  Row(
                    children: [
                      Expanded(
                        flex: 15,
                        child: Text(
                          "This product can be painted for an additional fee. We can airbrush accents or the entire print.",
                          style: Theme.of(context).textTheme.labelLarge,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                      const Spacer(),
                      Checkbox(
                        value: model.paint,
                        onChanged: (value) {
                          con.setPaint(value ?? false);
                        },
                      ),
                    ],
                  ),
                if (model.paint)
                  Column(
                    children: [
                      const SizedBox(height: 8.0),
                      Form(
                        child: TextFormField(
                          style: Theme.of(context).textTheme.headlineMedium,
                          decoration: const InputDecoration(
                            hintText: "Paint request",
                            focusColor: Colors.black,
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 2,
                          onChanged: (value) => con.setPaintRequest(value),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      hintBox(),
                    ],
                  ),
                if (model.product.paint)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(
                      indent: screenWidth / 8,
                      endIndent: screenWidth / 8,
                    ),
                  ),
                if (model.product.ship)
                  Row(
                    children: [
                      Expanded(
                        flex: 15,
                        child: Text(
                            "This product can be shipped for an additional fee. You will be contacted with an estimate after you order.",
                            style: Theme.of(context).textTheme.labelLarge,
                            softWrap: true),
                      ),
                      const Spacer(),
                      Checkbox(
                          value: model.ship,
                          onChanged: (value) {
                            con.setShip(value ?? false);
                          }),
                    ],
                  ),
                if (model.ship)
                  Column(
                    children: [
                      const SizedBox(height: 8.0),
                      Form(
                        child: TextFormField(
                          style: Theme.of(context).textTheme.headlineMedium,
                          decoration: const InputDecoration(
                            hintText: "Enter your address here",
                            focusColor: Colors.black,
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 4,
                          onChanged: (value) => con.setShipAddress(value),
                        ),
                      ),
                    ],
                  ),
                if (model.product.ship)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(
                      indent: screenWidth / 8,
                      endIndent: screenWidth / 8,
                    ),
                  ),
                Row(
                  children: [
                    Text(
                      "Quantity: ",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: con.decQuantity,
                    ),
                    Text(
                      '${model.quantity}',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: con.incQuantity,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Tooltip(
                    message:
                        "This will open your default email client and create a new email to us.",
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size(screenWidth / 3, 50),
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(3.0),
                            ),
                          ),
                        ),
                        onPressed: () => emailCon.orderItem(model, this),
                        child: const Text("Order")),
                  ),
                ),
              ],
            ),
            if (screenWidth > 600)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      printShopDisclaimer,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget imageView(double screenWidth) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: screenWidth * .9,
          height: ((screenWidth * .9) / 5) * 4,
          child: Swiper(
            control: (screenWidth > 600)
                ? const SwiperControl(
                    iconPrevious: Icons.arrow_back,
                    iconNext: Icons.arrow_forward,
                    color: Colors.white,
                  )
                : null,
            autoplay: true,
            autoplayDelay: 5000,
            itemCount: model.product.primaryUrls?.length ?? 0,
            itemBuilder: (context, index) {
              return WebImage(
                  url: model.product.primaryUrls?[index] ??
                      'https://imgs.search.brave.com/2ReQeXoSJNl54r5vmMTh340F_J3vLyVIjIziZ3fQHF8/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9jZG40/Lmljb25maW5kZXIu/Y29tL2RhdGEvaWNv/bnMvc2VjdXJpdHkt/MjgzLzY0LzEzLTEy/OC5wbmc',
                  backupUrl: model.product.imageUrls?[index] ??
                      'https://imgs.search.brave.com/2ReQeXoSJNl54r5vmMTh340F_J3vLyVIjIziZ3fQHF8/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9jZG40/Lmljb25maW5kZXIu/Y29tL2RhdGEvaWNv/bnMvc2VjdXJpdHkt/MjgzLzY0LzEzLTEy/OC5wbmc');
            },
            pagination: const SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                  color: Colors.white, activeColor: Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  Widget hintBox() {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            model.hintExpanded = !model.hintExpanded;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Examples',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Icon(model.hintExpanded
                      ? Icons.expand_more
                      : Icons.expand_less),
                ],
              ),
              if (model.hintExpanded) const SizedBox(height: 8.0),
              if (model.hintExpanded)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: model.hintTexts
                      .map(
                        (hint) => Text(
                          hint,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      )
                      .toList(),
                ),
              const SizedBox(height: 4.0),
            ],
          ),
        ),
      ),
    );
  }
}
