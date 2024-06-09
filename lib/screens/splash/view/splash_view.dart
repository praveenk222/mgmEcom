import 'package:flutter/material.dart';
import 'package:getxpoc/core/constants/preference_util.dart';
import 'package:getxpoc/core/constants/variable_const.dart';
import 'package:getxpoc/core/middleware.dart';
import 'package:get/get.dart';
import 'package:getxpoc/screens/authendication_pages/model/login_model.dart';
import 'package:getxpoc/screens/authendication_pages/view/login_view.dart';
import 'package:getxpoc/screens/product_list/controller/product_list_controller.dart';
import 'package:getxpoc/screens/product_list/view/home_view.dart';
import 'package:getxpoc/screens/product_list/view/product_list_view.dart';

class SplashView extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashView> {

  MiddleWare middleWare = MiddleWare();
  final controller = Get.put(ProductListController());

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
  dispose() {
    super.dispose();
  }

  onInit() async {
    try {
      PreferenceUtil.init();
      await 2.delay();
      /*imageCache.clear();
      imageCache.clearLiveImages();*/
      LoginModel myProfile = PreferenceUtil.getUserData(strUserDetails);
      String strUserName = middleWare.validString(myProfile?.userName ?? "");
      if (strUserName.trim().isNotEmpty) {
        controller.loginModel = myProfile;
        controller.getLeftCategory();
        Get.offAll(HomeView());
      } else {
        Get.offAll(LoginView());
      }
    } catch (e) {
      //print(e);
      Get.offAll(LoginView());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width:double.infinity,
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(middleWare.strMainAppLogo),
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
    );
  }

}
