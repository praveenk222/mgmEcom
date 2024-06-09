import 'dart:convert';

LoginModel loginModelFromJson(str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  int userId;
  String userName;
  String password;
  String firstName;
  String lastName;
  String emailId;
  String mobileNo;
  int memberType;
  String otp;
  bool isOtpsent;
  String otpsentDate;
  bool isResendOtp;
  bool isOtpverified;
  bool isActive;
  String createdOn;
  String aboutUs;
  String website;
  String profilePhoto;
  bool isAcceptedTermsConditions;
  String message;

  LoginModel(
      {this.userId,
        this.userName,
        this.password,
        this.firstName,
        this.lastName,
        this.emailId,
        this.mobileNo,
        this.memberType,
        this.otp,
        this.isOtpsent,
        this.otpsentDate,
        this.isResendOtp,
        this.isOtpverified,
        this.isActive,
        this.createdOn,
        this.aboutUs,
        this.website,
        this.profilePhoto,
        this.isAcceptedTermsConditions,this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
    try {
      userId = json['userId'];
      userName = json['userName'];
      password = json['password'];
      firstName = json['firstName'];
      lastName = json['lastName'];
      emailId = json['emailId'];
      mobileNo = json['mobileNo'];
      memberType = json['memberType'];
      otp = json['otp'];
      isOtpsent = json['isOtpsent'];
      otpsentDate = json['otpsentDate'];
      isResendOtp = json['isResendOtp'];
      isOtpverified = json['isOtpverified'];
      isActive = json['isActive'];
      createdOn = json['createdOn'];
      aboutUs = json['aboutUs'];
      website = json['website'];
      profilePhoto = json['profilePhoto'];
      isAcceptedTermsConditions = json['isAcceptedTermsConditions'];
      message = json['message'];
    } catch (e) {
      //print(e);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    try {
      data['userId'] = this.userId;
      data['userName'] = this.userName;
      data['password'] = this.password;
      data['firstName'] = this.firstName;
      data['lastName'] = this.lastName;
      data['emailId'] = this.emailId;
      data['mobileNo'] = this.mobileNo;
      data['memberType'] = this.memberType;
      data['otp'] = this.otp;
      data['isOtpsent'] = this.isOtpsent;
      data['otpsentDate'] = this.otpsentDate;
      data['isResendOtp'] = this.isResendOtp;
      data['isOtpverified'] = this.isOtpverified;
      data['isActive'] = this.isActive;
      data['createdOn'] = this.createdOn;
      data['aboutUs'] = this.aboutUs;
      data['website'] = this.website;
      data['profilePhoto'] = this.profilePhoto;
      data['isAcceptedTermsConditions'] = this.isAcceptedTermsConditions;
      data['message'] = this.message;
    } catch (e) {
      //print(e);
    }
    return data;
  }
}
