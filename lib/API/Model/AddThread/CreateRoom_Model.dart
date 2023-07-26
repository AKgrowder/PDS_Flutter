class CreatPublicRoomModel {
  String? message;
  Object? object;
  bool? success;

  CreatPublicRoomModel({this.message, this.object, this.success});

  CreatPublicRoomModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    object =
        json['object'] != null ? new Object.fromJson(json['object']) : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.object != null) {
      data['object'] = this.object!.toJson();
    }
    data['success'] = this.success;
    return data;
  }
}

class Object {
  int? id;
  String? createdAt;
  Null? createdBy;
  Null? status;
  Null? isActive;
  String? uid;
  String? modifiedAt;
  Null? modifiedBy;
  String? roomQuestion;
  String? description;
  String? roomType;
  User? user;

  Object(
      {this.id,
      this.createdAt,
      this.createdBy,
      this.status,
      this.isActive,
      this.uid,
      this.modifiedAt,
      this.modifiedBy,
      this.roomQuestion,
      this.description,
      this.roomType,
      this.user});

  Object.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    status = json['status'];
    isActive = json['isActive'];
    uid = json['uid'];
    modifiedAt = json['modifiedAt'];
    modifiedBy = json['modifiedBy'];
    roomQuestion = json['roomQuestion'];
    description = json['description'];
    roomType = json['roomType'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    data['status'] = this.status;
    data['isActive'] = this.isActive;
    data['uid'] = this.uid;
    data['modifiedAt'] = this.modifiedAt;
    data['modifiedBy'] = this.modifiedBy;
    data['roomQuestion'] = this.roomQuestion;
    data['description'] = this.description;
    data['roomType'] = this.roomType;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? createdAt;
  int? createdBy;
  int? status;
  bool? isActive;
  String? uid;
  String? modifiedAt;
  int? modifiedBy;
  String? userName;
  String? name;
  String? password;
  String? email;
  String? module;
  bool? isVerified;
  int? userOtp;
  String? otpExpiryTime;
  int? otpAttempt;
  String? mobileNo;

  User(
      {this.id,
      this.createdAt,
      this.createdBy,
      this.status,
      this.isActive,
      this.uid,
      this.modifiedAt,
      this.modifiedBy,
      this.userName,
      this.name,
      this.password,
      this.email,
      this.module,
      this.isVerified,
      this.userOtp,
      this.otpExpiryTime,
      this.otpAttempt,
      this.mobileNo});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    status = json['status'];
    isActive = json['isActive'];
    uid = json['uid'];
    modifiedAt = json['modifiedAt'];
    modifiedBy = json['modifiedBy'];
    userName = json['userName'];
    name = json['name'];
    password = json['password'];
    email = json['email'];
    module = json['module'];
    isVerified = json['isVerified'];
    userOtp = json['user_otp'];
    otpExpiryTime = json['otpExpiryTime'];
    otpAttempt = json['otpAttempt'];
    mobileNo = json['mobileNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    data['status'] = this.status;
    data['isActive'] = this.isActive;
    data['uid'] = this.uid;
    data['modifiedAt'] = this.modifiedAt;
    data['modifiedBy'] = this.modifiedBy;
    data['userName'] = this.userName;
    data['name'] = this.name;
    data['password'] = this.password;
    data['email'] = this.email;
    data['module'] = this.module;
    data['isVerified'] = this.isVerified;
    data['user_otp'] = this.userOtp;
    data['otpExpiryTime'] = this.otpExpiryTime;
    data['otpAttempt'] = this.otpAttempt;
    data['mobileNo'] = this.mobileNo;
    return data;
  }
}
