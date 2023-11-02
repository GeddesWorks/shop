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
    var textScaleFactor =
        calculateTextScaleFactor(MediaQuery.of(context).size.width);

    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.grey,
        fontFamily: 'Roboto',
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.all<Color>(Colors.black),
        ),
        textTheme: TextTheme(
          headlineSmall: TextStyle(
            fontSize: 10 * textScaleFactor,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          headlineMedium: TextStyle(
            fontSize: 15 * textScaleFactor,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          headlineLarge: TextStyle(
            fontSize: 20 * textScaleFactor,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          bodySmall: TextStyle(
            fontSize: 12 * textScaleFactor,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          bodyMedium: TextStyle(
            fontSize: 16 * textScaleFactor,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          bodyLarge: TextStyle(
            fontSize: 20 * textScaleFactor,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          labelSmall: TextStyle(
            fontSize: 5 * textScaleFactor,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          labelMedium: TextStyle(
            fontSize: 9 * textScaleFactor,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          labelLarge: TextStyle(
            fontSize: 15 * textScaleFactor,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ),
      initialRoute: HomeScreen.routeName,
      title: 'GeddesWorks Shop',
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
      },
    );
  }

  double calculateTextScaleFactor(double screenWidth) {
    // You can adjust these values based on your design and responsiveness needs
    if (screenWidth >= 1200) {
      return 1.5; // Large screens, increase text size
    } else if (screenWidth >= 600) {
      return 1.0; // Medium-sized screens
    } else {
      return .8; // Smaller screens, default text size
    }
  }
}
