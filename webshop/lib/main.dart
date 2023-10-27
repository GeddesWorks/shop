import 'package:flutter/material.dart';

import 'view/home_screen.dart';

void main() {
  runApp(const WebShop());
}

class WebShop extends StatelessWidget {
  const WebShop({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.grey,
          fontFamily: 'Roboto'),
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
      },
    );
  }
}
