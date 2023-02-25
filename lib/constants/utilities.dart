import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.green,
       behavior: SnackBarBehavior.floating,
      content: Text(text),
      duration: Duration(seconds: 3),
      action: SnackBarAction(
        label: 'Dismiss',
        onPressed: ()=> ScaffoldMessenger.of(context).hideCurrentSnackBar(),
      ),
      dismissDirection: DismissDirection.startToEnd,
    ),
  );
}
