import 'dart:convert';

import 'package:ecommerce_app/http/custome_http_request.dart';
import 'package:ecommerce_app/screen/home_page.dart';
import 'package:ecommerce_app/tab_item/tab_menu.dart';
import 'package:ecommerce_app/widget/brand_colors.dart';
import 'package:ecommerce_app/widget/custom_TextField.dart';
import 'package:ecommerce_app/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  String loginLink = "https://apihomechef.antopolis.xyz/api/admin/sign-in";

  late SharedPreferences sharedPreferences;

  isLogin() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") != null) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => TabMenu()));
    } else {
      print("Token is empty");
    }
  }

  getLogin() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var map = Map<String, dynamic>();
    map["email"] = emailController.text.toString();
    map["password"] = passwordController.text.toString();
    var responce = await http.post(
      Uri.parse(loginLink),
      body: map,
    );
    if (responce.statusCode == 200) {
      showInToast("Login Succesfull");
      var data = jsonDecode(responce.body);
      setState(() {
        sharedPreferences.setString("token", data["access_token"]);
      });
      token = sharedPreferences.getString("token");

      print("token is $token");
    } else {
      showInToast("Invalid Email or Password");
    }
  }

  String? token;

  @override
  void initState() {
    // TODO: implement initState
    isLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: isLoading == true,
        opacity: 0.70,
        progressIndicator: CircularProgressIndicator(),
        child: Scaffold(
            body: Stack(
          children: [
            Opacity(
              opacity: 0.30,
              child: Image.network(
                "https://cdn.pixabay.com/photo/2016/09/16/19/13/balloon-1674880_1280.png",
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
                left: 25,
                right: 20,
                top: 85,
                child: Text(
                  "Welcome Back",
                  style: TextStyle(fontSize: 25, letterSpacing: 4),
                )),
            Positioned(
              left: 20,
              right: 20,
              top: 145,
              child: CustomTextField(
                controller: emailController,
                hintText: "Enter your email",
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              top: 210,
              child: CustomTextField(
                controller: passwordController,
                hintText: "Enter your password",
              ),
            ),
            Positioned(
                left: 100,
                right: 100,
                top: 340,
                child: InkWell(
                  onTap: () {
                    getLogin();
                  },
                  child: Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                        child: Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 18, color: Colors.white, letterSpacing: 2),
                    )),
                  ),
                ))
          ],
        )),
      ),
    );
  }
}
