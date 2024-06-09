import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getxpoc/core/constants/variable_const.dart';
import 'package:getxpoc/core/middleware.dart';
import 'package:get/get.dart';
import 'package:getxpoc/screens/authendication_pages/controller/authendication_controller.dart';
import 'package:getxpoc/screens/authendication_pages/view/register_view.dart';

import 'login_view.dart';

class OTPView extends StatefulWidget {

  @override
  OTPViewScreenState createState() => OTPViewScreenState();

}

class OTPViewScreenState extends State<OTPView> {


  final controller = Get.put(AuthendicationController());

  var otpTextController = TextEditingController();
  var globalKey = GlobalKey<FormState>();
  MiddleWare middleWare = MiddleWare();
  

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          color: Colors.white,
          height: double.infinity,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  otpForm(),
                  SizedBox(height: 15.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  otpForm() {
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
              Padding(
                  padding: EdgeInsets.all(20),
                  child: Image.asset(
                    middleWare.strMainAppLogo,
                    height: 100,
                    width: 100,
                    fit: BoxFit.fill,
                  )),
              SizedBox(height: 15.0),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: otpTextController,
                decoration: middleWare.boxTextFieldDecoration(
                    'Enter OTP'),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return "Please enter OTP";
                  } else if (value.trim()!=controller.strOTP.value) {
                    return "Please enter valid otp";
                  }
                  return null;
                },
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
                                      if (otpTextController.text.trim() ==
                                          controller.strOTP.value) {
                                        middleWare.showToastMsg(
                                            "User added successfully",
                                            14.00,
                                            Colors.green,
                                            Colors.white,
                                            Toast.LENGTH_SHORT);
                                        Get.offAll(LoginView());
                                      } else {
                                        middleWare.showToastMsg(
                                            "please enter valid OTP",
                                            14.00,
                                            Colors.green,
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
                                print(e);
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
                                strVerify,
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
