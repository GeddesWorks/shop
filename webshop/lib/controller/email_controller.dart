import 'package:url_launcher/url_launcher.dart';
import 'package:webshop/model/products.dart';

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
}
