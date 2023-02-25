import 'package:flutter/cupertino.dart';

class CartCountProvider extends ChangeNotifier {
  int cartCount = 0;

  addCartCount() {
    cartCount++;
    notifyListeners();
  }

  removeCartCount() {
    if (cartCount < 0) {
      cartCount = 0;
    } else {
      cartCount--;
    }
    notifyListeners();
  }
}
