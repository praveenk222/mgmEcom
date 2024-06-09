import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getxpoc/core/middleware.dart';
import 'package:getxpoc/core/services/api/api_provider.dart';
import 'package:getxpoc/screens/authendication_pages/model/login_model.dart';
import 'package:getxpoc/screens/my_cart/model/address_list_model.dart';
import 'package:getxpoc/screens/my_cart/model/save_order_model.dart';
import 'package:getxpoc/screens/product_list/model/leftcategory_model.dart';

class ProductListController extends GetxController {

  var loadingData = false.obs;
  var addressLoadingData = false.obs;
  var saveOrderLoadingData = false.obs;
  LoginModel loginModel;
  MiddleWare middleWare = MiddleWare();
  var productList = [].obs;
  var addressList = [].obs;
  var strTotCount = 0.obs;
  var strTotAmount = 0.0.obs;
  var selAddressId = 0.obs;
  var selCategoryId = 0.obs;
  var selAddressType = 0.obs;
  AddressListModel addressListModel;
  var isAddAddress = true.obs;
  var delAddressId = "".obs;
  var leftCategoryList = [].obs;
  List<SaveOrderModel> saveOrderList = [];
  var appBarTitle = "".obs;


  getLeftCategory() async {
    try {
      /*imageCache.clear();
      imageCache.clearLiveImages();*/
      loadingData.value = true;
      leftCategoryList.value = [];
      var response = await APIProvider().getLeftCategoryList();
      if (response != null) {
        leftCategoryList.value = response;
        if(leftCategoryList != null &&
            leftCategoryList.length > 0){
          LeftCategoryModel leftCategoryModel =
          leftCategoryList[0];
          selCategoryId.value = leftCategoryModel?.lookupId??0;
          appBarTitle.value = leftCategoryModel?.lookupDescription??"";
        }
      }
      //loadingData.value = false;
      getProducts();
    } catch (e) {
      print(e);
    }
  }


  getProducts() async {
    try {
      //loadingData.value = true;
      productList.value = [];
      var response = await APIProvider().getProductList();
      if (response != null) {
        productList.value = response;
      }
      loadingData.value = false;
    } catch (e) {
      print(e);
    }
  }

  getAddressList() async {
    try {
      addressLoadingData.value = true;
      addressList.value = [];
      var response = await APIProvider().getAddressList();
      if (response != null) {
        addressList.value = response;
        if(addressList != null &&
            addressList.length > 0){
          AddressListModel addressListModel =
          addressList[0];
          selAddressId.value = int.parse(addressListModel.addressId.toString());
        }
      }
      addressLoadingData.value = false;
    } catch (e) {
      print(e);
    }
  }


  Future<bool> callAddAddress() async {
    try {
      loadingData.value = true;
      var response = await APIProvider().callAddAddress();
      loadingData.value = false;
      if (response != null && response.toString().contains("true")) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      //print(e);
      loadingData.value = false;
      return false;
    }
  }

  Future<bool> callDeleteAddress() async {
    try {
      //loadingData.value = true;
      var response = await APIProvider().callDeleteAddress();
      //loadingData.value = false;
      if (response != null && response.toString().contains("true")) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      //print(e);
      //loadingData.value = false;
      return false;
    }
  }

  Future<bool> callSaveOrderDetails() async {
    try {
      saveOrderLoadingData.value = true;
      var response = await APIProvider().callSaveOrderDetails();
      saveOrderLoadingData.value = false;
      if (response != null && response.toString().contains("true")) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      //print(e);
      saveOrderLoadingData.value = false;
      return false;
    }
  }

}
