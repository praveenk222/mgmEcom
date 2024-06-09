import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getxpoc/core/constants/variable_const.dart';
import 'package:getxpoc/core/middleware.dart';
import 'package:get/get.dart';
import 'package:getxpoc/screens/my_cart/model/address_list_model.dart';
import 'package:getxpoc/screens/my_cart/model/save_order_model.dart';
import 'package:getxpoc/screens/my_cart/view/success_view.dart';
import 'package:getxpoc/screens/product_list/controller/product_list_controller.dart';

import 'add_address_view.dart';

class AddressView extends StatefulWidget {
  @override
  CheckoutScreenState createState() => CheckoutScreenState();
}

class CheckoutScreenState extends State<AddressView> {
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
          'Checkout',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Container(
        width: double.infinity,
        color: Colors.white,
        //padding: EdgeInsets.all(20),
        child: Obx(() => !controller.addressLoadingData.isTrue
            ? Stack(
                children: [
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 70),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            middleWare.putSizedBoxHeight(15),
                            Container(
                              padding: EdgeInsets.only(
                                  top: middleWare.minimumPadding * 2,
                                  bottom: middleWare.minimumPadding * 2,
                                  left: middleWare.minimumPadding * 3.5,
                                  right: middleWare.minimumPadding * 3.5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Select Deliver Address",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.0,
                                        color: Colors.black),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      try {
                                        controller.isAddAddress.value = true;
                                        Get.to(() => AddAddressView());
                                      } catch (e) {
                                        //print(e);
                                      }
                                    },
                                    child: Text(
                                      "Add New",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          color: Colors.green),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            controller.addressList != null &&
                                    controller.addressList.length > 0
                                ? ListView.builder(
                                    itemCount: controller.addressList.length,
                                    shrinkWrap: true,
                                    physics: ClampingScrollPhysics(),
                                    padding: EdgeInsets.only(
                                      bottom: 10,
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      AddressListModel addressListModel =
                                          controller.addressList[index];
                                      String strName = middleWare.validString(
                                          addressListModel.addressType
                                              .toString());
                                      try {
                                        if (strName.contains("2175")) {
                                          strName = "Home Address";
                                        } else if (strName.contains("2176")) {
                                          strName = "Office Address";
                                        } else {
                                          strName = "Other Address";
                                        }
                                      } catch (e) {
                                        //print(e);
                                      }
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: RadioListTile(
                                                  title: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "$strName",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15.0,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      Text(
                                                        middleWare.validString(
                                                            addressListModel
                                                                .addressName),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15.0,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                  subtitle: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        middleWare.validString(
                                                            addressListModel
                                                                .memberAddress),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 15.0,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      Text(
                                                        "${middleWare.validString(addressListModel.locality)} ${middleWare.validString(addressListModel.zipCode)}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 15.0,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      Text(
                                                        "Mobile: ${middleWare.validString(addressListModel.mobileNo)}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15.0,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                  groupValue: controller
                                                      .selAddressId.value,
                                                  value: int.parse(
                                                      addressListModel.addressId
                                                          .toString()),
                                                  onChanged: (dynamic val) {
                                                    try {
                                                      setState(() {
                                                        controller.selAddressId
                                                            .value = val;
                                                        /*field.fieldValue =
                                                        field.radioBtnValues[val];*/
                                                      });
                                                    } catch (e) {
                                                      print(e);
                                                    }
                                                  },
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  try {
                                                    controller.isAddAddress
                                                        .value = false;
                                                    controller
                                                            .addressListModel =
                                                        addressListModel;
                                                    Get.to(
                                                        () => AddAddressView());
                                                  } catch (e) {
                                                    //print(e);
                                                  }
                                                },
                                                child: Icon(
                                                  Icons.edit,
                                                  //size: 16.0,
                                                  color: Colors.green,
                                                ),
                                              ),
                                              middleWare.putSizedBoxWidth(5.0),
                                              GestureDetector(
                                                onTap: () async {
                                                  middleWare
                                                      .check()
                                                      .then((intenet) async {
                                                    if (intenet != null &&
                                                        intenet) {
                                                      controller.delAddressId
                                                              .value =
                                                          addressListModel
                                                              .addressId
                                                              .toString();
                                                      var result = await controller
                                                          .callDeleteAddress();

                                                      if (result) {
                                                        controller
                                                            .getAddressList();
                                                        middleWare.showToastMsg(
                                                            "deleted successfully!!!",
                                                            14.00,
                                                            Colors.green,
                                                            Colors.white,
                                                            Toast.LENGTH_SHORT);
                                                        //Get.back();
                                                      } else {
                                                        middleWare.showToastMsg(
                                                            "deleted failed",
                                                            14.00,
                                                            Colors.red,
                                                            Colors.white,
                                                            Toast.LENGTH_SHORT);
                                                      }
                                                    } else {
                                                      middleWare.showToastMsg(
                                                          middleWare
                                                              .strOfflineMsg,
                                                          14.00,
                                                          Colors.red,
                                                          Colors.white,
                                                          Toast.LENGTH_SHORT);
                                                    }
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.delete,
                                                  //size: 16.0,
                                                  color: Colors.red,
                                                ),
                                              ),
                                              middleWare.putSizedBoxWidth(10.0),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  )
                                : Container(
                                    padding: EdgeInsets.all(15.0),
                                    child: Center(
                                      child: Text(
                                        noAddressListData,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            color: Colors.grey),
                                      ),
                                    )),
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
                        child: !controller.saveOrderLoadingData.isTrue
                            ? Card(
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
                                            controller.productList
                                                .forEach((item) {
                                              if (item.count > 0) {
                                                double value = double.parse(item
                                                        .standardPrice
                                                        .toString()) *
                                                    item.count;

                                                String sellingPrice = item
                                                    .standardPrice
                                                    .toString();

                                                SaveOrderModel saveOrderModel =
                                                    SaveOrderModel(
                                                        orderId: 0,
                                                        orderNo: "0",
                                                        orderDate: "",
                                                        memberId: controller
                                                                .loginModel
                                                                ?.userId ??
                                                            0,
                                                        orderStatus: 2180,
                                                        addressId:
                                                            controller.selAddressId
                                                                .value,
                                                        discountAmount: 0,
                                                        totalAmount:
                                                            value.toString(),
                                                        paidAmount:
                                                            value.toString(),
                                                        orderAmount:
                                                            value.toString(),
                                                        isCancel: false,
                                                        isDelivered: false,
                                                        remarks: "test",
                                                        createdOn: "",
                                                        modifiedOn: "",
                                                        cancelBy: 0,
                                                        deliveredOn: "",
                                                        closedOn: "",
                                                        canceledOn: "",
                                                        sellingPrice:
                                                            sellingPrice,
                                                        productId: int.parse(
                                                            item.productId
                                                                .toString()),
                                                        qunatity: item.count);

                                                controller.saveOrderList
                                                    .add(saveOrderModel);
                                              }
                                            });

                                            middleWare
                                                .check()
                                                .then((intenet) async {
                                              if (intenet != null && intenet) {
                                                var result = await controller
                                                    .callSaveOrderDetails();
                                                if (result) {
                                                  Get.to(() => SuccessView());
                                                } else {
                                                  middleWare.showToastMsg(
                                                      "order placed failed!!! please try after some time",
                                                      14.00,
                                                      Colors.red,
                                                      Colors.white,
                                                      Toast.LENGTH_SHORT);
                                                }
                                              } else {
                                                middleWare.showToastMsg(
                                                    middleWare.strOfflineMsg,
                                                    14.00,
                                                    Colors.red,
                                                    Colors.white,
                                                    Toast.LENGTH_SHORT);
                                              }
                                            });
                                          } catch (e) {
                                            print(e);
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
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              ),
                      ),
                    ),
                  ),
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              )),
      ),
    );
  }

  Widget getCheckoutWidget(String imagePath, String strTitle) {
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
