import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getxpoc/core/constants/api_url_const.dart';
import 'package:getxpoc/core/constants/preference_util.dart';
import 'package:getxpoc/core/constants/variable_const.dart';
import 'package:getxpoc/core/middleware.dart';
import 'package:get/get.dart';
import 'package:getxpoc/screens/authendication_pages/view/login_view.dart';
import 'package:getxpoc/screens/product_list/controller/product_list_controller.dart';
import 'package:getxpoc/screens/product_list/model/leftcategory_model.dart';
import 'package:getxpoc/screens/product_list/model/product_list_model.dart';
import 'package:getxpoc/screens/product_list/view/product_list_view.dart';
import 'package:getxpoc/screens/product_list/view/product_search_list_view.dart';

class HomeView extends StatefulWidget {
  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  MiddleWare middleWare = MiddleWare();
  final controller = Get.put(ProductListController());
  List<ProductListModel> filterProductList = [];

  @override
  void initState() {
    try {
      super.initState();
    } catch (e) {
      //print(e);
    }
  }

  goToProductListScreen() {
    try {
      Get.to(() => ProductListView());
    } catch (e) {
      //print(e);
    }
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 24.0,
            color: Colors.white,
          ),
          onPressed: () {
            onBackPressed(0);
          },
        ),
        title: Text(
          "Home",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: <Widget>[
          Obx(() => controller.productList != null &&
                  controller.productList.length > 0
              ? IconButton(
                  icon: Icon(
                    Icons.search_sharp,
                    size: 24.0,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    try {
                      Get.to(() => ProductSearchListView());
                    } catch (e) {
                      //print(e);
                    }
                  },
                )
              : SizedBox.shrink()),
          IconButton(
            icon: Icon(
              Icons.logout_sharp,
              size: 24.0,
              color: Colors.white,
            ),
            onPressed: () {
              try {
                onBackPressed(1);
              } catch (e) {
                //print(e);
              }
            },
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        color: Colors.white,
        //padding: EdgeInsets.all(20),
        child: Obx(() => !controller.loadingData.isTrue
            ? Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 250,
                        child: GestureDetector(
                          onTap: () {
                            goToProductListScreen();
                          },
                          child: CarouselSlider(
                            options: CarouselOptions(
                              autoPlay: true,
                              aspectRatio: 2.0,
                              enlargeCenterPage: true,
                            ),
                            items: [
                              Image.asset('assets/cart/slide1.jpg'),
                              Image.asset('assets/cart/slide2.jpg'),
                              Image.asset('assets/cart/slide3.jpg'),
                            ],
                          ),
                        ),
                      ),
                      controller.leftCategoryList != null &&
                              controller.leftCategoryList.length > 0
                          ? Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Categories',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                        color: Colors.black),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      goToProductListScreen();
                                    },
                                    child: Text(
                                      'See all',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.0,
                                          color: Colors.green),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox.shrink(),
                      controller.leftCategoryList != null &&
                              controller.leftCategoryList.length > 0
                          ? Container(
                              width: double.infinity,
                              height: 150,
                              child: ListView.builder(
                                itemCount: controller.leftCategoryList.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: ClampingScrollPhysics(),
                                padding: EdgeInsets.only(
                                  bottom: 10,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  LeftCategoryModel leftCategoryModel =
                                      controller.leftCategoryList[index];

                                  String imageData = "";

                                  try {
                                    if (leftCategoryModel?.isocode.toString() !=
                                            null &&
                                        !middleWare
                                            .validString(leftCategoryModel
                                                ?.isocode
                                                .toString())
                                            .contains("undefined")) {
                                      imageData = middleWare.validString(
                                          baseLeftCategoryImageURL +
                                              "${leftCategoryModel.lookupId.toString()}/${leftCategoryModel.isocode}");
                                    }

                                    print("left Category imageData $imageData");
                                  } catch (e) {
                                    //print(e);
                                  }

                                  return InkWell(
                                    onTap: () {
                                      try {
                                        goToProductListScreen();
                                      } catch (e) {
                                        //print(e);
                                      }
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 80,
                                          height: 80,
                                          margin: EdgeInsets.all(10),
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child: CircleAvatar(
                                            backgroundColor: Colors.grey[200],
                                            radius: 25,
                                            child: CachedNetworkImage(
                                              imageUrl: imageData,
                                              width: 50,
                                              height: 50,
                                              placeholder: (context, url) =>
                                                  middleWare
                                                      .setJumpingDotsProgressIndicator(
                                                          Colors.green, 35.00),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Container(
                                                width: 50,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    border: Border.all(
                                                        color: Colors.grey
                                                            .withOpacity(0.4))),
                                                child: Icon(
                                                  Icons.image,
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
                                                  size: 50,
                                                ),
                                              ),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            middleWare.validString(
                                                leftCategoryModel
                                                    .lookupDescription),
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 14.00,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.all(5.0),
                              child: Center(
                                child: Text(
                                  noCategoryListData,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14.0,
                                      color: Colors.grey),
                                ),
                              )),
                      controller.productList != null &&
                              controller.productList.length > 0
                          ? Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Best Sellers',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                        color: Colors.black),
                                  ),
                                  Visibility(
                                    visible: false,
                                    child: GestureDetector(
                                      onTap: () {
                                        goToProductListScreen();
                                      },
                                      child: Text(
                                        'See all',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.0,
                                            color: Colors.green),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox.shrink(),
                      controller.productList != null &&
                              controller.productList.length > 0
                          ? Container(
                              width: double.infinity,
                              height: 250,
                              child: ListView.builder(
                                itemCount: controller.productList.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: ClampingScrollPhysics(),
                                padding: EdgeInsets.only(
                                  bottom: 10,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  ProductListModel productListModel =
                                  controller.productList[index];
                                  String imageProductData = "";
                                  int stockQty = 0;
                                  try {
                                    if (productListModel.count == null ||
                                        productListModel.count == 0) {
                                      productListModel.count = 0;
                                    }
                                    if (productListModel?.productImage
                                        .toString() !=
                                        null &&
                                        !middleWare
                                            .validString(productListModel
                                            ?.productImage
                                            .toString())
                                            .contains("undefined")) {
                                      imageProductData = middleWare.validString(
                                          baseImageURL +
                                              "${productListModel.productId.toString()??""}/${productListModel.productImage}");
                                    }

                                    stockQty = int.parse(productListModel
                                        .stockQty
                                        .toString());

                                    print("productList imageData $imageProductData");

                                  } catch (e) {
                                    //print(e);
                                  }

                                  return index<5?GestureDetector(
                                    onTap: (){
                                      goToProductListScreen();
                                    },
                                    child: Container(
                                      //color: Colors.white,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius
                                              .circular(16),
                                          border: Border.all(
                                              color: Colors.grey)),
                                      margin: EdgeInsets.only(
                                        top: middleWare.minimumPadding *
                                            2,
                                        left: middleWare.minimumPadding*2,
                                        right:
                                        middleWare.minimumPadding,
                                        bottom:
                                        middleWare.minimumPadding *
                                            2,
                                      ),
                                      child: Column(
                                        /*crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,*/
                                        children: [
                                          middleWare
                                              .putSizedBoxHeight(10.0),
                                          Center(
                                              child: CachedNetworkImage(
                                                imageUrl: imageProductData,
                                                width: 120,
                                                height: 120,
                                                placeholder: (context,
                                                    url) =>
                                                    middleWare.setJumpingDotsProgressIndicator(Colors.green, 35.00),
                                                errorWidget:
                                                    (context, url, error) =>
                                                    Container(
                                                      width: 120,
                                                      height: 120,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(4),
                                                          border: Border.all(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                  0.4))),
                                                      child: Icon(
                                                        Icons.image,
                                                        color: Colors.grey
                                                            .withOpacity(0.3),
                                                        size: 60,
                                                      ),
                                                    ),
                                                fit: BoxFit.fill,
                                              )),

                                          Container(
                                            padding: EdgeInsets.only(
                                                top: middleWare
                                                    .minimumPadding *
                                                    3,
                                                left: middleWare
                                                    .minimumPadding *
                                                    1.5,
                                                right: middleWare
                                                    .minimumPadding *
                                                    1.5),
                                            child: Opacity(
                                              opacity: 0.5,
                                              child: Text(
                                                middleWare.validString(
                                                    productListModel
                                                        ?.weight
                                                        .toString() ??
                                                        ""),
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                            ),
                                          ),

                                          Container(
                                            padding: EdgeInsets.only(
                                                top: middleWare
                                                    .minimumPadding *
                                                    2,
                                                left: middleWare
                                                    .minimumPadding *
                                                    2,
                                                right: middleWare
                                                    .minimumPadding *
                                                    2),
                                            child: Text(
                                              middleWare.validString(
                                                  productListModel
                                                      ?.productName ??
                                                      ""),
                                              maxLines: 2,
                                              overflow:
                                              TextOverflow.ellipsis,
                                              textAlign:
                                              TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                  color: Colors.black),
                                            ),
                                          ),

                                          middleWare
                                              .putSizedBoxHeight(10.00),
                                        ],
                                      ),
                                    ),
                                  ):SizedBox.shrink();
                                },
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.all(5.0),
                              child: Center(
                                child: Text(
                                  noProductListData,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14.0,
                                      color: Colors.grey),
                                ),
                              )),
                    ],
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              )),
      ),
    );
  }

  onBackPressed(int flag) {
    return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(
                  'Do you want to ${flag == 0 ? "exit" : "logout"} for now?'),
              actions: <Widget>[
                FlatButton(
                  child: Text('CANCEL'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    try {
                      if (flag == 0) {
                        if (Platform.isAndroid) {
                          SystemNavigator.pop();
                        } else if (Platform.isIOS) {
                          exit(0);
                        }
                      } else {
                        PreferenceUtil.clearAllData().then((value) {
                          Get.offAll(LoginView());
                        });
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                )
              ],
            );
          },
        ) ??
        false;
  }

  onSearchTextChanged(LeftCategoryModel leftCategoryModel) async {
    try {
      filterProductList.clear();

      controller.selCategoryId.value = leftCategoryModel.lookupId;
      controller.appBarTitle.value = leftCategoryModel?.lookupDescription ?? "";

      controller.productList.forEach((item) {
        ProductListModel productListModel = item;
        int strProductType = productListModel?.productType ?? 0.toInt();
        int lookUpId = leftCategoryModel?.lookupId ?? 0;
        if (strProductType == lookUpId) {
          filterProductList.add(productListModel);
        }
      });

      filterProductList = filterProductList.toSet().toList();

      print("filterProductList count ${filterProductList.length}");

      setState(() {});
    } catch (e) {
      print(e);
    }
  }
}
