import 'dart:convert';

import 'package:fresh_mart/models/product-model.dart';

class OrderModel {
  List<Products> Order_Products;
  String? id;
  num GrandPrice;
  String UserPhone;
  String Address;
  String Name;
  String Status;
  String date;
  double Longtude;
  double Lattitude;

  OrderModel(
      {required this.Order_Products,
      this.id,
      required this.GrandPrice,
      required this.UserPhone,
      required this.Address,
      required this.Name,
      required this.date,
      required this.Longtude,
      required this.Lattitude,
      required this.Status});

  Map<String, dynamic> toMap() {
    return {
      'Order_Products': this.Order_Products,
      'GrandPrice': this.GrandPrice,
      'UserPhone': this.UserPhone,
      'Address': this.Address,
      'Name': this.Name,
      'Status': this.Status
    };
  }

//

// Map<String, dynamic> toJson(OrderModel orderModel) {
//   return {
//     "Order_Products": jsonEncode(this.Order_Products.map((e) => e.toJson()).toList()),
//     "GrandPrice": this.GrandPrice,
//     "Location": this.Location,
//     "Uid": this.UserPhone,
//
//   };
// }
}
