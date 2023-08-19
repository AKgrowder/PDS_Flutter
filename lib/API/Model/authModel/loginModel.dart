class LoginModel {
  String? message;
  Object? object;
  bool? success;

  LoginModel({this.message, this.object, this.success});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
  String? jwt;
  String? uuid;
  String? module;
  bool? signUpStep;
  String? name;
  String? mobileNo;
  bool? active;
  bool? verified;
  bool? approved;

  Object(
      {this.jwt,
      this.uuid,
      this.module,
      this.signUpStep,
      this.name,
      this.mobileNo,
      this.active,
      this.verified,
      this.approved});

  Object.fromJson(Map<String, dynamic> json) {
    jwt = json['jwt'];
    uuid = json['uuid'];
    module = json['module'];
    signUpStep = json['signUpStep'];
    name = json['name'];
    mobileNo = json['mobileNo'];
    active = json['active'];
    verified = json['verified'];
    approved = json['approved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jwt'] = this.jwt;
    data['uuid'] = this.uuid;
    data['module'] = this.module;
    data['signUpStep'] = this.signUpStep;
    data['name'] = this.name;
    data['mobileNo'] = this.mobileNo;
    data['active'] = this.active;
    data['verified'] = this.verified;
    data['approved'] = this.approved;
    return data;
  }
}