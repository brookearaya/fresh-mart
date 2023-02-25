import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fresh_mart/models/product-model.dart';
import 'package:fresh_mart/services/order-service.dart';
import 'package:provider/provider.dart';

class OrderPendingDetail extends StatelessWidget {
  OrderPendingDetail(
      {required this.grandPrice,
      required this.location,
      required this.product});

  // const OrderPendingDetail({Key? key}) : super(key: key);
  String grandPrice;
  String location;
  List<Products> product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        title: Text(
          'Detail',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              color: Theme.of(context).cardColor,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.26,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AutoSizeText('Order Summary',
                          style: Theme.of(context).textTheme.labelLarge),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AutoSizeText('Sub Total'),
                          Row(
                            children: [
                              AutoSizeText(grandPrice),
                              AutoSizeText(' ETB'),
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AutoSizeText('Discount'),
                          Row(
                            children: [
                              AutoSizeText('- 0'),
                              AutoSizeText(' ETB'),
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AutoSizeText('Delivery Cost'),
                          Row(
                            children: [
                              AutoSizeText('+ 0'),
                              AutoSizeText(' ETB'),
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AutoSizeText('Total Payable'),
                          Row(
                            children: [
                              AutoSizeText(grandPrice),
                              AutoSizeText(' ETB'),
                            ],
                          )
                        ],
                      ),
                    ]),
              ),
            ),
            Container(
              color: Theme.of(context).cardColor,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        'Order Item',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.22,
                        width: MediaQuery.of(context).size.width,
                        // decoration: BoxDecoration(
                        //     border: Border.all(
                        //         color: Theme.of(context).dividerColor),
                        //     borderRadius: BorderRadius.circular(20)),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: product.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                  top: 10,
                                  bottom: 10,
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(0, 10),
                                            blurRadius: 50,
                                            color:
                                                Colors.green.withOpacity(0.23),
                                          ),
                                        ],
                                      ),
                                      child: Image.network(
                                        product[index].ImageUrl,
                                        fit: BoxFit.cover,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Theme.of(context).dividerColor),
                                        // color: Theme.of(context).cardColor,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(0, 10),
                                            blurRadius: 50,
                                            color:
                                                Colors.green.withOpacity(0.23),
                                          ),
                                        ],
                                      ),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                  text:
                                                      "${product[index].Title}\n"
                                                          .toUpperCase(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .button),
                                              TextSpan(
                                                text: "Fruit\n".toUpperCase(),
                                                style: TextStyle(
                                                  color: Colors.green
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                              TextSpan(
                                                  text:
                                                      'Quantity: ${product[index].count}\n',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .button),
                                              TextSpan(
                                                  text:
                                                      '${product[index].Price} ETB',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .button),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                              //   Row(children: [
                              //   Padding(
                              //     padding: const EdgeInsets.all(4.0),
                              //     child: Container(
                              //       width:
                              //           MediaQuery.of(context).size.width * 0.3,
                              //       height:
                              //           MediaQuery.of(context).size.height * 0.11,
                              //       decoration: BoxDecoration(
                              //           border: Border.all(
                              //               color: Colors.green,
                              //               width: MediaQuery.of(context)
                              //                       .size
                              //                       .width *
                              //                   0.001),
                              //           image: DecorationImage(
                              //               image: NetworkImage(
                              //                   product[index].ImageUrl),
                              //               filterQuality: FilterQuality.high,
                              //               fit: BoxFit.cover),
                              //           color: Colors.black12,
                              //           borderRadius: BorderRadius.circular(20)),
                              //     ),
                              //   ),
                              //   Padding(
                              //     padding: const EdgeInsets.all(12.0),
                              //     child: Column(
                              //       mainAxisAlignment:
                              //           MainAxisAlignment.spaceBetween,
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.start,
                              //       children: [
                              //         AutoSizeText(product[index].Title),
                              //         Row(
                              //           children: [
                              //             AutoSizeText(product[index].count.toString()),
                              //             AutoSizeText(' * '),
                              //             AutoSizeText(product[index].Price.toString()),
                              //             AutoSizeText('ETB'),
                              //           ],
                              //         ),
                              //       ],
                              //     ),
                              //   )
                              // ]);
                            }),
                      )
                    ]),
              ),
            ),
            Container(
              color: Theme.of(context).cardColor,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText('Location',
                          style: Theme.of(context).textTheme.labelLarge),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.green,
                          ),
                          AutoSizeText(location,
                              style: Theme.of(context).textTheme.caption),
                        ],
                      )
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
