import 'dart:convert';


class SaveOrderModel {
  int orderId;
  String orderNo;
  String orderDate;
  int memberId;
  int orderStatus;
  int addressId;
  int discountAmount;
  String totalAmount;
  String paidAmount;
  String orderAmount;
  bool isCancel;
  bool isDelivered;
  String remarks;
  String createdOn;
  String modifiedOn;
  int cancelBy;
  String deliveredOn;
  String closedOn;
  String canceledOn;
  String sellingPrice;
  int productId;
  int qunatity;

  SaveOrderModel(
      {this.orderId,
        this.orderNo,
        this.orderDate,
        this.memberId,
        this.orderStatus,
        this.addressId,
        this.discountAmount,
        this.totalAmount,
        this.paidAmount,
        this.orderAmount,
        this.isCancel,
        this.isDelivered,
        this.remarks,
        this.createdOn,
        this.modifiedOn,
        this.cancelBy,
        this.deliveredOn,
        this.closedOn,
        this.canceledOn,
        this.sellingPrice,
        this.productId,
        this.qunatity});

  SaveOrderModel.fromJson(Map<String, dynamic> json) {
    try {
      orderId = json['orderId'];
      orderNo = json['orderNo'];
      orderDate = json['orderDate'];
      memberId = json['memberId'];
      orderStatus = json['orderStatus'];
      addressId = json['addressId'];
      discountAmount = json['discountAmount'];
      totalAmount = json['totalAmount'];
      paidAmount = json['paidAmount'];
      orderAmount = json['orderAmount'];
      isCancel = json['isCancel'];
      isDelivered = json['isDelivered'];
      remarks = json['remarks'];
      createdOn = json['createdOn'];
      modifiedOn = json['modifiedOn'];
      cancelBy = json['cancelBy'];
      deliveredOn = json['deliveredOn'];
      closedOn = json['closedOn'];
      canceledOn = json['canceledOn'];
      sellingPrice = json['sellingPrice'];
      productId = json['productId'];
      qunatity = json['qunatity'];
    } catch (e) {
      //print(e);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    try {
      data['orderId'] = this.orderId;
      data['orderNo'] = this.orderNo;
      data['orderDate'] = this.orderDate;
      data['memberId'] = this.memberId;
      data['orderStatus'] = this.orderStatus;
      data['addressId'] = this.addressId;
      data['discountAmount'] = this.discountAmount;
      data['totalAmount'] = this.totalAmount;
      data['paidAmount'] = this.paidAmount;
      data['orderAmount'] = this.orderAmount;
      data['isCancel'] = this.isCancel;
      data['isDelivered'] = this.isDelivered;
      data['remarks'] = this.remarks;
      data['createdOn'] = this.createdOn;
      data['modifiedOn'] = this.modifiedOn;
      data['cancelBy'] = this.cancelBy;
      data['deliveredOn'] = this.deliveredOn;
      data['closedOn'] = this.closedOn;
      data['canceledOn'] = this.canceledOn;
      data['sellingPrice'] = this.sellingPrice;
      data['productId'] = this.productId;
      data['qunatity'] = this.qunatity;
    } catch (e) {
      //print(e);
    }
    return data;
  }
}



