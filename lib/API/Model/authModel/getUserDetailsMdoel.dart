class GetUserDataModel {
  String? message;
  Object? object;
  bool? success;

  GetUserDataModel({this.message, this.object, this.success});

  GetUserDataModel.fromJson(Map<String, dynamic> json) {
      print('jason-$json');
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
  String? userName;
  String? name;
  String? email;
  String? module;
  bool? isVerified;
  String? mobileNo;
  bool? isActive;
  String? uid;

  Object(
      {this.userName,
      this.name,
      this.email,
      this.module,
      this.isVerified,
      this.mobileNo,
      this.isActive,
      this.uid});

  Object.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    name = json['name'];
    email = json['email'];
    module = json['module'];
    isVerified = json['isVerified'];
    mobileNo = json['mobileNo'];
    isActive = json['isActive'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['name'] = this.name;
    data['email'] = this.email;
    data['module'] = this.module;
    data['isVerified'] = this.isVerified;
    data['mobileNo'] = this.mobileNo;
    data['isActive'] = this.isActive;
    data['uid'] = this.uid;
    return data;
  }
}
