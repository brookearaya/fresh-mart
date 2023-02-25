import 'package:flutter/material.dart';
import 'package:fresh_mart/widgets/ordercompleted.dart';
import 'package:fresh_mart/widgets/orderpending.dart';

class Order extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OrderState();
}

class OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              color: Theme.of(context).cardColor,
              child: SafeArea(
                child: TabBar(indicatorColor: Colors.green,
                  tabs: [
                    Text(
                      "Active Orders",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text("Completed Orders",
                        style: Theme.of(context).textTheme.bodyMedium)
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: <Widget>[PendingOrder(), CompletedOrder()],
          ),
        ),
      ),
    );
  }
}
