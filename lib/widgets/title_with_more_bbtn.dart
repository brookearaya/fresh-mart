import 'package:flutter/material.dart';

class TitleWithMoreBtn extends StatelessWidget {
  String title;

  VoidCallback btnPress;

  TitleWithMoreBtn({
    required this.title,
    required this.btnPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: <Widget>[
            Text(title,style: TextStyle(color: Colors.green),),
            Spacer(),
            ElevatedButton(
              onPressed: btnPress,
              child: Text('More'),
              style: ElevatedButton.styleFrom(
                // fixedSize: Size(MediaQuery.of(context).size.width * 0.2,MediaQuery.of(context).size.height * 0.03),
                primary: Colors.green,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
              ),
            )
          ],
        ));
  }
}

class TitleWithCustomUnderline extends StatelessWidget {
  String text;

  TitleWithCustomUnderline({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Text(
          text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
