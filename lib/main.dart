import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fresh_mart/cart/provider.dart';
import 'package:fresh_mart/providers/locationProvider.dart';
import 'package:fresh_mart/services/authentication.dart';
import 'package:fresh_mart/services/category-service.dart';
import 'package:fresh_mart/services/order-service.dart';
import 'package:fresh_mart/services/product-service.dart';
import 'package:fresh_mart/services/promotion-service.dart';
import 'package:fresh_mart/widgets/orderpendingdetail.dart';
import 'package:provider/provider.dart';
import 'cart/cart.dart';
import 'routes/routes.dart' as route;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => Authentication(context)),
      ChangeNotifierProvider(create: (context) => CartCountProvider()),
      ChangeNotifierProvider(create: (context) => ProductProvider()),
      ChangeNotifierProvider(create: (context) => CategoryProvider()),
      ChangeNotifierProvider(create: (context) => PromotionProvider()),
      ChangeNotifierProvider(create: (context) => OrderService()),
      ChangeNotifierProvider(create: (context) =>  Cart()),
      ChangeNotifierProvider(create: (context)=>LocationProvider())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light( ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      onGenerateRoute: route.routesController,
      initialRoute: route.SS,
// home: OrderPendingDetail(),
    );
  }
}
