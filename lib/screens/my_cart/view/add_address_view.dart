import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getxpoc/core/constants/variable_const.dart';
import 'package:getxpoc/core/middleware.dart';
import 'package:get/get.dart';
import 'package:getxpoc/screens/my_cart/model/address_list_model.dart';
import 'package:getxpoc/screens/product_list/controller/product_list_controller.dart';


class AddAddressView extends StatefulWidget {

  @override
  AddAddressViewScreenState createState() => AddAddressViewScreenState();

}

class AddAddressViewScreenState extends State<AddAddressView> {


  final controller = Get.put(ProductListController());

  var userNameTextController = TextEditingController();
  var addressTextController = TextEditingController();
  var landMarkTextController = TextEditingController();
  var cityTextController = TextEditingController();
  var pincodeTextController = TextEditingController();
  var mobNoTextController = TextEditingController();
  var globalKey = GlobalKey<FormState>();
  MiddleWare middleWare = MiddleWare();


  @override
  void initState() {
    try {
      super.initState();
      onInit();
    } catch (e) {
      //print(e);
    }
  }

  void onInit() {
    try {
      if (!controller.isAddAddress.isTrue) {
        userNameTextController.text = middleWare
            .validString(controller.addressListModel?.addressName ?? "");
        addressTextController.text = middleWare
            .validString(controller.addressListModel?.memberAddress ?? "");
        landMarkTextController.text =
            middleWare.validString(controller.addressListModel?.landmark ?? "");
        cityTextController.text =
            middleWare.validString(controller.addressListModel?.locality ?? "");
        pincodeTextController.text =
            middleWare.validString(controller.addressListModel?.zipCode ?? "");
        mobNoTextController.text =
            middleWare.validString(controller.addressListModel?.mobileNo ?? "");
        String strName = middleWare
            .validString(controller.addressListModel?.addressType.toString());
        if (strName.contains("2175")) {
          controller.selAddressType.value = 0;
        } else if (strName.contains("2176")) {
          controller.selAddressType.value = 1;
        } else {
          controller.selAddressType.value = 2;
        }
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
          '${controller.isAddAddress.isTrue?"New":"Edit"} Address',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                addressForm(),
                SizedBox(height: 15.0),
              ],
            ),
          ),
        ),
      ),
    );
  }


  addressForm() {
    return Form(
      key: globalKey,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 35.0, right: 35.0, top: 5.0, bottom: 10.0),
          child: ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              SizedBox(height: 15.0),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: userNameTextController,
                decoration: middleWare.boxTextFieldDecoration(
                    'Name'),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return "Please enter name";
                  } /*else if (!middleWare.emailRegEx.hasMatch(value.trim()) &&
                      !middleWare.mobileRegEx.hasMatch(value.trim())) {
                    return "Please enter valid email / mobile no";
                  }*/
                  return null;
                },
              ),
              SizedBox(
                height: 30.0,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: addressTextController,
                maxLines: 4,
                decoration: middleWare.boxTextFieldDecoration(
                    'Address'),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return "Please enter address";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 30.0,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: landMarkTextController,
                decoration: middleWare.boxTextFieldDecoration(
                    'Landmark'),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return "Please enter landmark";
                  } /*else if (!middleWare.emailRegEx.hasMatch(value.trim()) &&
                      !middleWare.mobileRegEx.hasMatch(value.trim())) {
                    return "Please enter valid email / mobile no";
                  }*/
                  return null;
                },
              ),
              SizedBox(
                height: 30.0,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: cityTextController,
                decoration: middleWare.boxTextFieldDecoration(
                    'City'),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return "Please enter city";
                  } /*else if (!middleWare.emailRegEx.hasMatch(value.trim()) &&
                      !middleWare.mobileRegEx.hasMatch(value.trim())) {
                    return "Please enter valid email / mobile no";
                  }*/
                  return null;
                },
              ),
              SizedBox(
                height: 30.0,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: pincodeTextController,
                maxLength: 6,
                decoration: middleWare.boxTextFieldDecoration(
                  'PinCode'),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return "Please enter pincode";
                  }else if (value.trim().length < 6) {
                    return strPinCodeCheck;
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 30.0,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: mobNoTextController,
                maxLength: 10,
                decoration: middleWare.boxTextFieldDecoration(
                    'Mobile No'),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return "Please enter mobile no";
                  } else if (
                      !middleWare.mobileRegEx.hasMatch(value.trim())) {
                    return "Please enter valid mobile no";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 30.0,
              ),

              Container(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        try {
                          setState(() {
                            controller.selAddressType.value = 0;
                          });
                        } catch (e) {
                          //print(e);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: controller.selAddressType.value==0?Colors.green:Colors.grey,
                              border: Border.all(
                                color: controller.selAddressType.value==0?Colors.green:Colors.grey,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: Text(
                            strHome,
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                          ),),
                    ),
                    middleWare.putSizedBoxWidth(15.0),
                    GestureDetector(
                      onTap: (){
                        try {
                          setState(() {
                            controller.selAddressType.value = 1;
                          });
                        } catch (e) {
                          //print(e);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: controller.selAddressType.value==1?Colors.green:Colors.grey,
                              border: Border.all(
                                color: controller.selAddressType.value==1?Colors.green:Colors.grey,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: Text(
                            strOffice,
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                          ),),
                    ),
                    middleWare.putSizedBoxWidth(15.0),
                    GestureDetector(
                      onTap: (){
                        try {
                          setState(() {
                            controller.selAddressType.value = 2;
                          });
                        } catch (e) {
                          //print(e);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: controller.selAddressType.value==2?Colors.green:Colors.grey,
                              border: Border.all(
                                color: controller.selAddressType.value==2?Colors.green:Colors.grey,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: Text(
                            strOthers,
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                          ),),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 30.0,
              ),

              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    !controller.loadingData.isTrue
                        ? InkWell(
                            onTap: () {
                              try {
                                if (globalKey.currentState.validate()) {
                                  middleWare.check().then((intenet) async {
                                    if (intenet != null && intenet) {

                                      AddressListModel addressListModel =
                                          AddressListModel(
                                              addressId:controller.isAddAddress.isTrue?0:controller.addressListModel?.addressId??"",
                                              linkId:controller.loginModel?.userId??"",
                                              addressType:controller.selAddressType.value==0?"2175":controller.selAddressType.value==1?"2176":"0",
                                              addressName:middleWare.validString(userNameTextController.text.toString()),
                                              mobileNo:middleWare.validString(mobNoTextController.text.toString()),
                                              zipCode:middleWare.validString(pincodeTextController.text.toString()),
                                              locality:middleWare.validString(cityTextController.text.toString()),
                                              memberAddress:middleWare.validString(addressTextController.text.toString()),
                                              state:"Andhra Pradesh",
                                              country:"India",
                                              landmark:middleWare.validString(landMarkTextController.text.toString()),
                                              alternateNo:"",
                                              isActive:true,
                                              createdOn:"",
                                              modifiedOn:"", imageFile:"");

                                      controller.addressListModel = addressListModel;

                                      var result =
                                          await controller.callAddAddress();
                                      if (result) {
                                        controller.getAddressList();
                                        middleWare.showToastMsg(
                                            "${controller.isAddAddress.isTrue ? "New address added successfully!!!" : "Address edited successfully!!!"}",
                                            14.00,
                                            Colors.green,
                                            Colors.white,
                                            Toast.LENGTH_SHORT);
                                        Get.back();
                                      } else {
                                        middleWare.showToastMsg(
                                            "${controller.isAddAddress.isTrue ? "New address added failed" : "Address edited failed"}",
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
                                }
                              } catch (e) {
                                //print(e);
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 15),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.grey.shade200,
                                        offset: Offset(2, 4),
                                        blurRadius: 5,
                                        spreadRadius: 2)
                                  ],
                                  gradient: LinearGradient(
                                      end: Alignment.centerRight,
                                      colors: [Colors.green, Colors.green])),
                              child: Text(
                                strSave,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          )
                        : CircularProgressIndicator(),
                  ],
                ),
              ),

              SizedBox(
                height: 20.0,
              ),



            ],
          ),
        ),
      ),
    );
  }


}
