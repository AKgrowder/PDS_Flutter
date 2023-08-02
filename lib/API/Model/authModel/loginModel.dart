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
  bool? active;
  bool? approved;
  bool? verified;

  Object(
      {this.jwt,
      this.uuid,
      this.module,
      this.active,
      this.approved,
      this.verified});

  Object.fromJson(Map<String, dynamic> json) {
    jwt = json['jwt'];
    uuid = json['uuid'];
    module = json['module'];
    active = json['active'];
    approved = json['approved'];
    verified = json['verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jwt'] = this.jwt;
    data['uuid'] = this.uuid;
    data['module'] = this.module;
    data['active'] = this.active;
    data['approved'] = this.approved;
    data['verified'] = this.verified;
    return data;
  }
}
