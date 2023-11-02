import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:webshop/model/products.dart';

class ProductView {}

Widget product_preview(Product product, BuildContext context) {
  final CarouselController _carouselController = CarouselController();
  double screenWidth = MediaQuery.of(context).size.width;
  var queryData = MediaQuery.of(context);

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
            autoplayDelay: 5000,
            itemCount: product.imageUrls?.length ?? 0,
            itemBuilder: (context, index) {
              return Image(
                  image: CachedNetworkImageProvider(product.imageUrls?[index] ??
                      'https://imgs.search.brave.com/2ReQeXoSJNl54r5vmMTh340F_J3vLyVIjIziZ3fQHF8/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9jZG40/Lmljb25maW5kZXIu/Y29tL2RhdGEvaWNv/bnMvc2VjdXJpdHkt/MjgzLzY0LzEzLTEy/OC5wbmc'),
                  fit: BoxFit.cover);
            },
            pagination: const SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                  color: Colors.white, activeColor: Colors.black),
            ),
          ),
        ),
        Wrap(
          children: product.imageUrls
                  ?.map((item) => Container(
                        width: 0,
                        height: 0,
                        color: Colors.white,
                        child: Image(
                            image: CachedNetworkImageProvider(item),
                            fit: BoxFit.cover),
                      ))
                  .toList() ??
              [],
        ),
        Column(
          children: [
            Text(
              style: Theme.of(context).textTheme.headlineLarge,
              product.name,
            ),
            Text(
              style: Theme.of(context).textTheme.headlineMedium,
              '\$ ${product.price.toString()}',
            ),
          ],
        ),
      ],
    ),
  );
}
