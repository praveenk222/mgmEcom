import 'dart:convert';

List<AddressListModel> addressListModelFromJson(str) =>
    List<AddressListModel>.from(
        json.decode(str).map((x) => AddressListModel.fromJson(x)));

String addressListModelToJson(List<AddressListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddressListModel {
  var addressId;
  var linkId;
  var addressType;
  String addressName;
  String mobileNo;
  String zipCode;
  String locality;
  String memberAddress;
  String state;
  String country;
  String landmark;
  String alternateNo;
  bool isActive;
  String createdOn;
  String modifiedOn;
  String imageFile;
  var selAddressId;

  AddressListModel(
      {this.addressId,
        this.linkId,
        this.addressType,
        this.addressName,
        this.mobileNo,
        this.zipCode,
        this.locality,
        this.memberAddress,
        this.state,
        this.country,
        this.landmark,
        this.alternateNo,
        this.isActive,
        this.createdOn,
        this.modifiedOn,this.imageFile,this.selAddressId="0"});

  AddressListModel.fromJson(Map<String, dynamic> json) {
    try {
      addressId = json['addressId'];
      linkId = json['linkId'];
      addressType = json['addressType'];
      addressName = json['addressName'];
      mobileNo = json['mobileNo'];
      zipCode = json['zipCode'];
      locality = json['locality'];
      memberAddress = json['memberAddress'];
      state = json['state'];
      country = json['country'];
      landmark = json['landmark'];
      alternateNo = json['alternateNo'];
      isActive = json['isActive'];
      createdOn = json['createdOn'];
      modifiedOn = json['modifiedOn'];
      imageFile = json['imageFile'];
      selAddressId = 0;
    } catch (e) {
      print(e);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    try {
      data['addressId'] = this.addressId;
      data['linkId'] = this.linkId;
      data['addressType'] = this.addressType;
      data['addressName'] = this.addressName;
      data['mobileNo'] = this.mobileNo;
      data['zipCode'] = this.zipCode;
      data['locality'] = this.locality;
      data['memberAddress'] = this.memberAddress;
      data['state'] = this.state;
      data['country'] = this.country;
      data['landmark'] = this.landmark;
      data['alternateNo'] = this.alternateNo;
      data['isActive'] = this.isActive;
      data['createdOn'] = this.createdOn;
      data['modifiedOn'] = this.modifiedOn;
      data['imageFile'] = this.imageFile;
    } catch (e) {
      //print(e);
    }
    return data;
  }
}


