import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/bottom_bar.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 1, milliseconds: 500), () {
      Get.offAll(const BottomBar());
    });
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(300),
                ),
                child: const SizedBox(
                  width: 250,
                  height: 250,
                  child: Image(
                    image: AssetImage("assets/logo/blackRose_logo.png"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
