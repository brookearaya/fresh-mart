import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fresh_mart/models/promotion-model.dart';
import 'package:http/http.dart' as http;

class PromotionProvider with ChangeNotifier {
  bool isLoading = true;
  List<PromotionModel> promotions = [];
  Future<void> getPromotions()async{
    Uri uri = Uri.parse('http://192.168.0.41:9000/promotion/getPromotion');
    var response = await http.get(uri);
    var responseData = json.decode(response.body);
    promotions.clear();
    for(var data in responseData)
      {
        promotions.add(PromotionModel(Product: data['Product'], ImageUrl: data['ImageUrl'],Discount: data['Discount'], Description: data['Description']));

      }
    isLoading = false;
    print(promotions.length);
    notifyListeners();

  }
}