import 'package:get/get.dart';
import 'package:getxpoc/core/services/api/api_provider.dart';
import 'package:getxpoc/routes/routes.dart';
import 'package:getxpoc/screens/authendication_pages/model/login_model.dart';

class AuthendicationController extends GetxController {

  var isSplashScreen = false.obs;
  var loadingData = false.obs;
  LoginModel loginModel;
  var strEmailId = "".obs;
  var strOTP = "".obs;

  Future<bool> callLogin(String userName, String password) async {
    try {
      loadingData.value = true;
      var response = await APIProvider().callLogin(userName, password);
      loadingData.value = false;
      if (response != null) {
        loginModel = response;
      }
      return true;
    } catch (e) {
      //print(e);
      loadingData.value = false;
      return false;
    }
  }

  Future<bool> callRegister(
      String userName, String emailId, String mobNo, String password) async {
    try {
      loadingData.value = true;
      var response =
          await APIProvider().callRegister(userName, emailId, mobNo, password);
      loadingData.value = false;
      if (response != null) {
        loginModel = response;
      }
      return true;
    } catch (e) {
      //print(e);
      loadingData.value = false;
      return false;
    }
  }
}
