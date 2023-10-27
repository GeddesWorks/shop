import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:webshop/model/products.dart';

class ProductView {}

Widget product_preview(Product product) {
  final CarouselController _carouselController = CarouselController();

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
            control: SwiperControl(color: Colors.white),
            autoplay: true,
            itemCount: product.images.length,
            itemBuilder: (context, index) {
              return product.images[index];
            },
            pagination: SwiperPagination(
                builder: DotSwiperPaginationBuilder(
                    color: Colors.white, activeColor: Colors.black)),
          ),
        ),
        Text(product.name),
        Text(product.description),
        Text(product.price.toString()),
      ],
    ),
  );
}
