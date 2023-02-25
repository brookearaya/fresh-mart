import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fresh_mart/constants/utilities.dart';
import 'package:fresh_mart/models/product-model.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  String errorMessage = "";
  int productStatusCode = 200;
  bool productLoading = true;
  bool isLoading = true;
  List<Products> productList = [];

  Future<void> fetchProducts() async {
    Uri uri = Uri.parse('http://192.168.0.41:9000/products/getProducts');
    var response = await http.get(
      uri,
    );
    var responseData = json.decode(response.body);
    productList.clear();
    for (var data in responseData) {
      productList.add(Products(
          id: data['_id'],
          Title: data['Title'],
          ImageUrl: data['ImageUrl'],
          Price: data['Price'],
          Category: data['Category'],
          Quantity: data['Quantity'],
          count: data['Count']));
    }
    isLoading = false;
    productLoading = false;
    productStatusCode = 200;
    notifyListeners();

    print(productList.length);
  }

  Future<void> fetchProductsByTitle(BuildContext context, String title) async {
    Uri uri = Uri.parse(
        'http://192.168.0.41:9000/products/getProductByTitle/' + title);
    Dio dio = Dio();
    var response = await http.get(uri);
    if (response.statusCode == 404) {
      productStatusCode = 404;
      notifyListeners();
    } else {
      var responseData = json.decode(response.body);

      productList.clear();
      for (var data in responseData) {
        productList.add(Products(
            Title: data['Title'],
            ImageUrl: data['ImageUrl'],
            Price: data['Price'],
            Category: data['Category'],
            id: data['_id'],
            count: data['Count'],
            Quantity: data['Quantity']));
        print(data);
      }
      productLoading = false;
      notifyListeners();
    }
  }

  Future<void> getProductByCategory(
      BuildContext context, String category) async {
    if(category == 'All items'){
     await fetchProducts();
    }
    else {
      productList.clear();
      isLoading = true;
      notifyListeners();
      String uri =
          'http://192.168.0.41:9000/products/getProductByCategory/${category}';
      Dio _dio = Dio();
      try {
        var response = await _dio.get(uri);

        var data = response.data;

        productList.clear();
        notifyListeners();
        for (var items in data) {
          productList.add(Products(
              Title: items['Title'],
              ImageUrl: items['ImageUrl'],
              Price: items['Price'],
              Category: items['Category'],
              id: items['_id'],
              count: items['Count'],
              Quantity: items['Quantity']));
        }
        errorMessage = '200';
        print(productList.length);
        isLoading = false;
        notifyListeners();
      } on DioError catch (e) {

        isLoading = false;
        notifyListeners();
      }
    }
  }
}
