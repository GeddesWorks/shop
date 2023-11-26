import 'package:flutter/material.dart';
import 'package:webshop/controller/error_controller.dart';
import 'package:webshop/controller/shop_controller.dart';

import 'shop_home_screen.dart';

class ErrorScreen extends StatelessWidget {
  final String error;

  static const routeName = '/errorScreen';

  const ErrorScreen(this.error, {super.key});

  @override
  Widget build(BuildContext context) {
    ErrorController con = ErrorController(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Internal Error'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Internal Error Occured: $error',
              style: const TextStyle(
                color: Colors.red,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 16.0),
            OutlinedButton(
                onPressed: con.navigateToShopHomeScreen,
                child: const Text("Go to Home Page"))
          ],
        ),
      ),
    );
  }
}
