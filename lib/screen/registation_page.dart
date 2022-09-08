import 'dart:convert';

import 'package:ecommerce_app/http/custome_http_request.dart';
import 'package:ecommerce_app/screen/login_page.dart';
import 'package:ecommerce_app/widget/brand_colors.dart';
import 'package:ecommerce_app/widget/custom_TextField.dart';
import 'package:ecommerce_app/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistationPage extends StatefulWidget {
  const RegistationPage({Key? key}) : super(key: key);

  @override
  State<RegistationPage> createState() => _RegistationPageState();
}

class _RegistationPageState extends State<RegistationPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isLoading = false;
  getRegister() async {
    setState(() {
      isLoading = true;
    });
    var map = Map<String, dynamic>();
    map["name"] = nameController.text.toString();
    map["email"] = emailController.text.toString();
    map["password"] = passwordController.text.toString();
    map["password_confirmation"] = confirmPasswordController.text.toString();
    var responce = await http.post(
      Uri.parse("$uri/create/new/admin"),
      body: map,
      headers: CustomHttpRequest.defaultHeader,
    );
    print("${responce.body}");
    var data = jsonDecode(responce.body);
    if (responce.statusCode == 201) {
      showInToast("Registation Successful");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Loginpage()));
    } else {
      showInToast("${data["errors"]["email"]}");
    }

    setState(() {
      isLoading = false;
    });
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
                top: 50,
                child: Text(
                  "Please provide your valid information",
                  style: TextStyle(fontSize: 16),
                )),
            Positioned(
              left: 20,
              right: 20,
              top: 80,
              child: CustomTextField(
                controller: nameController,
                hintText: "Enter your name",
              ),
            ),
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
              left: 20,
              right: 20,
              top: 277,
              child: CustomTextField(
                controller: confirmPasswordController,
                hintText: "Confirm password",
              ),
            ),
            Positioned(
                left: 100,
                right: 100,
                top: 370,
                child: InkWell(
                  onTap: () {
                    getRegister();
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
                      "Register",
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
