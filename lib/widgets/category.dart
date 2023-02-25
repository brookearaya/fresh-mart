import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  String imgUrl;
  String category;
  VoidCallback btnPress;

  Category({
    required this.imgUrl,
    required this.category,
    required this.btnPress,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: 20,
        top: 20 / 2,
        bottom: 20 / 2,
      ),
      width: size.width * 0.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(imgUrl),
        ),
      ),
      child: GestureDetector(
        onTap: btnPress,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DefaultTextStyle(
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          WavyAnimatedText(category),
                        ],
                        isRepeatingAnimation: false,
                        repeatForever: true,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
