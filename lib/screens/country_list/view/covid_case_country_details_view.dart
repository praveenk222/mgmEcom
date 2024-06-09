import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxpoc/core/middleware.dart';
import 'package:getxpoc/screens/country_list/controller/covid_case_country_list_controller.dart';
import 'package:getxpoc/screens/country_list/model/covid_case_country_item_model.dart';
import 'package:google_fonts/google_fonts.dart';

class CountryDetailsView extends StatelessWidget {
  final List<CovidCaseResultItemModel> countryList;
  final int index;
  MiddleWare middleWare = MiddleWare();
  CarouselController carouselController = CarouselController();

  final CovidCaseCountryListController controller = Get.find();

  CountryDetailsView(
      {Key key, @required this.countryList, @required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () async {
            try {
              Navigator.pop(context);
              middleWare.hideKeyBoard(context);
              await 1.delay();
              controller.onClear();
            } catch (e) {
              print(e);
            }
          },
          child: Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.black,
          ),
        ),
        title: Obx(
          () => Text(middleWare.validString(controller.appBarTitle.value),
              style: GoogleFonts.merienda(
                  textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600))),
        ),
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: CarouselSlider(
          carouselController: carouselController,
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height,
            autoPlay: false,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            initialPage: index,
            onPageChanged: (index, reason) {
              try {
                controller.onPageChanged(index, countryList);
              } catch (e) {
                print(e);
              }
            },
          ),
          items: countryList
              .map(
                (item) => Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    /*padding:
                              EdgeInsets.all(middleWare.minimumPadding * 2),*/
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          middleWare.putSizedBoxHeight(15.00),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.00),
                            child: Image.network(
                              middleWare.validString(item.countryInfo.flag),
                              fit: BoxFit.fill,
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 180,
                            ),
                          ),
                          middleWare.putSizedBoxHeight(15.00),
                          itemView("Cases : ",
                              middleWare.validString(item.cases.toString())),
                          itemView(
                              "Today's Cases : ",
                              middleWare
                                  .validString(item.todayCases.toString())),
                          itemView("Active Cases : ",
                              middleWare.validString(item.active.toString())),
                          itemView("Deaths : ",
                              middleWare.validString(item.deaths.toString())),
                          itemView(
                              "TodayDeaths : ",
                              middleWare
                                  .validString(item.todayDeaths.toString())),
                          itemView(
                              "Recovered : ",
                              middleWare
                                  .validString(item.recovered.toString())),
                          itemView("Critical : ",
                              middleWare.validString(item.critical.toString())),
                          middleWare.putSizedBoxHeight(30.00),
                        ],
                      ),
                    )),
              )
              .toList(),
        ),
      ),
    );
  }

  itemView(String label, String value) {
    return Column(
      children: [
        middleWare.putSizedBoxHeight(15.00),
        Card(
          elevation: 2.0,
          color: Color(0xffE5EFFA),
          margin: EdgeInsets.only(
            left: middleWare.minimumPadding * 5,
            right: middleWare.minimumPadding * 5,
            bottom: middleWare.minimumPadding * 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            padding: EdgeInsets.only(
              top: middleWare.minimumPadding * 2,
              left: middleWare.minimumPadding * 3,
              right: middleWare.minimumPadding * 3,
              bottom: middleWare.minimumPadding * 2,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    label,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withOpacity(0.7))),
                  ),
                ),
                middleWare.putSizedBoxWidth(5.0),
                Expanded(
                  flex: 1,
                  child: Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
