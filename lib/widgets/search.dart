import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: TextField(
              cursorColor: Color(0xff8db600),
              decoration: InputDecoration(
                focusColor: Color(0xff8db600),
                iconColor: Color(0xff8db600),
                hintText: "Search",
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                icon: Icon(
                  Icons.search_outlined,
                  color: Color(0xff8db600),
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
              onPressed: () {},
              icon: Icon(
                EvaIcons.options2,
                color: Color(0xff8db600),
              )),
        ),
      ],
    );
  }
}
