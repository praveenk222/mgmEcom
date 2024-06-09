import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getxpoc/core/constants/preference_util.dart';
import 'package:getxpoc/core/constants/variable_const.dart';
import 'package:getxpoc/core/middleware.dart';
import 'package:get/get.dart';
import 'package:getxpoc/screens/authendication_pages/controller/authendication_controller.dart';
import 'package:getxpoc/screens/authendication_pages/model/login_model.dart';

import 'login_view.dart';
import 'otp_view.dart';

class RegisterView extends StatefulWidget {

  @override
  RegisterViewScreenState createState() => RegisterViewScreenState();

}

class RegisterViewScreenState extends State<RegisterView> {


  final controller = Get.put(AuthendicationController());

  var userNameTextController = TextEditingController();
  var passwordTextController = TextEditingController();
  var mobNoTextController = TextEditingController();
  var emailIdTextController = TextEditingController();
  var globalKey = GlobalKey<FormState>();
  MiddleWare middleWare = MiddleWare();

  bool passwordVisible = false;

  @override
  void initState() {
    try {
      super.initState();
      //onInit();
    } catch (e) {
      //print(e);
    }
  }

  /*void onInit() {
    try {
      LoginModel myProfile = PreferenceUtil.getUserData(strUserDetails);
      print("myProfile ${myProfile?.userName??""}");
    } catch (e) {
      //print(e);
    }
  }*/

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
                  registerForm(),
                  SizedBox(height: 15.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  registerForm() {
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
                controller: userNameTextController,
                decoration: middleWare.boxTextFieldDecoration(
                    'Enter User Name'),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return "Please enter userName";
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
                controller: emailIdTextController,
                decoration: middleWare.boxTextFieldDecoration(
                    'Enter EmailId'),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return "Please enter emailId";
                  } else if (!middleWare.emailRegEx.hasMatch(value.trim())) {
                    return "Please enter valid emailId";
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
                    'Enter Mobile No'),
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
              TextFormField(
                keyboardType: TextInputType.text,
                controller: passwordTextController,
                obscureText: !passwordVisible,
                decoration:
                middleWare.boxTextFieldDecoration('Password').copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                ),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return "Please enter your password";
                  }else if (value.trim().length < 6) {
                    return strPasswordCheck;
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
                                      var result = await controller.callRegister(
                                          userNameTextController.text.trim(),
                                          emailIdTextController.text.trim(),
                                          mobNoTextController.text.trim(),
                                          passwordTextController.text.trim());
                                      if (result) {
                                        if (controller.loginModel?.message !=
                                            null) {
                                          middleWare.showToastMsg(
                                              middleWare.validString(controller
                                                  .loginModel.message),
                                              14.00,
                                              Colors.green,
                                              Colors.white,
                                              Toast.LENGTH_SHORT);
                                        } else {
                                          controller.strEmailId.value = emailIdTextController.text.trim();
                                          controller.strOTP.value = middleWare.validString(controller
                                              .loginModel?.otp);
                                          middleWare.showToastMsg(
                                              "Sign Up success",
                                              14.00,
                                              Colors.green,
                                              Colors.white,
                                              Toast.LENGTH_SHORT);
                                          Get.to(() => OTPView());
                                          //Get.offAll(LoginView());
                                        }
                                      } else {
                                        middleWare.showToastMsg(
                                            "Sign Up failed",
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
                                strSignup,
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
