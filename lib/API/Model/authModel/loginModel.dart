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
  String? profilePic;
  bool? active;
  bool? approved;
  bool? verified;

  Object(
      {this.jwt,
      this.uuid,
      this.module,
      this.signUpStep,
      this.name,
      this.mobileNo,
      this.profilePic,
      this.active,
      this.approved,
      this.verified});

  Object.fromJson(Map<String, dynamic> json) {
    jwt = json['jwt'];
    uuid = json['uuid'];
    module = json['module'];
    signUpStep = json['signUpStep'];
    name = json['name'];
    mobileNo = json['mobileNo'];
    profilePic = json['profilePic'];
    active = json['active'];
    approved = json['approved'];
    verified = json['verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jwt'] = this.jwt;
    data['uuid'] = this.uuid;
    data['module'] = this.module;
    data['signUpStep'] = this.signUpStep;
    data['name'] = this.name;
    data['mobileNo'] = this.mobileNo;
    data['profilePic'] = this.profilePic;
    data['active'] = this.active;
    data['approved'] = this.approved;
    data['verified'] = this.verified;
    return data;
  }
}






class LogInIsExistFromOnBoardingModel {
  String? message;
  Object1? object;
  bool? success;

  LogInIsExistFromOnBoardingModel({this.message, this.object, this.success});

  LogInIsExistFromOnBoardingModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    object =
        json['object'] != null ? new Object1.fromJson(json['object']) : null;
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

class Object1 {
  String? userName;
  String? name;
  String? email;
  String? module;
  String? mobileNo;
  String? password;

  Object1(
      {this.userName,
      this.name,
      this.email,
      this.module,
      this.mobileNo,
      this.password});

  Object1.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    name = json['name'];
    email = json['email'];
    module = json['module'];
    mobileNo = json['mobileNo'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['name'] = this.name;
    data['email'] = this.email;
    data['module'] = this.module;
    data['mobileNo'] = this.mobileNo;
    data['password'] = this.password;
    return data;
  }
}
