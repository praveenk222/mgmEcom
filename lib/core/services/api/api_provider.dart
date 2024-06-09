import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:getxpoc/core/constants/api_key_const.dart';
import 'package:getxpoc/core/constants/api_url_const.dart';
import 'package:getxpoc/screens/authendication_pages/model/login_model.dart';
import 'package:getxpoc/screens/country_list/model/covid_case_country_item_model.dart';
import 'package:getxpoc/screens/my_cart/model/address_list_model.dart';
import 'package:getxpoc/screens/product_list/controller/product_list_controller.dart';
import 'package:getxpoc/screens/product_list/model/leftcategory_model.dart';
import 'package:getxpoc/screens/product_list/model/product_list_model.dart';

import '../../middleware.dart';
import 'package:http/http.dart' as http;

class APIProvider extends GetConnect {
  MiddleWare middleWare = MiddleWare();
  final productListController = Get.put(ProductListController());

  Future<List<CovidCaseResultItemModel>> getCountryList() async {
    var response = await http.get(Uri.parse(nameSpace));
    print(
        'REST Response Body: STATUS => ${response.statusCode} :: BODY => ${response.body}');
    return compute(covidCaseResultsModelFromJson, response.body);
  }


  Future<LoginModel> callLogin(String userName, String password) async {
    var header = await middleWare.getRequestHeaders();
    var data = {
      userIdKey: userName,
      passwordKey: password,
    };
    print('REST request Body: STATUS => ${json.encode(data)}');
    var response = await http.post(
      Uri.parse(baseURL + methodLogin),
      headers: header,
      body: json.encode(data),
    );
    print(
        'REST Response Body: STATUS => ${response.statusCode} :: BODY => ${response.body}');
    return compute(loginModelFromJson, response.body);
  }

  Future<LoginModel> callRegister(String userName,String emailId,String mobNo, String password) async {
    var header = await middleWare.getRequestHeaders();
    var data = {
      userNameKey: userName,
      emailIdKey: emailId,
      mobileNoKey: mobNo,
      passwordKey: password,
    };
    print('REST request Body: STATUS => ${json.encode(data)}');
    var response = await http.post(
      Uri.parse(baseURL + methodRegister),
      headers: header,
      body: json.encode(data),
    );
    print(
        'REST Response Body: STATUS => ${response.statusCode} :: BODY => ${response.body}');
    return compute(loginModelFromJson, response.body);
  }

  Future<List<ProductListModel>> getProductList() async {
    var response = await http.get(Uri.parse(baseURL+methodProductList));
    print(
        'REST Response Body: STATUS => ${response.statusCode} :: BODY => ${response.body}');
    return compute(productListModelFromJson, response.body);
  }

  Future<List<AddressListModel>> getAddressList() async {
    var response = await http.get(Uri.parse(baseURL+methodAddresses+productListController.loginModel.userId.toString()));
    print(
        'REST Response Body: STATUS => ${response.statusCode} :: BODY => ${response.body}');
    return compute(addressListModelFromJson, response.body);
  }

  Future<String> callAddAddress() async {
    var header = await middleWare.getRequestHeaders();
    print(
        'REST request Body: STATUS => ${json.encode(productListController.addressListModel)}');
    var response = await http.post(
      Uri.parse(baseURL + methodNewAddresses),
      headers: header,
      body: json.encode(productListController.addressListModel),
    );
    print(
        'REST Response Body: STATUS => ${response.statusCode} :: BODY => ${response.body}');
    return response.body;
  }

  Future<String> callDeleteAddress() async {
    print(
        'REST request Body: STATUS => ${productListController.delAddressId.value}');
    var response = await http.get(Uri.parse(
        baseURL + methodDeleteAdrees + productListController.delAddressId.value));

    print(
        'REST Response Body: STATUS => ${response.statusCode} :: BODY => ${response.body}');
    return response.body;
  }

  Future<List<LeftCategoryModel>> getLeftCategoryList() async {
    var response = await http.get(Uri.parse(baseURL+methodLeftcategory));
    print(
        'REST Response Body: STATUS => ${response.statusCode} :: BODY => ${response.body}');
    return compute(leftCategoryModelFromJson, response.body);
  }

  Future<String> callSaveOrderDetails() async {
    var header = await middleWare.getRequestHeaders();
    print(
        'REST request Body: STATUS => ${json.encode(productListController.saveOrderList)}');
    var response = await http.post(
      Uri.parse(baseURL + methodSaveorderDetails),
      headers: header,
      body: json.encode(productListController.saveOrderList),
    );
    print(
        'REST Response Body: STATUS => ${response.statusCode} :: BODY => ${response.body}');
    return response.body;
  }
}
