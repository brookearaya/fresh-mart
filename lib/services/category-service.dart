import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fresh_mart/models/category-model.dart';
import 'package:http/http.dart' as http;

class CategoryProvider with ChangeNotifier {
  List<CategoryModel> catagories = [];

  Future<void> getCategory({addAllItems = false}) async {
    Uri uri = Uri.parse('http://192.168.0.41:9000/category/getCategory');
    var response = await http.get(uri);
    var responseData = json.decode(response.body);
    catagories.clear();
    if (addAllItems) catagories.add(
        CategoryModel(Title: "All items", ImageUrl: ""));
    for (var data in responseData) {
      catagories.add(
          CategoryModel(Title: data['Title'], ImageUrl: data['ImageUrl']));
    }
    print(
        "sertual abate -------------------------------------------------------------------------");
    catagories.forEach((element) {
      print(element.Title);
    });
    notifyListeners();

    print(catagories);
    print(catagories.length);
  }
}