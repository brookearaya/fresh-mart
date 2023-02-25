import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fresh_mart/widgets/serach_result_list.dart';

class Search_Result extends StatefulWidget {
  const Search_Result({Key? key}) : super(key: key);

  @override
  State<Search_Result> createState() => _Search_ResultState();
}

class _Search_ResultState extends State<Search_Result> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(appBar: AppBar(
            backgroundColor: Colors.green,
            title: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: TextField(cursorColor: Colors.green,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search, color: Colors.green),
                    suffixIcon: IconButton(
                      icon: const Icon(EvaIcons.options2, color: Colors.green,),
                      onPressed: () {
                        /* Clear the search field */
                      },
                    ),
                    hintText: 'Search...',
                    border: InputBorder.none,),
                ),
              ),
            )
        ),
            body: Search_Result_List(
        imgUrl:
        'https://www.santosfood.com/wp-content/uploads/2020/01/img-7.jpg',
        title: 'Orange',
        price: 90,
        category: "Fruit",
        btnPress: () {},
    quantity: 23)));
  }
}
