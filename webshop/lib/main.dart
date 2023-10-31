import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'view/home_screen.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        fontFamily: 'Roboto',
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.all<Color>(Colors.black),
        ),
      ),
      initialRoute: HomeScreen.routeName,
      title: 'GeddesWorks Shop',
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
      },
    );
  }
}
