import 'dart:convert';
import 'package:ecommerce_app/provider/order_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_app/http/custome_http_request.dart';
import 'package:ecommerce_app/model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<OrderProvider>(context, listen: false).getOrderData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.menu,
            color: Colors.black87,
          ),
        ),
        actions: [
          Icon(
            Icons.camera_alt_outlined,
            color: Colors.black87,
          ),
          SizedBox(
            width: 12,
          )
        ],
      ),
      body: ListView.builder(
          itemCount: categories.orderData.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Card(
              elevation: 35,
              child: Container(
                  padding: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                        height: double.infinity,
                        fit: BoxFit.cover,
                        width: 60,
                      ),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "User Name : ${categories.orderData[index].user!.name}",
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          "Order Status : ${categories.orderData[index].orderStatus!.orderStatusCategory!.name}",
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          "Price : ${categories.orderData[index].price}",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    trailing: Text(
                      "Payment\n Status : ${categories.orderData[index].payment!.paymentStatus}",
                      style: TextStyle(fontSize: 12),
                    ),
                  )),
            );
          }),
    );
  }
}
