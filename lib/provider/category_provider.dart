import 'package:ecommerce_app/http/custome_http_request.dart';
import 'package:ecommerce_app/model/category_model.dart';
import 'package:flutter/cupertino.dart';

class CategoryProvider with ChangeNotifier {
  List<CategoryModel> categoryList = [];

  getCategoryData() async {
    categoryList = await CustomHttpRequest().fetchCategoryData();
    notifyListeners();
  }
}
