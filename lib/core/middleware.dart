import 'dart:core';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snack.dart';
import 'package:html/parser.dart';
import 'package:progress_indicators/progress_indicators.dart';

class MiddleWare {
  static final MiddleWare _middleWare = MiddleWare._internal();

  factory MiddleWare() {
    return _middleWare;
  }

  MiddleWare._internal();

  Color uiPacificBlueColor = Color(0xff1B8AD6);
  Color uiDarkCeruleanColor = Color(0xff0C5180);
  Color uiAliceBlueColor = Color(0xffF4F7FA);
  Color uiHawkesBlueColor = Color(0xffD8DAE0);
  Color uiNordicColor = Color(0xff002F34);
  Color uiRoyalBlueColor = Color(0xff2A65EA);
  Color uiTangerineYellowColor = Color(0xffFFCC00);
  Color uiFordGrayColor = Color(0xff979797);
  Color uiSailColor = Color(0xffA4D0EF);
  Color uiBlueColor = Color(0xff002257);
  Color uiTextFormFieldBgColor = Color(0xfff5f5f5);
  Color uiBgColor = Color(0xfff5f5f5);
  Color greenColor2 = Color(0xff21C58E);

  double minimumPadding = 5.0;

  bool isFirstToast = false;

  // ignore: non_constant_identifier_names
  static int CONNECT_TIMEOUT = 20;

  String strPleaseTryAgain = "Please try again...";

  String strOfflineMsg = "You are offline. Check your connection!!!";
  String strSorrySomethingWentWrong = "Sorry, something went wrong";
  String strLoadingPleaseWait = "Loading,Please Wait...";
  String strSignInText = 'Sign In';

  //Flutter Task
  String strAppLogo = "assets/images/ft_app_icon.JPG";

  String strMainAppLogo = "assets/images/app_logo.png";

  String strSplashImage = "assets/images/ft_splash_image.png";

  static const String APP_VERSION = '1.0.0';

  static const String RELEASE_DATE = '13th January 2021';

  static const String APP_NAME = 'GetxPOC';

  static const String PACKAGE_NAME = 'com.example.getxpoc';

  final emailRegEx = RegExp(
      "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$");

  final mobileRegEx = RegExp(r'(^(?:[+0]9)?[0-9]{10,11}$)');



  //parse html string
  String parseHtmlString(String htmlString) {
    try {
      var document = parse(htmlString);

      String parsedString = parse(document.body.text).documentElement.text;

      return parsedString;
    } catch (e) {
      print(e);
    }
    return "";
  }

  //check string format
  String validString(String strText) {
    try {
      if (strText == null)
        return "";
      else if (strText.trim().isEmpty)
        return "";
      else
        return strText.trim();
    } catch (e) {
      print(e);
    }
    return "";
  }

  //hideKeyBoard function
  void hideKeyBoard(BuildContext context) {
    try {
      FocusScope.of(context).unfocus();
    } catch (e) {
      print(e);
    }
  }

  //custom toast message visible to user
  void showToastMsg(String strMsg, double fontSize, Color bgColor,
      Color textColor, Toast toastLength) {
    try {
      if (isFirstToast) {
        Fluttertoast.cancel();
      }

      Fluttertoast.showToast(
          msg: "$strMsg",
          toastLength: toastLength,
          timeInSecForIosWeb: 1,
          backgroundColor: bgColor,
          textColor: textColor,
          fontSize: fontSize);

      isFirstToast = true;
    } catch (e) {
      print(e);
    }
  }

  //custom divider with height
  SizedBox putSizedBoxHeight(double value) {
    return SizedBox(
      height: value,
    );
  }

  //custom divider with width
  SizedBox putSizedBoxWidth(double value) {
    return SizedBox(
      width: value,
    );
  }

  //divider with color
  Divider putDivider(double value, Color lineColor) {
    return Divider(height: value, color: lineColor);
  }

  //format title
  String capitalizeFirstLetter(String strText) {
    try {
      if (strText == null)
        return "";
      else if (strText.trim().isEmpty)
        return "";
      else
        return strText[0].toUpperCase() + strText.substring(1);
    } catch (e) {
      print(e);
    }
    return "";
  }

  String allWordsCapitalize(String strText) {
    try {
      if (strText == null)
        return "";
      else if (strText.trim().isEmpty)
        return "";
      else
        return strText.trim().toLowerCase().split(' ').map((word) {
          String leftText =
              (word.length > 1) ? word.substring(1, word.length) : '';
          return word[0].toUpperCase() + leftText;
        }).join(' ');
    } catch (e) {
      print(e);
    }
    return "";
  }

  //check boolean format
  bool validBoolean(bool isValue) {
    try {
      if (isValue == null) {
        return false;
      } else {
        return isValue;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Column circularProgressIndicator(
      String strText, Color progressColor, Color textColor) {
    try {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          /*SpinKitCircle(
            color: progressColor,
          ),*/
          /*Padding(
            padding: EdgeInsets.all(minimumPadding * 2),
            child: Text(
              strText,
              style: TextStyle(
                  color: textColor, fontSize: 14.00, fontFamily: 'Roboto'),
            ),
          ),*/
        ],
      );
    } catch (e) {
      print(e);
    }
    return null;
  }

  void showErrorSnackBar(String strTitle, strMsg) {
    try {
      Get.snackbar('$strTitle', '$strMsg',
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  var boxTextFieldDecoration = (String label) => InputDecoration(
    contentPadding:
    EdgeInsets.only(top: 18, bottom: 18, left: 14, right: 14),
    labelText: label,
    counterText: "",
    labelStyle: TextStyle(
      fontSize: 14.0,
      color:Colors.grey,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide:
      BorderSide(color: Colors.grey.withOpacity(0.8), width: 0.7),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide( width:2, color: _middleWare.greenColor2),
    ),
  );

  Future<Map<String, String>> getRequestHeaders() async {
    final Map<String, String> requestHeadersTimeSlot = {};
    requestHeadersTimeSlot['Content-Type'] = 'application/json';
    requestHeadersTimeSlot['Accept'] = 'text/plain';

    return requestHeadersTimeSlot;
  }

  JumpingDotsProgressIndicator setJumpingDotsProgressIndicator(Color color,double value) {
    return JumpingDotsProgressIndicator(
      color: color,
      fontSize: value,
    );
  }
}


