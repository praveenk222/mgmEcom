import 'dart:convert';

import 'package:getxpoc/core/middleware.dart';

List<ProductListModel> productListModelFromJson(str) =>
    List<ProductListModel>.from(
        json.decode(str).map((x) => ProductListModel.fromJson(x)));

String productListModelToJson(List<ProductListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

MiddleWare middleWare = MiddleWare();

class ProductListModel {
  var productId;
  String productCode;
  String productName;
  var productType;
  var gender;
  var breedType;
  var sellerId;
  String talents;
  String fightingRecord;
  String productBrand;
  String dateOfBirth;
  var uom;
  var weight;
  var standardPrice;
  var discount;
  String currency;
  var paymentOption;
  String productImage;
  String remarks;
  bool isActive;
  bool isAvailable;
  var stockQty;
  String createdOn;
  String modifiedOn;
  var age;
  String breed;
  String province;
  var ageType;
  String uomDesc;
  var count;

  ProductListModel(
      {this.productId,
        this.productCode,
        this.productName,
        this.productType,
        this.gender,
        this.breedType,
        this.sellerId,
        this.talents,
        this.fightingRecord,
        this.productBrand,
        this.dateOfBirth,
        this.uom,
        this.weight,
        this.standardPrice,
        this.discount,
        this.currency,
        this.paymentOption,
        this.productImage,
        this.remarks,
        this.isActive,
        this.isAvailable,
        this.stockQty,
        this.createdOn,
        this.modifiedOn,
        this.age,
        this.breed,
        this.province,
        this.ageType,this.uomDesc,this.count = 0});

  ProductListModel.fromJson(Map<String, dynamic> json) {
    try {
      productId = json['productID'];
      productCode = json['productCode'];
      productName = json['productName'];
      productType = json['productType'];
      gender = json['gender'];
      breedType = json['breedType'];
      sellerId = json['sellerId'];
      talents = json['talents'];
      fightingRecord = json['fightingRecord'];
      productBrand = json['productBrand'];
      dateOfBirth = json['dateOfBirth'];
      uom = json['uom'];
      weight = json['weight'];
      standardPrice = json['standardPrice'];
      discount = json['discount'];
      currency = json['currency'];
      paymentOption = json['paymentOption'];
      productImage = json['productImage'];
      remarks = json['remarks'];
      isActive = json['isActive'];
      isAvailable = json['isAvailable'];
      stockQty = json['stockQty'];
      createdOn = json['createdOn'];
      modifiedOn = json['modifiedOn'];
      age = json['age'];
      breed = json['breed'];
      province = json['province'];
      ageType = json['ageType'];
      uomDesc = json['uomDesc'];
      count = 0;
      if (middleWare.validString(weight.toString() ?? "").trim().isNotEmpty) {
        weight = "${weight.toString()} ${uomDesc.toString().toLowerCase()?? ""}";
      }
    } catch (e) {
      print(e);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    try {
      data['productId'] = this.productId;
      data['productCode'] = this.productCode;
      data['productName'] = this.productName;
      data['productType'] = this.productType;
      data['gender'] = this.gender;
      data['breedType'] = this.breedType;
      data['sellerId'] = this.sellerId;
      data['talents'] = this.talents;
      data['fightingRecord'] = this.fightingRecord;
      data['productBrand'] = this.productBrand;
      data['dateOfBirth'] = this.dateOfBirth;
      data['uom'] = this.uom;
      data['weight'] = this.weight;
      data['standardPrice'] = this.standardPrice;
      data['discount'] = this.discount;
      data['currency'] = this.currency;
      data['paymentOption'] = this.paymentOption;
      data['productImage'] = this.productImage;
      data['remarks'] = this.remarks;
      data['isActive'] = this.isActive;
      data['isAvailable'] = this.isAvailable;
      data['stockQty'] = this.stockQty;
      data['createdOn'] = this.createdOn;
      data['modifiedOn'] = this.modifiedOn;
      data['age'] = this.age;
      data['breed'] = this.breed;
      data['province'] = this.province;
      data['uomDesc'] = this.uomDesc;
      data['ageType'] = this.ageType;
    } catch (e) {
      //print(e);
    }
    return data;
  }
}

