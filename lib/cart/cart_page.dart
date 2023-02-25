// import 'dart:convert';
//
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fresh_mart/constants/utilities.dart';
// import 'package:fresh_mart/models/order-model.dart';
// import 'package:fresh_mart/models/product-model.dart';
// import 'package:fresh_mart/services/order-service.dart';
// import 'package:fresh_mart/services/product-service.dart';
// import 'package:provider/provider.dart';
//
// import '../widgets/OtherWidgets.dart';
// import 'cart.dart';
//
// class CartScreen extends StatefulWidget {
//   CartScreen({Key? key, required this.index}) : super(key: key);
//   int index;
//
//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }
//
// class _CartScreenState extends State<CartScreen> {
//   int count = 0;
//   int quantity = 0;
//   int totalQuantity = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     var prod = Provider.of<ProductProvider>(context);
//     var cartItem = Provider.of<Cart>(context);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).cardColor,
//         title: AutoSizeText(
//           'My Cart',
//           style: Theme.of(context).textTheme.titleMedium,
//         ),
//         centerTitle: true,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Icon(
//               Icons.arrow_back,
//               color: Theme.of(context).iconTheme.color,
//             )),
//       ),
//       body: SafeArea(
//         child: ListView.builder(
//           itemCount: cartItem.cartItems.length,
//           itemBuilder: (context, index) {
//             return Dismissible(
//               key: UniqueKey(),
//               onDismissed: (direction) {
//                 if (direction == DismissDirection.startToEnd) {
//                   setState(() {
//                     cartItem.removeFromCart(cartItem.cartItems[index].id);
//                   });
//                 } else {
//                   showSnackBar(context, 'Please Swipe to the Right');
//                 }
//               },
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8.0),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                   child: Container(
//                     height: MediaQuery.of(context).size.height * 0.13,
//                     decoration: BoxDecoration(
//                         color: Theme.of(context).cardColor,
//                         borderRadius: BorderRadius.circular(30)),
//                     child: Stack(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Container(
//                               height: MediaQuery.of(context).size.height * 0.1,
//                               width: MediaQuery.of(context).size.width * 0.25,
//                               decoration: BoxDecoration(
//                                   image: DecorationImage(
//                                       image: NetworkImage(
//                                           cartItem.cartItems[index].ImageUrl),
//                                       fit: BoxFit.cover),
//                                   // color: Colors.green,
//                                   borderRadius: BorderRadius.circular(30)),
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Expanded(
//                                   child: Row(
//                                     children: [
//                                       AutoSizeText('Product: '),
//                                       AutoSizeText(cartItem
//                                           .cartItems[index].Title
//                                           .toString()),
//                                     ],
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Row(
//                                     children: [
//                                       AutoSizeText('Type: '),
//                                       AutoSizeText(cartItem
//                                           .cartItems[index].Category
//                                           .toString()),
//                                     ],
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Row(
//                                     children: [
//                                       AutoSizeText('Quantity: '),
//                                       AutoSizeText(cartItem
//                                           .cartItems[index].Quantity
//                                           .toString()),
//                                     ],
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Row(
//                                     children: [
//                                       AutoSizeText(
//                                         'Price: ',
//                                       ),
//                                       AutoSizeText(
//                                         cartItem.cartItems[index].Price
//                                             .toString(),
//                                         style: TextStyle(color: Colors.green),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Flexible(
//                                   flex: 1,
//                                   child: ElevatedButton(
//                                     style: ElevatedButton.styleFrom(
//                                         shape: CircleBorder(),
//                                         padding: EdgeInsets.all(5),
//                                         primary: Colors.green),
//                                     child: Icon(
//                                       Icons.remove,
//                                       color: Colors.white,
//                                     ),
//                                     onPressed: () {
//                                       cartItem.remove(index);
//                                       // prod.getPrice(widget.index, totalQuantity);
//
//                                       // print(prod.);
//                                     },
//                                   ),
//                                 ),
//                                 AutoSizeText(
//                                     cartItem.cartItems[index].count.toString(),
//                                     style:
//                                         Theme.of(context).textTheme.bodyMedium),
//                                 Flexible(
//                                   flex: 1,
//                                   child: ElevatedButton(
//                                     style: ElevatedButton.styleFrom(
//                                         shape: CircleBorder(),
//                                         padding: EdgeInsets.all(5),
//                                         primary: Colors.green),
//                                     onPressed: () {
//                                       cartItem.add(index);
//
//                                       //   setState(() {
//                                       //     count++;
//                                       //   });
//                                       //   prod.getPrice(widget.index, count);
//                                     },
//                                     child: Icon(
//                                       Icons.add,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                         // Align(
//                         //   alignment: Alignment.topRight,
//                         //   child: ElevatedButton(
//                         //       style: ElevatedButton.styleFrom(
//                         //           primary: Colors.red,
//                         //           shape: CircleBorder(),
//                         //           padding: EdgeInsets.all(15)),
//                         //       child: Icon(
//                         //         Icons.delete_outline_outlined,
//                         //         color: Colors.white,
//                         //       ),
//                         //       onPressed: () {
//                         //         cartItem.removeFromCart(cartItem.cartItems[index]);
//                         //       }),
//                         // ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//       floatingActionButton: ElevatedButton(
//           onPressed: () async {
//             print(cartItem.cartItems.length);
//             num sum = 0;
//             List<num> grandTotal = [];
//             cartItem.cartItems.forEach((element) {
//               grandTotal.add(element.count * element.Price);
//             });
//
//             for (var x in grandTotal) {
//               sum = sum + x;
//             }
//             print(sum);
//             OrderModel orderModel = OrderModel(
//                 Order_Products: cartItem.cartItems,
//                 GrandPrice: sum,
//                 Location: 'loc',
//                 Uid: await FirebaseAuth.instance.currentUser!.uid);
//             OrderService orderService = OrderService();
//             orderService.addOrder(orderModel);
//           },
//           child: Text('Order')),
//     );
//   }
// }
