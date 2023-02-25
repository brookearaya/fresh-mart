import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fresh_mart/services/order-service.dart';
import 'package:fresh_mart/widgets/orderpendingwidget.dart';
import 'package:provider/provider.dart';

import 'orderpendingdetail.dart';

class PendingOrder extends StatefulWidget {
  const PendingOrder({Key? key}) : super(key: key);

  @override
  State<PendingOrder> createState() => _PendingOrderState();
}

class _PendingOrderState extends State<PendingOrder> {
  @override
  void initState() {
    Provider.of<OrderService>(context, listen: false).getOrders();
    super.initState();
  }

  @override
  void deactivate() {
    Provider.of<OrderService>(context, listen: false).orders.clear();
    Provider.of<OrderService>(context, listen: false).prodList.clear();
    // TODO: implement dispose
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    var orderProvider = Provider.of<OrderService>(context);
    return Scaffold(
      body: orderProvider.orders.isEmpty
          ? Center(child: Text('No pending orders'))
          : ListView.builder(
              shrinkWrap: true,
              itemCount: orderProvider.orders.length,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrderPendingDetail(grandPrice: orderProvider.orders[index].GrandPrice.toString(),
                                location: orderProvider.orders[index].Address,product: orderProvider.orders[index].Order_Products,)));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.14,
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            border: Border.all(
                                color: Theme.of(context).dividerColor),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Stack(
                              children: [
                                OrderImage(
                                    imgUrl: orderProvider.orders[index]
                                        .Order_Products[0].ImageUrl),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black38,
                                      borderRadius: BorderRadius.circular(20)),
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  height:
                                      MediaQuery.of(context).size.height * 0.12,
                                  child: Center(
                                    child: AutoSizeText(
                                      orderProvider
                                          .orders[index].Order_Products.length
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(decoration: BoxDecoration(color: Colors.yellow,borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: AutoSizeText(
                                      'Pending',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    AutoSizeText('No of items: '),
                                    AutoSizeText(orderProvider
                                        .orders[index].Order_Products.length
                                        .toString())
                                  ],
                                ),
                                Row(
                                  children: [
                                    AutoSizeText('Discount: '),
                                    AutoSizeText('-'),
                                    AutoSizeText('0'),
                                    AutoSizeText(' ETB'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    AutoSizeText('Delivery Cost: '),
                                    AutoSizeText('+'),
                                    AutoSizeText('0'),
                                    AutoSizeText(' ETB'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    AutoSizeText('Total Price: '),
                                    AutoSizeText(orderProvider
                                        .orders[index].GrandPrice
                                        .toString()),
                                    AutoSizeText(' ETB'),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Icon(Icons.edit_note_outlined),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.green,
                                  ),
                                ),
                                // ElevatedButton(
                                //   onPressed: () {},
                                //   child: AutoSizeText('Cancel Order'),
                                //   style: ElevatedButton.styleFrom(
                                //     primary: Colors.red,
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
