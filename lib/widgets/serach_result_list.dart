import 'dart:ffi';

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';

import 'OtherWidgets.dart';

class Search_Result_List extends StatelessWidget {
  String imgUrl;
  String title;
  num price;
  String category;
  int quantity;

  VoidCallback btnPress;

  Search_Result_List(
      {Key? key,
        required this.imgUrl,
        required this.title,
        required this.price,
        required this.category,
        required this.btnPress,
        required this.quantity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int simpleIntInput = 0;
    return Container(decoration: BoxDecoration(borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10)),border: Border.all(color: Colors.green)),
      margin: EdgeInsets.only(
        left: 20,
        top: 10,
        bottom: 10,
      ),
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width * 0.5,
      child: SingleChildScrollView(
        child: Column(
          
          children: <Widget>[
            Stack(
              children: [
                Image.network(
                  imgUrl,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width,
                ),
              ],
            ),
            GestureDetector(
              onTap: btnPress,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  // color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Colors.green.withOpacity(0.23),
                    ),
                  ],
                ),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: "$title\n".toUpperCase(),
                                style: Theme.of(context).textTheme.button),
                            TextSpan(
                              text: "$category\n".toUpperCase(),
                              style: TextStyle(
                                color: Colors.green.withOpacity(0.5),
                              ),
                            ),
                            TextSpan(
                                text: 'ETB $price\n',
                                style: Theme.of(context).textTheme.button),
                            TextSpan(
                                text: 'Amount $quantity',
                                style: Theme.of(context).textTheme.button)
                          ],
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: CustomQuantity(productId: '1'))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
