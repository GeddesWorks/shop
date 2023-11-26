import 'package:webshop/model/products.dart';

class ProductViewModel {
  ProductViewModel({required this.product});

  Product product;
  bool paint = false;
  int quantity = 1;
  bool ship = false;
  String paintRequest = '';
  String shipAddress = '';
  bool hintExpanded = false;

  List<String> hintTexts = [
    '"Frost the tips with light blue paint."',
    '"Paint the underside black."',
    '"Lightly dust the whole thing with glittery paint."',
  ];
}
