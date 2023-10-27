import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:parallax/parallax.dart';
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
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   // child: RowSuper(
        //   //   innerDistance: -50,
        //   //   children: [
        //   //     InkWell(
        //   //       key: GlobalKey(),
        //   //       onTap: () {
        //   //         _carouselController.previousPage();
        //   //       },
        //   //       child: Icon(Icons.arrow_back), // Replace with your arrow icon
        //   //     ),
        //   //     SizedBox(
        //   //       width: 500,
        //   //       child: CarouselSlider(
        //   //         carouselController: _carouselController,
        //   //         items: product.images,
        //   //         options: CarouselOptions(
        //   //           aspectRatio: 16 / 9,
        //   //           enlargeCenterPage: true,
        //   //           autoPlay: true,
        //   //         ),
        //   //       ),
        //   //     ),
        //   //     InkWell(
        //   //       onTap: () {
        //   //         _carouselController.nextPage();
        //   //       },
        //   //       child:
        //   //           Icon(Icons.arrow_forward), // Replace with your arrow icon
        //   //     ),
        //   //   ],
        //   // ),
        //   child:
        // ),
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
