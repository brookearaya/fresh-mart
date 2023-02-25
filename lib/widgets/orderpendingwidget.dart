import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh_mart/widgets/reusables.dart';

class OrderImage extends StatefulWidget {
  String imgUrl;

  @override
  State<OrderImage> createState() => _OrderImageState();

  OrderImage({
    required this.imgUrl,
  });
}

class _OrderImageState extends State<OrderImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.12,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(widget.imgUrl),
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover),
          color: Colors.black12,
          borderRadius: BorderRadius.circular(20)),
    );
  }
}

class Orderdetail extends StatefulWidget {
  String status;
  String title;
  String date;
  String count;
  String price;
  String address;

  //const Orderdetail({Key? key}) : super(key: key);

  @override
  State<Orderdetail> createState() => _OrderdetailState();

  Orderdetail(
      {required this.status,
      required this.title,
      required this.count,
      required this.date,
      required this.price,
      required this.address});
}

class _OrderdetailState extends State<Orderdetail> {
  @override
  Widget build(BuildContext context) {
    final textscale = MediaQuery.of(context).textScaleFactor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AutoSizeText(
          widget.status,
          style: TextStyle(color: Colors.red),
        ),
        AutoSizeText(
          widget.title,
          style: TextStyle(color: Colors.green),
        ),
        // Expanded(
        //     child: Container(width: MediaQuery.of(context).size.width * 0.3,
        //       height: MediaQuery.of(context).size.height * 0.45,
        //       child: AutoSizeText(widget.address,
        //           style: TextStyle(fontSize: 12 * textscale)),
        //     )),
        AutoSizeText(widget.date.substring(0, 10)),

        Row(
          children: [
            AutoSizeText(
              'Price: ',
            ),
            AutoSizeText(widget.price),
          ],
        )
      ],
    );
  }
}

class Orderaction extends StatefulWidget {
  const Orderaction({Key? key}) : super(key: key);

  @override
  State<Orderaction> createState() => _OrderactionState();
}

class _OrderactionState extends State<Orderaction> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () {},
          child: Icon(Icons.edit_note_outlined),
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: AutoSizeText('Cancel Order'),
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
          ),
        ),
      ],
    );
  }
}
