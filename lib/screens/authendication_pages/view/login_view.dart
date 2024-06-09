import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getxpoc/core/constants/preference_util.dart';
import 'package:getxpoc/core/constants/variable_const.dart';
import 'package:getxpoc/core/middleware.dart';
import 'package:get/get.dart';
import 'package:getxpoc/screens/authendication_pages/controller/authendication_controller.dart';
import 'package:getxpoc/screens/authendication_pages/view/register_view.dart';
import 'package:getxpoc/screens/product_list/controller/product_list_controller.dart';
import 'package:getxpoc/screens/product_list/view/home_view.dart';
import 'package:getxpoc/screens/product_list/view/product_list_view.dart';

class LoginView extends StatefulWidget {

  @override
  LoginViewScreenState createState() => LoginViewScreenState();

}

class LoginViewScreenState extends State<LoginView> {


  final controller = Get.put(AuthendicationController());

  var userNameTextController = TextEditingController();
  var passwordTextController = TextEditingController();
  var globalKey = GlobalKey<FormState>();
  MiddleWare middleWare = MiddleWare();

  bool passwordVisible = false;

  @override
  void initState() {
    try {
      super.initState();
      userNameTextController.text = controller.strEmailId?.value??"";
      PreferenceUtil.init();
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
                  loginForm(),
                  SizedBox(height: 15.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  loginForm() {
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
                    'Enter Email / Mobile No'),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return "Please enter email / mobile no";
                  } else if (!middleWare.emailRegEx.hasMatch(value.trim()) &&
                      !middleWare.mobileRegEx.hasMatch(value.trim())) {
                    return "Please enter valid email / mobile no";
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
                                      var result = await controller.callLogin(
                                          userNameTextController.text.trim(),
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
                                          await PreferenceUtil.saveUserData(
                                                  strUserDetails,
                                                  controller.loginModel)
                                              .then((value) {
                                            final productListController = Get.put(ProductListController());
                                            productListController.loginModel = controller.loginModel;
                                            productListController.getLeftCategory();
                                            Get.offAll(HomeView());
                                            middleWare.showToastMsg(
                                                "Sign In success",
                                                14.00,
                                                Colors.green,
                                                Colors.white,
                                                Toast.LENGTH_SHORT);
                                          });
                                        }
                                      } else {
                                        middleWare.showToastMsg(
                                            "Sign In failed",
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
                                strSignInText,
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

              gotoRegisterPage(),


            ],
          ),
        ),
      ),
    );
  }

  Widget gotoRegisterPage() {
    return Container(
      padding: EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            strNeedAcoount,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              try {
                Get.to(() => RegisterView());
              } catch (e) {
                //print(e);
              }
            },
            child: Text(
              strSignUpTxt,
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

}
