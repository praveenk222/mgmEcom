import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxpoc/core/middleware.dart';
import 'package:getxpoc/core/services/api/api_provider.dart';
import 'package:getxpoc/screens/country_list/model/covid_case_country_item_model.dart';

class CovidCaseCountryListController extends GetxController {
  var countryList = [].obs;
  var searchCountryList = [].obs;
  var appBarTitle = "".obs;
  var isLoading = false.obs;
  MiddleWare middleWare = MiddleWare();
  var searchController = TextEditingController().obs;

  @override
  void onReady() {
    try {
      super.onReady();
      getCountries();
    } catch (e) {
      print(e);
    }
  }

  getCountries() async {
    try {
      isLoading.value = true;
      countryList.value = [];
      var response = await APIProvider().getCountryList();
      if (response != null) {
        countryList.value = response;
      }
      isLoading.value = false;
    } catch (e) {
      print(e);
    }
  }

  onSearchTextChanged(String text) async {
    try {
      searchCountryList.value = [];

      if (text.trim().isEmpty) {
        return;
      }

      countryList.forEach((countries) {
        if (countries.country.toLowerCase().contains(text.toLowerCase()))
          searchCountryList.value.add(countries);
      });
    } catch (e) {
      print(e);
    }
  }

  onPageChanged(int index, List<CovidCaseResultItemModel> countryList) async {
    try {
      appBarTitle.value = "";
      appBarTitle.value = middleWare.validString(countryList[index].country);
      print("appBarTitle ${appBarTitle.value}");
      update();
    } catch (e) {
      print(e);
    }
  }

  onClear() async {
    try {
      appBarTitle.value = "";
      update();
    } catch (e) {
      print(e);
    }
  }
}
