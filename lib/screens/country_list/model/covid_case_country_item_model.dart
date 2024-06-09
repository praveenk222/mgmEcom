import 'dart:convert';

List<CovidCaseResultItemModel> covidCaseResultsModelFromJson(str) =>
    List<CovidCaseResultItemModel>.from(
        json.decode(str).map((x) => CovidCaseResultItemModel.fromJson(x)));

String covidCaseResultsModelToJson(List<CovidCaseResultItemModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CovidCaseResultItemModel {
  var updated;
  String country;
  CountryInfo countryInfo;
  var cases;
  var todayCases;
  var deaths;
  var todayDeaths;
  var recovered;
  var todayRecovered;
  var active;
  var critical;
  var casesPerOneMillion;
  var deathsPerOneMillion;
  var tests;
  var testsPerOneMillion;
  var population;
  String continent;
  var oneCasePerPeople;
  var oneDeathPerPeople;
  var oneTestPerPeople;
  var activePerOneMillion;
  var recoveredPerOneMillion;
  var criticalPerOneMillion;

  CovidCaseResultItemModel(
      {this.updated,
      this.country,
      this.countryInfo,
      this.cases,
      this.todayCases,
      this.deaths,
      this.todayDeaths,
      this.recovered,
      this.todayRecovered,
      this.active,
      this.critical,
      this.casesPerOneMillion,
      this.deathsPerOneMillion,
      this.tests,
      this.testsPerOneMillion,
      this.population,
      this.continent,
      this.oneCasePerPeople,
      this.oneDeathPerPeople,
      this.oneTestPerPeople,
      this.activePerOneMillion,
      this.recoveredPerOneMillion,
      this.criticalPerOneMillion});

  CovidCaseResultItemModel.fromJson(Map<String, dynamic> json) {
    try {
      updated = json['updated'];
      country = json['country'];
      countryInfo = json['countryInfo'] != null
          ? new CountryInfo.fromJson(json['countryInfo'])
          : null;
      cases = json['cases'];
      todayCases = json['todayCases'];
      deaths = json['deaths'];
      todayDeaths = json['todayDeaths'];
      recovered = json['recovered'];
      todayRecovered = json['todayRecovered'];
      active = json['active'];
      critical = json['critical'];
      casesPerOneMillion = json['casesPerOneMillion'];
      deathsPerOneMillion = json['deathsPerOneMillion'];
      tests = json['tests'];
      testsPerOneMillion = json['testsPerOneMillion'];
      population = json['population'];
      continent = json['continent'];
      oneCasePerPeople = json['oneCasePerPeople'];
      oneDeathPerPeople = json['oneDeathPerPeople'];
      oneTestPerPeople = json['oneTestPerPeople'];
      activePerOneMillion = json['activePerOneMillion'];
      recoveredPerOneMillion = json['recoveredPerOneMillion'];
      criticalPerOneMillion = json['criticalPerOneMillion'];
    } catch (e) {
      print(e);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    try {
      data['updated'] = this.updated;
      data['country'] = this.country;
      if (this.countryInfo != null) {
        data['countryInfo'] = this.countryInfo.toJson();
      }
      data['cases'] = this.cases;
      data['todayCases'] = this.todayCases;
      data['deaths'] = this.deaths;
      data['todayDeaths'] = this.todayDeaths;
      data['recovered'] = this.recovered;
      data['todayRecovered'] = this.todayRecovered;
      data['active'] = this.active;
      data['critical'] = this.critical;
      data['casesPerOneMillion'] = this.casesPerOneMillion;
      data['deathsPerOneMillion'] = this.deathsPerOneMillion;
      data['tests'] = this.tests;
      data['testsPerOneMillion'] = this.testsPerOneMillion;
      data['population'] = this.population;
      data['continent'] = this.continent;
      data['oneCasePerPeople'] = this.oneCasePerPeople;
      data['oneDeathPerPeople'] = this.oneDeathPerPeople;
      data['oneTestPerPeople'] = this.oneTestPerPeople;
      data['activePerOneMillion'] = this.activePerOneMillion;
      data['recoveredPerOneMillion'] = this.recoveredPerOneMillion;
      data['criticalPerOneMillion'] = this.criticalPerOneMillion;
    } catch (e) {
      print(e);
    }

    return data;
  }
}

class CountryInfo {
  var iId;
  String iso2;
  String iso3;
  var lat;
  var long;
  String flag;

  CountryInfo({this.iId, this.iso2, this.iso3, this.lat, this.long, this.flag});

  CountryInfo.fromJson(Map<String, dynamic> json) {
    try {
      iId = json['_id'];
      iso2 = json['iso2'];
      iso3 = json['iso3'];
      lat = json['lat'];
      long = json['long'];
      flag = json['flag'];
    } catch (e) {
      print(e);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    try {
      data['_id'] = this.iId;
      data['iso2'] = this.iso2;
      data['iso3'] = this.iso3;
      data['lat'] = this.lat;
      data['long'] = this.long;
      data['flag'] = this.flag;
    } catch (e) {
      print(e);
    }
    return data;
  }
}
