import 'package:flutter/material.dart';
import 'package:fresh_mart/services/order-service.dart';
import 'package:provider/provider.dart';

class OrderImageCompleted extends StatefulWidget {
  const OrderImageCompleted({Key? key}) : super(key: key);

  @override
  State<OrderImageCompleted> createState() => _OrderImageCompletedState();
}

class _OrderImageCompletedState extends State<OrderImageCompleted> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.12,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('imageitems/promotion/mango.jpg'),
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover),
          color: Colors.black12,
          borderRadius: BorderRadius.circular(20)),
    );
  }
}

class OrderdetailCompleted extends StatefulWidget {
  const OrderdetailCompleted({Key? key}) : super(key: key);

  @override
  State<OrderdetailCompleted> createState() => _OrderdetailCompletedState();
}

class _OrderdetailCompletedState extends State<OrderdetailCompleted> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Text(
          'Mango',
          style: TextStyle(color: Colors.green),
        )),
        Expanded(
            child: Text('Addis Ababa, Ethiopia',
                style: Theme.of(context).textTheme.overline)),
        Expanded(child: Text('Jult 22, 2022')),
        Expanded(child: Text('1')),
        Expanded(child: Text('80 ETB'))
      ],
    );
  }
}

class OrderactionCompleted extends StatefulWidget {
  String id;
  OrderactionCompleted({
    Key? key,
    required this.id,
  }) : super(key: key);

  //const OrderactionCompleted({Key? key}) : super(key: key);

  @override
  State<OrderactionCompleted> createState() => _OrderactionCompletedState();
}

class _OrderactionCompletedState extends State<OrderactionCompleted> {
  @override
  Widget build(BuildContext context) {
    var order = Provider.of<OrderService>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Expanded(child: Icon(Icons.done_all, color: Colors.green)),
        Expanded(
          child: TextButton(
            onPressed: () {
              order.completeOrder(context, widget.id);
            },
            child:
                Text(style: TextStyle(color: Colors.green), 'Complete Order'),
          ),
        ),
      ],
    );
  }
}
