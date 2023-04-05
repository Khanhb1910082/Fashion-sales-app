import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:turtle_k/ui/home/bottom_bar.dart';
import 'package:turtle_k/ui/home/home_view.dart';
import 'package:turtle_k/ui/home/list_items.dart';
import 'package:turtle_k/ui/login/login_view.dart';
import 'package:turtle_k/ui/product/product_list.dart';
import 'package:turtle_k/ui/welcome/splash.dart';
import 'test/firebase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashView(),
    );
  }
}
