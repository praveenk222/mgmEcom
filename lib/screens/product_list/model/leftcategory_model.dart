import 'dart:convert';

List<LeftCategoryModel> leftCategoryModelFromJson(str) =>
    List<LeftCategoryModel>.from(
        json.decode(str).map((x) => LeftCategoryModel.fromJson(x)));

String leftCategoryModelToJson(List<LeftCategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LeftCategoryModel {
  int lookupId;
  String lookupCode;
  String lookupDescription;
  String lookupDescriptionTh;
  String lookupCategory;
  bool status;
  String isocode;
  String mappingCode;
  String createdBy;
  String createdOn;
  String modifiedBy;
  String modifiedOn;
  bool selCategory = false;

  LeftCategoryModel(
      {this.lookupId,
        this.lookupCode,
        this.lookupDescription,
        this.lookupDescriptionTh,
        this.lookupCategory,
        this.status,
        this.isocode,
        this.mappingCode,
        this.createdBy,
        this.createdOn,
        this.modifiedBy,
        this.modifiedOn});

  LeftCategoryModel.fromJson(Map<String, dynamic> json) {
    try {
      lookupId = json['lookupId'];
      lookupCode = json['lookupCode'];
      lookupDescription = json['lookupDescription'];
      lookupDescriptionTh = json['lookupDescriptionTh'];
      lookupCategory = json['lookupCategory'];
      status = json['status'];
      isocode = json['isocode'];
      mappingCode = json['mappingCode'];
      createdBy = json['createdBy'];
      createdOn = json['createdOn'];
      modifiedBy = json['modifiedBy'];
      modifiedOn = json['modifiedOn'];
    } catch (e) {
      //print(e);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    try {
      data['lookupId'] = this.lookupId;
      data['lookupCode'] = this.lookupCode;
      data['lookupDescription'] = this.lookupDescription;
      data['lookupDescriptionTh'] = this.lookupDescriptionTh;
      data['lookupCategory'] = this.lookupCategory;
      data['status'] = this.status;
      data['isocode'] = this.isocode;
      data['mappingCode'] = this.mappingCode;
      data['createdBy'] = this.createdBy;
      data['createdOn'] = this.createdOn;
      data['modifiedBy'] = this.modifiedBy;
      data['modifiedOn'] = this.modifiedOn;
    } catch (e) {
      //print(e);
    }
    return data;
  }
}


