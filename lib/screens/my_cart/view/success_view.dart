import 'package:flutter/material.dart';
import 'package:getxpoc/core/constants/variable_const.dart';
import 'package:getxpoc/core/middleware.dart';
import 'package:get/get.dart';
import 'package:getxpoc/screens/product_list/controller/product_list_controller.dart';
import 'package:getxpoc/screens/product_list/view/home_view.dart';
import 'package:getxpoc/screens/product_list/view/product_list_view.dart';

class SuccessView extends StatefulWidget {

  @override
  SuccessViewState createState() => SuccessViewState();

}

class SuccessViewState extends State<SuccessView> {

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
      body: Container(
        color: Colors.white,
        height: double.infinity,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle_outline_outlined,
                  size: 100.0,
                  color: Colors.green,
                ),
                middleWare.putSizedBoxHeight(20.00),
                Text(
                  orderSuccessMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      color: Colors.black),
                ),
                middleWare.putSizedBoxHeight(30.00),
                Text(
                  thanksMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.grey),
                ),
                middleWare.putSizedBoxHeight(40.00),

                GestureDetector(
                  onTap: (){
                    try {
                      controller.strTotCount.value = 0;
                      controller.strTotAmount.value = 0.0;
                      controller.getLeftCategory();
                      Get.offAll(HomeView());
                    } catch (e) {
                      //print(e);
                    }
                  },
                  child: Card(
                    margin: EdgeInsets.only(left: 40.0,right: 40.00),
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 15.0,
                          bottom: 15.00,
                          left: middleWare.minimumPadding * 3,
                          right: middleWare.minimumPadding * 3),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Text(
                            'Continue',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20.0,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }

}
