import 'package:get/get.dart';
import 'package:getxpoc/screens/country_list/controller/covid_case_country_list_controller.dart';
import 'package:getxpoc/screens/country_list/view/covid_case_country_list_view.dart';
import 'package:getxpoc/screens/splash/controller/splash_controller.dart';
import 'package:getxpoc/screens/splash/view/splash_view.dart';

abstract class Routes {
  static const SPLASH = '/splash';
  static const CountryListPage = '/countryListPage';
}

abstract class AppPages {
  static String initial = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashView(),
      binding: BindingsBuilder.put(() => SplashController()),
    ),
    GetPage(
      name: Routes.CountryListPage,
      page: () => CountryListView(),
      binding: BindingsBuilder.put(() => CovidCaseCountryListController()),
    ),
  ];
}
