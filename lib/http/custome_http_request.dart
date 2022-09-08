import 'dart:convert';

import 'package:ecommerce_app/model/category_model.dart';
import 'package:ecommerce_app/model/order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CustomHttpRequest {
  static const Map<String, String> defaultHeader = {
    "Accept": "application/json",
    "Authorization":
        "bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYXBpaG9tZWNoZWYuYW50b3BvbGlzLnh5elwvYXBpXC9hZG1pblwvc2lnbi1pbiIsImlhdCI6MTY1NDAwNzYwNiwiZXhwIjoxNjY2OTY3NjA2LCJuYmYiOjE2NTQwMDc2MDYsImp0aSI6IjlLWGFGNmRFdlgwWVNZVzIiLCJzdWIiOjUwLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.Cbii274lgjkMIf2Ix9fZ7e8HPAT47B5MV0QP03Rd520",
  };

  late SharedPreferences sharedPreferences;

  Future<Map<String, String>> getHeaderWithToken() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var header = {
      "Accept": "application/json",
      "Authorization": "bearer ${sharedPreferences.getString("token")}",
    };

    return header;
  }

  fetchOrderData() async {
    List<OrderModel> orderData = [];
    late OrderModel orderModel;
    var responce = await http.get(
        Uri.parse("https://apihomechef.antopolis.xyz/api/admin/all/orders"),
        headers: await CustomHttpRequest().getHeaderWithToken());
    if (responce.statusCode == 200) {
      var data = jsonDecode(responce.body);
      print("Order list are $data");
      for (var item in data) {
        orderModel = OrderModel.fromJson(item);

        orderData.add(orderModel);
      }
    }
    return orderData;
  }

  fetchCategoryData() async {
    List<CategoryModel> categoryList = [];
    late CategoryModel categoryModel;
    var responce = await http.get(
        Uri.parse("https://apihomechef.antopolis.xyz/api/admin/category"),
        headers: await CustomHttpRequest().getHeaderWithToken());
    if (responce.statusCode == 200) {
      var data = jsonDecode(responce.body);
      print("Order list are $data");
      for (var item in data) {
        categoryModel = CategoryModel.fromJson(item);

        categoryList.add(categoryModel);
      }
    }
    return categoryList;
  }
}
