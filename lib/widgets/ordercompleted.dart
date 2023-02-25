import 'package:flutter/material.dart';
import 'package:fresh_mart/services/order-service.dart';
import 'package:fresh_mart/widgets/orderpendingwidget.dart';
import 'package:provider/provider.dart';

import 'ordercompletedwidget.dart';

class CompletedOrder extends StatefulWidget {
  const CompletedOrder({Key? key}) : super(key: key);

  @override
  State<CompletedOrder> createState() => _CompletedOrderState();
}
class _CompletedOrderState extends State<CompletedOrder> {
  @override
  void initState() {
    Provider.of<OrderService>(context,listen: false).getApporved(context);
    // TODO: implement initState
    super.initState();
  }
  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }
  @override
  Widget build(BuildContext context) {
    final completed = Provider.of<OrderService>(context);
    return Scaffold(
      body: completed.completedOrder.isEmpty? Center(child: Text('No Approved Orders')): ListView.builder(
        itemCount: completed.completedOrder.length,
        itemBuilder: (context, index) {
         return Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.height * 0.15,
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            OrderImage(
                                imgUrl: completed.completedOrder[index]
                                    .Order_Products[0].ImageUrl),
                            Orderdetail(
                              status: completed.completedOrder[index].Status,
                              count: completed.completedOrder[index].Order_Products[index].count.toString(),
                              title: completed.completedOrder[index].Order_Products[index].Title,
                              date:  completed.completedOrder[index].date,
                              address: completed.completedOrder[index].Address,
                              price: completed.completedOrder[index].Order_Products[index].Price.toString(),
                            ),
                            OrderactionCompleted(id: completed.completedOrder[index].id!)
                          ]),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
