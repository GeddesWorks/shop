import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webshop/model/productView.dart';
import 'package:webshop/model/products.dart';
import 'package:webshop/view/error_screen.dart';
import 'package:webshop/view/product_preview.dart';
import 'package:webshop/view/product_view.dart';

class EmailController {
  Future<void> launchEmail(Product? product) async {
    Uri _emailLaunchUri;
    if (product == null) {
      _emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'geddesworx@gmail.com',
        query: 'subject=Inquiry&body=Hello, I am interested in your services.',
      );
    } else {
      _emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'geddesworx@gmail.com',
        query:
            'subject=Inquiry&body=Hello, I am interested in ${product.name}.}',
      );
    }

    if (await canLaunchUrl(_emailLaunchUri)) {
      await launchUrl(_emailLaunchUri);
    } else {
      throw 'Could not launch email';
    }
  }

  Future<void> orderItem(
      ProductViewModel product, ProductViewState state) async {
    Uri emailLaunchUri;
    String paintRequest =
        product.paintRequest.trim()[product.paintRequest.trim().length - 1] ==
                '.'
            ? product.paintRequest.trim()
            : '${product.paintRequest.trim()}.';
    emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'geddesworx@gmail.com',
      query:
          'subject=Product Order&body=Hello, my name is _______. I am interested in ${product.product.name}. I would like to order ${product.quantity} of them ${product.quantity > 1 ? "at \$${product.product.price} apiece, totaling \$${product.quantity * product.product.price}." : "for \$${product.product.price}."}. ${product.paint ? 'I would like them painted: ${paintRequest}' : ''} ${product.ship ? 'I would like them shipped to: ${product.shipAddress}' : ""}.',
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      if (state.mounted) {
        Navigator.pushNamed(state.context, ErrorScreen.routeName,
            arguments:
                "Could not launch email client. Please email us your order at geddesworx@gmail.com");
      }
    }
  }
}
