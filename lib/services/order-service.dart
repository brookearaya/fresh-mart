import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fresh_mart/constants/utilities.dart';
import 'package:fresh_mart/models/order-model.dart';
import 'package:fresh_mart/models/product-model.dart';
import 'package:http/http.dart' as http;

class OrderService with ChangeNotifier {
  List<OrderModel> completedOrder = [];
  List<Products> compProds = [];
  List<OrderModel> orders = [];
  List<Products> prodList = [];
  int count = 0;
  bool isLoading = true;
  Future<void> addOrder(BuildContext context, OrderModel orderModel) async {
    Uri uri = Uri.parse('http://192.168.0.41:9000/order/createOrder');
    var respone = await http
        .post(uri,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8'
            },
            body: jsonEncode({
              "UserPhone": orderModel.UserPhone,
              "GrandPrice": orderModel.GrandPrice,
              "ProductList": orderModel.Order_Products,
              "Longtude": orderModel.Longtude,
              "Latitude": orderModel.Lattitude,
              "Name": orderModel.Name,
              "Status": orderModel.Status,
              "Address": orderModel.Address
            }))
        .then((value) =>
            {showSnackBar(context, 'Order Submitted Successfully!')});
  }

  Future<void> getOrders() async {
    prodList.clear();
    orders.clear();
    Uri uri = Uri.parse(
        'http://192.168.0.41:9000/order/getUserOrder/${FirebaseAuth.instance.currentUser!.phoneNumber}');
    var response = await http.get(uri);
    var responseData = json.decode(response.body);
    for (var data in responseData) {
      // List<Products> prod = [];
      // data['Product'].forEach((d) {
      //   prod.add(new Products(
      //       Title: d["Title"],
      //       ImageUrl: d["ImageUrl"],
      //       Price: d["Price"],
      //       Category: d["Category"],
      //       id: d["id"],
      //       count: d["count"],
      //       Quantity: d["Quantity"]));
      // });
      // orders.add(OrderModel(
      //     Order_Products: prod,
      //     GrandPrice: data['GrandPrice'],
      //     Lattitude: data['Latitude'],
      //     Longtude: data['Longtude'],
      //     UserPhone: data['UserPhone'],
      //     date: data['createdAt'],
      //     Address: data['Address'],
      //     Status: data['Status'],
      //     Name: data['Name']));
      Iterable productList = data['Product'];
      prodList.clear();
      productList.forEach((element) {
        prodList.add(Products(
            Title: element['Title'],
            ImageUrl: element['ImageUrl'],
            Price: element['Price'],
            Category: element['Category'],
            id: element['id'],
            count: element['count'],
            Quantity: element['Quantity']));
      });
      orders.add(OrderModel(
          Order_Products: prodList.toList(),
          GrandPrice: data['GrandPrice'],
          Lattitude: data['Latitude'],
          Longtude: data['Longtude'],
          UserPhone: data['UserPhone'],
          date: data['createdAt'],
          Address: data['Address'],
          Status: data['Status'],
          Name: data['Name']));
    }
    // orders[1].Order_Products.forEach((e) {
    //   print(e.ImageUrl);
    // });
    notifyListeners();
  }

  Future<void> completeOrder(BuildContext context, String id) async {
    Dio _dio = Dio();
    String path = 'http://192.168.0.41:9000/order/completeOrder/${id}';
    try {
      var resposne = await _dio.put(path);
      print(resposne.data);
    } on DioError catch (e) {
      print(e.message);
    }
  }

  Future<void> getApporved(BuildContext context) async {
    compProds.clear();
    completedOrder.clear();
    Uri uri = Uri.parse(
        'http://192.168.0.41:9000/order/getUserOnDelivery/${FirebaseAuth.instance.currentUser!.phoneNumber}');

    var response = await http.get(uri);
    if (response.statusCode == 404) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.body)));
      return;
    }
    var responseData = json.decode(response.body);

    for (var data in responseData) {
      
      compProds.clear();
      Iterable productList = data['Product'];
      productList.forEach((element) {
        compProds.add(Products(
            Title: element['Title'],
            ImageUrl: element['ImageUrl'],
            Price: element['Price'],
            Category: element['Category'],
            id: element['id'],
            count: element['count'],
            Quantity: element['Quantity']));
       
      });
       completedOrder.add(OrderModel(
            Order_Products: compProds.toList(),
            GrandPrice: data['GrandPrice'],
            Lattitude: data['Latitude'],
            Longtude: data['Longtude'],
            UserPhone: data['UserPhone'],
            date: data['createdAt'],
            Address: data['Address'],
            Status: data['Status'],
            id: data['_id'],
            Name: data['Name']));

      notifyListeners();
    }
  }
}
