import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresh_mart/cart/cart.dart';
import 'package:fresh_mart/providers/locationProvider.dart';
import 'package:fresh_mart/services/authentication.dart';
import 'package:fresh_mart/views/app/order.dart';
import 'package:fresh_mart/views/app/order.dart';
import 'package:provider/provider.dart';

import '../models/order-model.dart';
import '../services/order-service.dart';

class Order extends StatelessWidget {
  String address = '';

  Order({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartItem = Provider.of<Cart>(context);
    final userProv = Provider.of<Authentication>(context);
    final location = Provider.of<LocationProvider>(context);

    cartItem.calculateGrandTotal();
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.23,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          // Expanded(
          //   child: TextFormField(
          //     decoration: InputDecoration(
          //       labelText: 'Please enter your delivery address'
          //     ),
          //     onSaved: (val){
          //       address =val!;
          //     },
          //
          //
          //   ),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtotal',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                cartItem.grandTotalSum.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              )
            ],
          ),
          SizedBox(
            height: 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Discount',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('(-) 0 ETB')
            ],
          ),
          // SizedBox(
          //   height: 10,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Delivery Fee',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                'Free',
                style: TextStyle(fontSize: 16),
              )
            ],
          ),
          // SizedBox(
          //   height: 10,
          // ),
          Divider(
            thickness: 3,
          ),
          // SizedBox(
          //   height: 10,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              Text(
                cartItem.grandTotalSum.toString(),
                // '60.98 ETB',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              )
            ],
          ),
          // SizedBox(
          //   height: 10,
          // ),
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.06,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ElevatedButton(
                onPressed: cartItem.cartItems.isEmpty? null : () async {
                  //       print(cartItem.cartItems.length);
                  // num sum = 0;
                  // List<num> grandTotal = [];
                  // cartItem.cartItems.forEach((element) {
                  //   grandTotal.add(element.count * element.Price);
                  // });
                  //
                  // for (var x in grandTotal) {
                  //   sum = sum + x;
                  // }
                  //print(sum);
                  OrderModel orderModel = OrderModel(
                    Order_Products: cartItem.cartItems,
                    GrandPrice: cartItem.grandTotalSum,
                    Longtude: location.long,
                    Lattitude: location.lat,
                    date: DateTime.now().toString(),
                    UserPhone: userProv.user!.phoneNumber!,
                    Address: location.address,
                    Name: userProv.userList[0].fullName,
                    Status: 'pending',
                  );
                  OrderService orderService = OrderService();
                  orderService.addOrder(context, orderModel);
//
                },
                child: AutoSizeText(
                  'Confirm Order',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(primary: Colors.green),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
