import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webshop/controller/email_controller.dart';
import 'package:webshop/controller/product_controller.dart';

class Footer extends StatelessWidget {
  EmailController con = EmailController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.all(MediaQuery.of(context).size.width > 1200 ? 12.0 : 6.0),
      color: Colors.grey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                'images/GeddesWorksCutout.png',
                width: 100,
                height: 100,
              ),
              Image.asset(
                'images/authorizedsellerbadge.png',
                width: 50,
                height: 50,
              ),
              const SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'GeddesWorks Shop',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Text(
                    'Oklahoma City, OK',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contact Info:',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Text(
                'Email: geddesworx@gmail.com',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Text(
                'Phone: (405) 757-1880',
                style: Theme.of(context).textTheme.labelMedium,
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
