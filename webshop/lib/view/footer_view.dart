import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webshop/controller/email_controller.dart';
import 'package:webshop/controller/product_controller.dart';

class Footer extends StatelessWidget {
  EmailController con = EmailController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.grey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          // Image.asset('assets/logo.png'), // Replace with your logo image

          // Contact Info
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contact Info:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              Text(
                'Email: geddesworx@gmail.com',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                'Phone: (405) 757-1880',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),

          // Email Button
          ElevatedButton(
            onPressed: () => con.launchEmail(null),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            ),
            child: Text('Contact Us'),
          ),
        ],
      ),
    );
  }
}
