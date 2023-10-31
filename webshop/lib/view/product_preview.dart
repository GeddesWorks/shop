import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:webshop/model/products.dart';

class ProductView {}

Widget product_preview(Product product, BuildContext context) {
  final CarouselController _carouselController = CarouselController();
  double screenWidth = MediaQuery.of(context).size.width;

  return Container(
    width: 200,
    height: 200,
    decoration: BoxDecoration(
      color: Colors.grey,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      children: [
        Expanded(
          child: Swiper(
            control: (screenWidth > 1200)
                ? const SwiperControl(color: Colors.white)
                : null,
            autoplay: true,
            itemCount: product.images?.length ?? 0,
            itemBuilder: (context, index) {
              return product.images?[index] ??
                  Image.asset("images/GeddesWorks.png");
            },
            pagination: const SwiperPagination(
                builder: DotSwiperPaginationBuilder(
                    color: Colors.white, activeColor: Colors.black)),
          ),
        ),
        Column(
          children: [
            Text(
              style: Theme.of(context).textTheme.headlineMedium,
              product.name,
            ),
            Text(
              style: Theme.of(context).textTheme.headlineSmall,
              '\$ ${product.price.toString()}',
            ),
          ],
        ),
      ],
    ),
  );
}
