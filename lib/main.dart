import 'package:blackrose/ui/cart/car_manager.dart';
import 'package:blackrose/ui/order/order_manager.dart';
import 'package:blackrose/ui/product/product_manager.dart';
import 'package:blackrose/ui/welcome/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartManager()),
        ChangeNotifierProvider(
          create: (_) => OrderManager(),
        ),
        ChangeNotifierProvider(create: (_) => ProductManager())
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BlackRose',
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: const SplashView(),
      ),
    );
  }
}
