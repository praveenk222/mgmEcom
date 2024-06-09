import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxpoc/core/middleware.dart';
import 'package:getxpoc/screens/country_list/controller/covid_case_country_list_controller.dart';
import 'package:getxpoc/screens/country_list/model/covid_case_country_item_model.dart';
import 'package:google_fonts/google_fonts.dart';

import 'covid_case_country_details_view.dart';

class CountryListView extends StatelessWidget {
  final controller = Get.put(
    CovidCaseCountryListController(),
  );
  MiddleWare middleWare = MiddleWare();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(middleWare.minimumPadding),
              child: Image.asset(
                'assets/images/ft_germ.png',
                width: 45,
                height: 45,
                fit: BoxFit.fill,
              ),
            ),
            middleWare.putSizedBoxWidth(5.0),
            Text("Countries",
                style: GoogleFonts.merienda(
                    textStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600))),
          ],
        ),
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Obx(
          () {
            return controller.isLoading.value
                ? Center(
                    child: middleWare.circularProgressIndicator(
                      "Loading,Please Wait...",
                      middleWare.uiPacificBlueColor,
                      middleWare.uiNordicColor,
                    ),
                  )
                : controller.countryList.value != null &&
                        controller.countryList.value.length > 0
                    ? Container(
                        color: Theme.of(context).backgroundColor,
                        height: double.infinity,
                        child: Column(
                          children: [
                            Container(
                              padding:
                                  EdgeInsets.all(middleWare.minimumPadding),
                              child: ListTile(
                                leading: Icon(
                                  Icons.search,
                                  size: 26,
                                ),
                                title: TextFormField(
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  )),
                                  controller: controller.searchController.value,
                                  decoration: InputDecoration(
                                      hintText: "Search country...",
                                      hintStyle: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                        color: middleWare.uiFordGrayColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      )),
                                      border: InputBorder.none),
                                  onChanged: controller.onSearchTextChanged,
                                ),
                                trailing: middleWare
                                        .validString(controller
                                            .searchController.value.text)
                                        .trim()
                                        .isNotEmpty
                                    ? IconButton(
                                        icon: Icon(Icons.cancel),
                                        onPressed: () {
                                          try {
                                            controller.searchController.value
                                                .clear();
                                            controller.onSearchTextChanged('');
                                          } catch (e) {
                                            print(e);
                                          }
                                        },
                                      )
                                    : Text(""),
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Container(
                                  margin: EdgeInsets.only(
                                    top: middleWare.minimumPadding * 2,
                                    left: middleWare.minimumPadding * 2,
                                    right: middleWare.minimumPadding * 2,
                                    bottom: middleWare.minimumPadding * 2,
                                  ),
                                  child: controller.searchCountryList.value
                                                  .length >
                                              0 ||
                                          middleWare
                                              .validString(controller
                                                  .searchController.value.text)
                                              .trim()
                                              .isNotEmpty
                                      ? controller.searchCountryList.value
                                                  .length >
                                              0
                                          ? ListView.builder(
                                              shrinkWrap: true,
                                              physics: ClampingScrollPhysics(),
                                              itemCount: controller
                                                  .searchCountryList
                                                  .value
                                                  .length,
                                              itemBuilder: (context, index) {
                                                CovidCaseResultItemModel
                                                    covidCaseResultsModel =
                                                    controller.searchCountryList
                                                        .value[index];
                                                return _countryView(
                                                    covidCaseResultsModel,
                                                    index,
                                                    context);
                                              })
                                          : setLabel("No countries found!")
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics: ClampingScrollPhysics(),
                                          itemCount: controller
                                              .countryList.value.length,
                                          itemBuilder: (context, index) {
                                            CovidCaseResultItemModel
                                                covidCaseResultsModel =
                                                controller
                                                    .countryList.value[index];
                                            return _countryView(
                                                covidCaseResultsModel,
                                                index,
                                                context);
                                          }),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : setLabel("No countries found!");
          },
        ),
      ),
    );
  }

  Center setLabel(String strText) {
    try {
      return Center(
        child: Text(
          "$strText",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
            color: Colors.black.withOpacity(0.45),
            fontWeight: FontWeight.w600,
            fontSize: 16,
          )),
        ),
      );
    } catch (e) {
      print(e);
    }
    return null;
  }

  _countryView(
      CovidCaseResultItemModel model, int index, BuildContext context) {
    return Card(
      color: Color(0xffE5EFFA),
      elevation: 3.0,
      margin: EdgeInsets.only(
        top: middleWare.minimumPadding * 2,
        left: middleWare.minimumPadding,
        right: middleWare.minimumPadding,
        bottom: middleWare.minimumPadding * 2,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        leading: ClipOval(
          child: CachedNetworkImage(
            imageUrl: middleWare.validString(model.countryInfo.flag),
            width: 50,
            height: 50,
            fit: BoxFit.fill,
          ),
        ),
        title: Text(
          middleWare.validString(model.country),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 3.0),
          child: Text(
            middleWare.validString(model.continent),
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            )),
          ),
        ),
        onTap: () async {
          try {
            final indexValue = controller.countryList.value.indexWhere(
                (element) =>
                    middleWare.validString(element.country) ==
                    middleWare.validString(model.country));
            controller.onPageChanged(indexValue, controller.countryList.value);
            Get.to(CountryDetailsView(
              countryList: controller.countryList.value,
              index: indexValue,
            ));
            await 1.delay();
            controller.searchController.value.clear();
            controller.onSearchTextChanged('');
            middleWare.hideKeyBoard(context);
          } catch (e) {
            print(e);
          }
        },
        trailing: GestureDetector(
          onTap: () async {
            try {
              final indexValue = controller.countryList.value.indexWhere(
                  (element) =>
                      middleWare.validString(element.country) ==
                      middleWare.validString(model.country));
              controller.onPageChanged(
                  indexValue, controller.countryList.value);
              Get.to(CountryDetailsView(
                countryList: controller.countryList.value,
                index: indexValue,
              ));
              await 1.delay();
              controller.searchController.value.clear();
              controller.onSearchTextChanged('');
              middleWare.hideKeyBoard(context);
            } catch (e) {
              print(e);
            }
          },
          child: Icon(
            Icons.arrow_forward_ios_sharp,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
