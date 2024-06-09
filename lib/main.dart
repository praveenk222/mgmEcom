import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:getxpoc/routes/routes.dart';
import 'package:getxpoc/screens/splash/view/splash_view.dart';

import 'core/constants/preference_util.dart';
import 'core/middleware.dart';
import 'core/network_screen.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // status bar color
    ));
    PreferenceUtil.init();
    runApp(MyApp());
  } catch (e) {
    //print(e);
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MiddleWare middleWare = MiddleWare();
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool internetConnection = true;

  @override
  void initState() {
    try {
      super.initState();
      initConnectivity();
      _connectivitySubscription =
          _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    try {
      _connectivitySubscription.cancel();
      super.dispose();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      enableLog: false,
      title: MiddleWare.APP_NAME,
      home: SplashView(),
      //home: HomeView(),
      getPages: AppPages.routes,
      /*initialRoute: AppPages.initial,*/
    );
  }

  initConnectivity() async {

    ConnectivityResult result;

    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {}

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        if (!internetConnection) {
          Navigator.pop(Get.context);
        }

        setState(() {
          internetConnection = true;

          //toast.getToast(wifi_connected, Colors.green);
        });
        break;
      case ConnectivityResult.mobile:
        if (!internetConnection) {
          Navigator.pop(Get.context);
        }
        setState(() {
          internetConnection = true;
        });
        break;
      case ConnectivityResult.none:
        Get.to(NetworkScreen());
        setState(() {
          internetConnection = false;
          // toast.getToast(no_internet_conn, Colors.red);
        });
        break;
      default:
        setState(() {
          internetConnection = false;
          middleWare.showErrorSnackBar(
              "Offline", "Failed to get internet connectivity");
        });
        break;
    }
  }
}
