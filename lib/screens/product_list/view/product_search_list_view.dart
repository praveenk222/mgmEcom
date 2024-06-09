import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getxpoc/core/constants/api_url_const.dart';
import 'package:getxpoc/core/constants/variable_const.dart';
import 'package:getxpoc/core/middleware.dart';
import 'package:get/get.dart';
import 'package:getxpoc/screens/my_cart/view/my_cart_view.dart';
import 'package:getxpoc/screens/product_list/controller/product_list_controller.dart';
import 'package:getxpoc/screens/product_list/model/leftcategory_model.dart';
import 'package:getxpoc/screens/product_list/model/product_list_model.dart';

class ProductSearchListView extends StatefulWidget {
  @override
  ProductSearchListViewState createState() => ProductSearchListViewState();
}

class ProductSearchListViewState extends State<ProductSearchListView> {
  MiddleWare middleWare = MiddleWare();
  final controller = Get.put(ProductListController());
  TextEditingController searchController = TextEditingController();
  String searchText = "";
  List<ProductListModel> filterProductList = [];

  @override
  void initState() {
    try {
      super.initState();
      onInit();
    } catch (e) {
      //print(e);
    }
  }

  @override
  void dispose() {
    try {
      searchController.dispose();
      super.dispose();
    } catch (e) {
      print(e);
    }
  }

  void initCalculation() {
    try {
      controller.strTotCount.value = 0;
      controller.strTotAmount.value = 0.0;
      controller.productList.forEach((item) {
        if (item.count > 0) {
          controller.strTotCount.value += item.count;
          double value =
              double.parse(item.standardPrice.toString()) * item.count;
          controller.strTotAmount.value += value;
        }
      });
    } catch (e) {
      //print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        titleSpacing: 0,
        /*leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 24.0,
            color: Colors.white,
          ),
          onPressed: () {
            try {
              searchController.clear();
              onSearchTextChanged('');
              Get.back();
            } catch (e) {
              //print(e);
            }
          },
        ),*/
        title: Container(
          padding: EdgeInsets.all(middleWare.minimumPadding),
          child: ListTile(
            leading: Icon(
              Icons.search,
              size: 26,
              color: Colors.white,
            ),
            title: TextFormField(
                cursorColor: Colors.white,
              style: TextStyle(
                  fontSize: 15.00,
                  color: Colors.white,
                  fontWeight: FontWeight.normal),
              controller: searchController,
              decoration: InputDecoration(
                  hintText: "Search products...",
                  hintStyle: TextStyle(
                      fontSize: 15.00,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                  labelStyle: TextStyle(
                      fontSize: 15.00,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                  border: InputBorder.none),
              onChanged: onSearchTextChanged,
            ),
            trailing:
                middleWare.validString(searchController.text).trim().isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          searchController.clear();
                          onSearchTextChanged('');
                        },
                      )
                    : Text(""),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        color: Colors.white,
        //padding: EdgeInsets.all(20),
        child: Obx(() => !controller.loadingData.isTrue
    ? Stack(
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: controller.strTotCount.value > 0 ? 70 : 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: filterProductList != null &&
                          filterProductList.length > 0
                          ? GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 0.64,
                              ),
                              padding: EdgeInsets.only(
                                bottom: 10,
                              ),
                              itemCount: filterProductList?.length ?? 0,
                              itemBuilder: (context, index) {
                                ProductListModel productListModel =
                                filterProductList[index];
                                String imageData = "";
                                String strName = "";
                                int stockQty = 0;
                                try {
                                  strName = middleWare.validString(
                                      productListModel?.productName ?? "");
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
                                    imageData = middleWare.validString(
                                        baseImageURL +
                                            "${productListModel.productId.toString()??""}/${productListModel.productImage}");
                                  }

                                  stockQty = int.parse(
                                      productListModel.stockQty.toString());
                                } catch (e) {
                                  //print(e);
                                }
                                return searchText.trim().isEmpty
                                    ? getWidget(
                                        imageData, stockQty, productListModel)
                                    : strName
                                            .toLowerCase()
                                            .contains(searchText.toLowerCase())
                                        ? getWidget(imageData, stockQty,
                                            productListModel)
                                        : SizedBox.shrink();
                              },
                            )
                          : Container(
                              child: Center(
                              child: Text(noProductListData),
                            )),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: controller.strTotCount.value > 0 ? 70 : 0,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Card(
                    margin: EdgeInsets.all(10.0),
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 10.0,
                          bottom: 10.00,
                          left: middleWare.minimumPadding * 3,
                          right: middleWare.minimumPadding * 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                controller.strTotCount.value > 0
                                    ? "${controller.strTotCount.value} ${controller.strTotCount.value > 1 ? "Items | " : "Item | "}"
                                    : "",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.0,
                                    color: Colors.white),
                              ),
                              Text(
                                controller.strTotAmount.value > 0.00
                                    ? "\u20B9${controller.strTotAmount.value}"
                                    : "",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.0,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              try {
                                Get.to(() => MyCartView());
                              } catch (e) {
                                //print(e);
                              }
                            },
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.shopping_bag,
                                    size: 16.0,
                                    color: Colors.white,
                                  ),
                                  middleWare.putSizedBoxWidth(3.0),
                                  Text(
                                    'View Cart',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.0,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ):Center(
          child: CircularProgressIndicator(),
        )),
      ),
    );
  }

  getWidget(String imageData, int stockQty, ProductListModel productListModel) {
    return Card(
      color: Colors.white,
      elevation: 5.0,
      margin: EdgeInsets.only(
        top: middleWare.minimumPadding * 2,
        left: middleWare.minimumPadding,
        right: middleWare.minimumPadding,
        bottom: middleWare.minimumPadding * 2,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          middleWare.putSizedBoxHeight(5.0),
          Center(
              child: CachedNetworkImage(
            imageUrl: imageData,
            width: 100,
            height: 100,
            placeholder: (context, url) => middleWare.setJumpingDotsProgressIndicator(Colors.green, 35.00),
            errorWidget: (context, url, error) => Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.grey.withOpacity(0.4))),
              child: Icon(
                Icons.image,
                color: Colors.grey.withOpacity(0.3),
                size: 60,
              ),
            ),
            fit: BoxFit.fill,
          )),
          Container(
            padding: EdgeInsets.only(
                top: middleWare.minimumPadding * 2,
                left: middleWare.minimumPadding * 2,
                right: middleWare.minimumPadding * 2),
            child: Text(
              middleWare.validString(productListModel?.productName ?? ""),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                top: middleWare.minimumPadding * 3,
                left: middleWare.minimumPadding * 1.5,
                right: middleWare.minimumPadding * 1.5),
            child: Opacity(
              opacity: 0.5,
              child: Text(
                middleWare
                    .validString(productListModel?.weight.toString() ?? ""),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                top: middleWare.minimumPadding * 3,
                left: middleWare.minimumPadding * 1.5,
                right: middleWare.minimumPadding * 1.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /*Opacity(
                                                        opacity: 0.5,
                                                        child: Text(
                                                          '\u20B9${middleWare.validString(
                                                              productListModel?.standardPrice.toString()??"")}',
                                                          style: TextStyle(
                                                            decoration: TextDecoration
                                                                .lineThrough,
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 14.0,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 2),*/
                    Text(
                      '\u20B9${middleWare.validString(productListModel?.standardPrice.toString() ?? "")}',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
                          color: Colors.black),
                    ),
                  ],
                ),
                stockQty == 0
                    ? SizedBox.shrink()
                    : productListModel.count == 0
                        ? GestureDetector(
                            onTap: () {
                              try {
                                setState(() {
                                  productListModel.count++;
                                  initCalculation();
                                });
                              } catch (e) {
                                //print(e);
                              }
                            },
                            child: Card(
                              elevation: 5.0,
                              child: Container(
                                margin:
                                    EdgeInsets.all(middleWare.minimumPadding),
                                decoration: BoxDecoration(
                                    color: Colors.white12.withOpacity(0.45),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(13))),
                                child: Icon(
                                  Icons.add,
                                  size: 16.0,
                                  color: Colors.pinkAccent,
                                ),
                              ),
                            ),
                          )
                        : Card(
                            elevation: 5.0,
                            color: Colors.pink,
                            child: Container(
                              margin: EdgeInsets.all(middleWare.minimumPadding),
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(13))),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      try {
                                        setState(() {
                                          productListModel.count--;
                                          initCalculation();
                                        });
                                      } catch (e) {
                                        //print(e);
                                      }
                                    },
                                    child: Icon(
                                      Icons.remove,
                                      size: 12.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  middleWare.putSizedBoxWidth(3.0),
                                  Text(
                                    middleWare.validString(
                                        productListModel.count.toString()),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.0,
                                        color: Colors.white),
                                  ),
                                  middleWare.putSizedBoxWidth(3.0),
                                  GestureDetector(
                                    onTap: () {
                                      try {
                                        if (stockQty ==
                                            productListModel.count) {
                                          middleWare.showToastMsg(
                                              "allowed  $stockQty items only",
                                              14.00,
                                              Colors.red,
                                              Colors.white,
                                              Toast.LENGTH_SHORT);
                                          return;
                                        }
                                        setState(() {
                                          productListModel.count++;
                                          initCalculation();
                                        });
                                      } catch (e) {
                                        //print(e);
                                      }
                                    },
                                    child: Icon(
                                      Icons.add,
                                      size: 12.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
              ],
            ),
          ),
          middleWare.putSizedBoxHeight(20.00),
        ],
      ),
    );
  }

  onSearchTextChanged(String text) async {
    try {
      filterProductList.clear();

      if (text.trim().isEmpty) {
        onInit();
        setState(() {});
        return;
      }

      controller.productList.forEach((item) {
        ProductListModel productListModel = item;
        String strName = middleWare.validString(productListModel?.productName);
        if (strName.contains(text.toLowerCase())) {
          filterProductList.add(productListModel);
        }
      });

      filterProductList = filterProductList.toSet().toList();

      print("filterProductList count ${filterProductList.length}");

      setState(() {});
    } catch (e) {
      //print(e);
    }
  }

  onInit() async {
    try {
      //initCalculation();
      filterProductList.clear();
      controller.productList.forEach((item) {
        ProductListModel productListModel = item;
        filterProductList.add(productListModel);
      });
      filterProductList = filterProductList.toSet().toList();

      print("filterProductList count ${filterProductList.length}");
    } catch (e) {
      //print(e);
    }
  }
}
