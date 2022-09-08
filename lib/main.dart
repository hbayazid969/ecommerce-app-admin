import 'package:ecommerce_app/provider/category_provider.dart';
import 'package:ecommerce_app/provider/order_provider.dart';
import 'package:ecommerce_app/screen/login_page.dart';
import 'package:ecommerce_app/screen/registation_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<OrderProvider>(
      create: (_) => OrderProvider(),
    ),
    ChangeNotifierProvider<CategoryProvider>(
      create: (_) => CategoryProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecommerce App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Loginpage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
