import 'package:get/get.dart';

class SplashController extends GetxController {

  var isSplashScreen = false.obs;


  @override
  void onReady() {
    try {
      super.onReady();
      initState();
    } catch (e) {
      print(e);
    }
  }

  initState() async
  {
    try {
      await 2.delay();
      //Get.offAllNamed(Routes.CountryListPage);
    } catch (e) {
      print(e);
    }
  }
}
