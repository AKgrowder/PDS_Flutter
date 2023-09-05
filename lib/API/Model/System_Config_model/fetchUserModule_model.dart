class FetchUserModulemodel {
  String? message;
  Object? object;
  bool? success;

  FetchUserModulemodel({this.message, this.object, this.success});

  FetchUserModulemodel.fromJson(Map<String, dynamic> json) {
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
  String? userProfilePic;
  String? userModule;

  Object({this.userProfilePic, this.userModule});

  Object.fromJson(Map<String, dynamic> json) {
    userProfilePic = json['userProfilePic'];
    userModule = json['userModule'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userProfilePic'] = this.userProfilePic;
    data['userModule'] = this.userModule;
    return data;
  }
}
