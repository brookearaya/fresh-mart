import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:fresh_mart/models/product-model.dart';

class Cart extends ChangeNotifier {
  List<String> check = [];
  bool dismissButton = false;
  num grandTotalSum = 0;
  int itemCount = 0;
  List<Products> cartItems = [];

  bool dismis(String id) {
    if (check.contains(id)) {
      dismissButton = true;
      notifyListeners();
      return true;
    } else {
      dismissButton = false;
      notifyListeners();
      return false;
    }
  }

  void addToCart(Products items) {
    cartItems.forEach((element) {
      check.add(element.id);
    });
    if (check.contains(items.id)) {
      dismissButton = true;
      notifyListeners();
    } else {
      cartItems.add(Products(
          Title: items.Title,
          ImageUrl: items.ImageUrl,
          Price: items.Price,
          Category: items.Category,
          id: items.id,
          count: items.count,
          Quantity: items.Quantity));
      print(items.id);
      notifyListeners();
    }
  }

  void removeFromCart(String id) {
    cartItems.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void addCartCounter(int index) async {
    int total = cartItems[index].Quantity--;

    notifyListeners();
  }

  num getPrice(int index, int count) {
    num price = cartItems[index].Price * count;
    print(price);
    //notifyListeners();

    return price;
  }

  removeCartCount() {
    if (itemCount < 0) {
      itemCount = 0;
    } else {
      itemCount--;
    }
    notifyListeners();
  }

  add(int index) {
    cartItems[index].count++;
    notifyListeners();
  }

  remove(int index) {
    cartItems[index].count--;
    notifyListeners();
  }

  bool checkCart(int index) {
    if (!cartItems.contains(cartItems[index])) return true;
    {
      return false;
    }
  }

  void calculateGrandTotal() {
    double d = 0;
    num sum = 0;
    List<num> grandTotal = [];
    cartItems.forEach((element) {
      grandTotal.add(element.count * element.Price);
    });

    for (var x in grandTotal) {
      sum = sum + x;
    }
    grandTotalSum = num.parse(sum.toStringAsFixed(2));
    notifyListeners();
  }
}
