import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fresh_mart/cart/order.dart';
import 'package:fresh_mart/providers/locationProvider.dart';
import 'package:fresh_mart/widgets/open_delivery_map.dart';
import 'package:provider/provider.dart';

import '../constants/utilities.dart';
import '../services/product-service.dart';
import 'cart.dart';
import 'cart_page.dart';

class Checkout extends StatefulWidget {
  Checkout({Key? key, required this.index}) : super(key: key);
  int index;

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  int count = 0;
  int quantity = 0;
  int totalQuantity = 0;

  @override
  Widget build(BuildContext context) {
    FocusNode myFocusNode = FocusNode();
    var location = Provider.of<LocationProvider>(context);
    var prod = Provider.of<ProductProvider>(context);
    var cartItem = Provider.of<Cart>(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Theme.of(context).cardColor,
          title: AutoSizeText(
            'My Cart',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).iconTheme.color,
              )),
        ),
        body: SafeArea(
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return ConstrainedBox(
              constraints: constraints.copyWith(
                minHeight: constraints.maxHeight,
                maxHeight: double.infinity,
              ),
              child: Stack(
                children: [
                  IntrinsicHeight(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Products',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.47,
                                        decoration: BoxDecoration(
                                            color: Theme.of(context).cardColor,
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .dividerColor),
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListView.builder(
                                            itemCount:
                                                cartItem.cartItems.length,
                                            itemBuilder: (context, index) {
                                              return Dismissible(
                                                key: UniqueKey(),
                                                onDismissed: (direction) {
                                                  if (direction ==
                                                      DismissDirection
                                                          .startToEnd) {
                                                    setState(() {
                                                      cartItem.removeFromCart(
                                                          cartItem
                                                              .cartItems[index]
                                                              .id);
                                                    });
                                                  } else {
                                                    showSnackBar(context,
                                                        'Please Swipe to the Right');
                                                  }
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 8.0),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 12.0),
                                                    child: Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.13,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Theme.of(context)
                                                                  .cardColor,
                                                          border: Border.all(
                                                              color: Colors
                                                                  .lightGreen,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.001),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30)),
                                                      child: Stack(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        15.0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.1,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.25,
                                                                  decoration: BoxDecoration(
                                                                      border: Border.all(color: Colors.green, width: MediaQuery.of(context).size.width * 0.0005),
                                                                      image: DecorationImage(image: NetworkImage(cartItem.cartItems[index].ImageUrl), fit: BoxFit.cover),
                                                                      // color: Colors.green,
                                                                      borderRadius: BorderRadius.circular(30)),
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          AutoSizeText(
                                                                              'Product: '),
                                                                          AutoSizeText(cartItem
                                                                              .cartItems[index]
                                                                              .Title
                                                                              .toString()),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          AutoSizeText(
                                                                              'Type: '),
                                                                          AutoSizeText(cartItem
                                                                              .cartItems[index]
                                                                              .Category
                                                                              .toString()),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          AutoSizeText(
                                                                            'Price: ',
                                                                          ),
                                                                          AutoSizeText(
                                                                            cartItem.cartItems[index].Price.toString(),
                                                                            style:
                                                                                TextStyle(color: Colors.green),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Flexible(
                                                                      flex: 1,
                                                                      child:
                                                                          ElevatedButton(
                                                                        style: ElevatedButton.styleFrom(
                                                                            shape:
                                                                                CircleBorder(),
                                                                            padding:
                                                                                EdgeInsets.all(5),
                                                                            primary: Colors.green),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          if (cartItem.cartItems[index].count <=
                                                                              1) {
                                                                            cartItem.cartItems[index].count =
                                                                                1;
                                                                          } else {
                                                                            cartItem.remove(index);
                                                                          }
                                                                          // prod.getPrice(widget.index, totalQuantity);

                                                                          // print(prod.);
                                                                        },
                                                                      ),
                                                                    ),
                                                                    AutoSizeText(
                                                                        cartItem
                                                                            .cartItems[
                                                                                index]
                                                                            .count
                                                                            .toString(),
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyMedium),
                                                                    Flexible(
                                                                      flex: 1,
                                                                      child:
                                                                          ElevatedButton(
                                                                        style: ElevatedButton.styleFrom(
                                                                            shape:
                                                                                CircleBorder(),
                                                                            padding:
                                                                                EdgeInsets.all(5),
                                                                            primary: Colors.green),
                                                                        onPressed:
                                                                            () {
                                                                          cartItem
                                                                              .add(index);

                                                                          //   setState(() {
                                                                          //     count++;
                                                                          //   });
                                                                          //   prod.getPrice(widget.index, count);
                                                                        },
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .add,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                // Align(
                                                                //   alignment: Alignment.topRight,
                                                                //   child: ElevatedButton(
                                                                //       style: ElevatedButton.styleFrom(
                                                                //           primary: Colors.red,
                                                                //           shape: CircleBorder(),
                                                                //           padding: EdgeInsets.all(15)),
                                                                //       child: Icon(
                                                                //         Icons.delete_outline_outlined,
                                                                //         color: Colors.white,
                                                                //       ),
                                                                //       onPressed: () {
                                                                //         cartItem.removeFromCart(cartItem.cartItems[index]);
                                                                //       }),
                                                                // ),],)
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.01),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Deliver To',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall,
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.green),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(
                                                Icons.add,
                                              ),
                                              Text('Add',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ],
                                          ),
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        DeliveryLocationPick());
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.01),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                          child: TextFormField(
                                            readOnly: true,
                                            cursorColor: Colors.green,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            decoration: InputDecoration(
                                              icon: Icon(
                                                  Icons.location_on_outlined,
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color),
                                              hintText: location.address==''?'Current Location':location.address,
                                              hintStyle: Theme.of(context)
                                                  .textTheme
                                                  .overline,
                                              labelStyle: TextStyle(
                                                  color: myFocusNode.hasFocus
                                                      ? Colors.black
                                                      : Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Colors.black38)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.green)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.23,
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Order(),
                    ),
                  ),
                ],
              ),
            );
          }),
        ));
  }
}
