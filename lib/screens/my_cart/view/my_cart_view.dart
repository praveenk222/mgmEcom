import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getxpoc/core/constants/api_url_const.dart';
import 'package:getxpoc/core/constants/variable_const.dart';
import 'package:getxpoc/core/middleware.dart';
import 'package:get/get.dart';
import 'package:getxpoc/screens/product_list/controller/product_list_controller.dart';
import 'package:getxpoc/screens/product_list/model/product_list_model.dart';

import 'address_view.dart';

class MyCartView extends StatefulWidget {
  @override
  MyCartScreenState createState() => MyCartScreenState();
}

class MyCartScreenState extends State<MyCartView> {
  MiddleWare middleWare = MiddleWare();
  final controller = Get.put(ProductListController());

  @override
  void initState() {
    try {
      super.initState();
    } catch (e) {
      //print(e);
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
      if (controller.strTotCount.value == 0) {
        Get.back();
      }
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
            Get.back();
          },
        ),
        title: Text(
          'My Cart',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Container(
        width: double.infinity,
        color: Colors.white,
        //padding: EdgeInsets.all(20),
        child: Obx(() => !controller.loadingData.isTrue
            ? controller.productList.value != null &&
                    controller.productList.value.length > 0
                ? Stack(
                    children: [
                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  controller.strTotCount.value > 0 ? 70 : 0),
                          child: SingleChildScrollView(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child:
                                      controller.productList.value != null &&
                                              controller
                                                      .productList.value.length >
                                                  0
                                          ? ListView.builder(
                                              shrinkWrap: true,
                                              physics: ClampingScrollPhysics(),
                                              padding: EdgeInsets.only(
                                                bottom: 10,
                                              ),
                                              itemCount: controller.productList
                                                      ?.value?.length ??
                                                  0,
                                              itemBuilder: (context, index) {
                                                ProductListModel
                                                    productListModel = controller
                                                        .productList.value[index];
                                                String imageData = "";
                                                int stockQty = 0;
                                                try {
                                                  if (productListModel.count ==
                                                          null ||
                                                      productListModel.count ==
                                                          0) {
                                                    productListModel.count = 0;
                                                  }
                                                  if (productListModel
                                                              ?.productImage
                                                              .toString() !=
                                                          null &&
                                                      !middleWare
                                                          .validString(
                                                              productListModel
                                                                  ?.productImage
                                                                  .toString())
                                                          .contains(
                                                              "undefined")) {
                                                    imageData = middleWare
                                                        .validString(baseImageURL +
                                                            "${productListModel.productId.toString()??""}/${productListModel.productImage}");
                                                  }

                                                  stockQty = int.parse(
                                                      productListModel.stockQty
                                                          .toString());
                                                } catch (e) {
                                                  //print(e);
                                                }
                                                return productListModel.count > 0
                                                    ? Card(
                                                        color: Colors.white,
                                                        elevation: 5.0,
                                                        margin: EdgeInsets.only(
                                                          top: middleWare
                                                                  .minimumPadding *
                                                              2,
                                                          left: middleWare
                                                              .minimumPadding,
                                                          right: middleWare
                                                              .minimumPadding,
                                                          bottom: middleWare
                                                                  .minimumPadding *
                                                              2,
                                                        ),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15.0),
                                                        ),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            middleWare
                                                                .putSizedBoxWidth(
                                                                    5.0),
                                                            Container(
                                                              margin:
                                                                  EdgeInsets.only(
                                                                top: middleWare
                                                                        .minimumPadding *
                                                                    2,
                                                                left: middleWare
                                                                    .minimumPadding,
                                                                right: middleWare
                                                                    .minimumPadding,
                                                                bottom: middleWare
                                                                        .minimumPadding *
                                                                    2,
                                                              ),
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl:
                                                                    imageData,
                                                                width: 90,
                                                                height: 90,
                                                                placeholder: (context,
                                                                        url) =>
                                                                    middleWare.setJumpingDotsProgressIndicator(Colors.green, 35.00),
                                                                errorWidget:
                                                                    (context, url,
                                                                            error) =>
                                                                        Container(
                                                                  width: 100,
                                                                  height: 100,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              4),
                                                                      border: Border.all(
                                                                          color: Colors
                                                                              .grey
                                                                              .withOpacity(0.4))),
                                                                  child: Icon(
                                                                    Icons.image,
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.3),
                                                                    size: 60,
                                                                  ),
                                                                ),
                                                                fit: BoxFit.fill,
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    padding: EdgeInsets.only(
                                                                        top: middleWare
                                                                                .minimumPadding *
                                                                            2,
                                                                        left:
                                                                            middleWare.minimumPadding *
                                                                                2,
                                                                        right:
                                                                            middleWare.minimumPadding *
                                                                                2),
                                                                    child: Text(
                                                                      middleWare.validString(
                                                                          productListModel?.productName ??
                                                                              ""),
                                                                      maxLines: 2,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .w500,
                                                                          color: Colors
                                                                              .black),
                                                                    ),
                                                                  ),
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
                                                                    child:
                                                                        Opacity(
                                                                      opacity:
                                                                          0.5,
                                                                      child: Text(
                                                                        middleWare.validString(
                                                                            productListModel?.weight.toString() ??
                                                                                ""),
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontSize:
                                                                              14.0,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    padding: EdgeInsets.only(
                                                                        top: middleWare
                                                                                .minimumPadding *
                                                                            3,
                                                                        bottom:
                                                                            middleWare.minimumPadding *
                                                                                2,
                                                                        left: middleWare
                                                                                .minimumPadding *
                                                                            1.5,
                                                                        right:
                                                                            middleWare.minimumPadding *
                                                                                2),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
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
                                                                        stockQty ==
                                                                                0
                                                                            ? SizedBox
                                                                                .shrink()
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
                                                                                        margin: EdgeInsets.all(middleWare.minimumPadding),
                                                                                        decoration: BoxDecoration(color: Colors.white12.withOpacity(0.45), borderRadius: BorderRadius.all(Radius.circular(13))),
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
                                                                                      decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.all(Radius.circular(13))),
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
                                                                                              size: 16.0,
                                                                                              color: Colors.white,
                                                                                            ),
                                                                                          ),
                                                                                          middleWare.putSizedBoxWidth(3.0),
                                                                                          Text(
                                                                                            middleWare.validString(productListModel.count.toString()),
                                                                                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0, color: Colors.white),
                                                                                          ),
                                                                                          middleWare.putSizedBoxWidth(3.0),
                                                                                          GestureDetector(
                                                                                            onTap: () {
                                                                                              try {
                                                                                                if (stockQty == productListModel.count) {
                                                                                                  middleWare.showToastMsg("allowed  $stockQty items only", 14.00, Colors.red, Colors.white, Toast.LENGTH_SHORT);
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
                                                                                              size: 16.0,
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
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          controller.getAddressList();
                                          Get.to(() => AddressView());
                                        } catch (e) {
                                          //print(e);
                                        }
                                      },
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Proceed',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14.0,
                                                  color: Colors.white),
                                            ),
                                            middleWare.putSizedBoxWidth(5.0),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              size: 16.0,
                                              color: Colors.white,
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
                  )
                : Container(
                    child: Center(
                    child: Text(noProductListData),
                  ))
            : Center(
                child: CircularProgressIndicator(),
              )),
      ),
    );
  }

  Widget getMyCartWidget(String imagePath, String strTitle) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            radius: 25,
            child: Image(
              image: AssetImage(imagePath),
              width: 45,
              height: 45,
              //fit: BoxFit.fill,
            ),
          ),
          Text(
            strTitle,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 14.00,
                fontWeight: FontWeight.normal,
                color: Colors.black),
          ),
        ],
      ),
    );
  }
}
