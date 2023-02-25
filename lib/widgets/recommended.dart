import 'dart:ffi';

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';

import 'OtherWidgets.dart';

class Recommended extends StatelessWidget {
  String imgUrl;
  String title;
  num price;
  String category;
  String id;
  int quantity;
  int? index;

  VoidCallback btnPress;

  Recommended(
      {Key? key,
      required this.imgUrl,
      required this.title,
      required this.price,
      required this.category,
      required this.btnPress,
      required this.id,
      required this.quantity,
    })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int simpleIntInput = 0;
    return Container(
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
        top: 10,
        bottom: 10,
      ),
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        children: <Widget>[
          Stack(
            children: [
              Image.network(
                imgUrl,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width,
              ),
              // Align(
              //   alignment: Alignment.topRight,
              //   child: Padding(
              //     padding: const EdgeInsets.all(5.0),
              //     child: Container(
              //       width: MediaQuery.of(context).size.width * 0.1,
              //       decoration: BoxDecoration(
              //           color: Colors.black12,
              //           borderRadius: BorderRadius.all(Radius.circular(10))),
              //       child: Padding(
              //         padding: const EdgeInsets.symmetric(vertical: 2.0),
              //         child: FavoriteButton(
              //           isFavorite: true,
              //           iconColor: Colors.white,
              //           iconSize: 34,
              //           iconDisabledColor: Colors.red,
              //           valueChanged: (_isFavorite) {
              //             print('Favorite : $_isFavorite');
              //           },
              //         ),
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
          GestureDetector(
            onTap: btnPress,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).dividerColor),
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
                      alignment: Alignment.bottomRight,
                      child: CustomQuantity(productId: id))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
