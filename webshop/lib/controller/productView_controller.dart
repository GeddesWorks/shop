import 'package:webshop/view/product_view.dart';

class ProductViewController {
  ProductViewState state;
  ProductViewController(this.state);

  void setPaint(bool? value) {
    if (value == null) return;
    state.callSetState(() {
      state.model.paint = value;
    });
  }

  void setShip(bool? value) {
    if (value == null) return;
    state.callSetState(() {
      state.model.ship = value;
    });
  }

  void incQuantity() {
    state.callSetState(() {
      state.model.quantity++;
    });
  }

  void decQuantity() {
    if (state.model.quantity == 1) return;
    state.callSetState(() {
      state.model.quantity--;
    });
  }

  void setPaintRequest(String value) {
    state.callSetState(() {
      state.model.paintRequest = value;
    });
  }

  void setShipAddress(String value) {
    state.callSetState(() {
      state.model.shipAddress = value;
    });
  }
}
