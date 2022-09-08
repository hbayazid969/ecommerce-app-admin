import 'package:ecommerce_app/screen/add_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../provider/category_provider.dart';
import '../widget/brand_colors.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    Provider.of<CategoryProvider>(context, listen: false).getCategoryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final category = Provider.of<CategoryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Product Category",
          style: TextStyle(color: Colors.black, fontSize: 13),
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
      body: Container(
        width: double.infinity,
        child: category.categoryList.isNotEmpty
            ? NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  setState(() {
                    if (notification.direction == ScrollDirection.forward) {
                      _buttonVisiable = true;
                    } else if (notification.direction ==
                        ScrollDirection.reverse) {
                      _buttonVisiable = false;
                    }
                  });
                  return true;
                },
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: category.categoryList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 10,
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 200,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 224, 235, 224),
                              borderRadius: BorderRadius.circular(10)),
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5),
                                        ),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              "https://apihomechef.antopolis.xyz/images/${category.categoryList[index].image ?? ""}"),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 25,
                                        ),
                                        Expanded(
                                          child: Text(
                                            '${category.categoryList[index].name ?? ""}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                                width: 0.1),
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(5)),
                                          ),
                                          child: TextButton(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.edit,
                                                  size: 15,
                                                  color: aTextColor,
                                                ),
                                                Text(
                                                  'Edit',
                                                  style: TextStyle(
                                                    color: aTextColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            onPressed: () {
                                              /*Navigator.push(context,
                                          MaterialPageRoute(
                                              builder: (context) {
                                                return CategoryEditPage(
                                                  id: categories
                                                      .categoriesList[index].id,
                                                  index: index,
                                                  name: categories.categoriesList[index].name,
                                                );
                                              })).then((value) => categories.getCategories(context,onProgress));*/
                                            },
                                          ),
                                        )),
                                        Container(
                                          height: 30,
                                          width: 0.5,
                                          color: Colors.grey,
                                        ),
                                        Expanded(
                                            child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                                width: 0.1),
                                            borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(5)),
                                          ),
                                          child: TextButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                          'Are you sure ?'),
                                                      titleTextStyle: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: aTextColor),
                                                      titlePadding:
                                                          EdgeInsets.only(
                                                              left: 35,
                                                              top: 25),
                                                      content: Text(
                                                          'Once you delete, the item will gone permanently.'),
                                                      contentTextStyle:
                                                          TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  aTextColor),
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              left: 35,
                                                              top: 10,
                                                              right: 40),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        15,
                                                                    vertical:
                                                                        10),
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5)),
                                                                border: Border.all(
                                                                    color:
                                                                        aTextColor,
                                                                    width:
                                                                        0.2)),
                                                            child: Text(
                                                              'CANCEL',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color:
                                                                      aTextColor),
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                        TextButton(
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        15,
                                                                    vertical:
                                                                        10),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .redAccent
                                                                  .withOpacity(
                                                                      0.2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                              5)),
                                                            ),
                                                            child: Text(
                                                              'Delete',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color:
                                                                      aPriceTextColor),
                                                            ),
                                                          ),
                                                          onPressed: () async {
                                                            /*    CustomHttpRequest.deleteCategoryItem(
                                                        context,
                                                        categories
                                                            .categoriesList[
                                                        index]
                                                            .id)
                                                        .then((value) =>
                                                    value);
                                                    setState(() {
                                                      categories
                                                          .categoriesList
                                                          .removeAt(
                                                          index);
                                                    });
                                                    Navigator.pop(
                                                        context);*/
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  });
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.delete,
                                                  size: 15,
                                                  color: Colors.red,
                                                ),
                                                Text(
                                                  'Delete',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Positioned(
                                left: 40,
                                top: 80,
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
                                      color: Colors.white,
                                      border: Border.all(
                                          color: aTextColor, width: 0.5)),
                                  child: Center(
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              "https://apihomechef.antopolis.xyz/images/${category.categoryList[index].icon ?? ""}"),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                      ;
                    }),
              )
            : Center(
                child: CircularProgressIndicator(
                value: null,
                strokeWidth: 3.0,
              )),
      ),
      floatingActionButton: _buttonVisiable == true
          ? FloatingActionButton(
              onPressed: () {
                /*   Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddCategory())).then((value) => categories.getCategories(context,onProgress));
        */
                Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddCategory()))
                    .then((value) => category.getCategoryData());
              },
              backgroundColor: Colors.green,
              child: Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              ),
            )
          : null,
    );
  }

  bool onProgress = false;

  bool _buttonVisiable = true;

  ScrollController? _scrollController;
}
