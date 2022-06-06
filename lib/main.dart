import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/view/home.dart';

void main() {
  runApp(GetMaterialApp(home: MyApp(), debugShowCheckedModeBanner: false,));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Home();
  }
}

