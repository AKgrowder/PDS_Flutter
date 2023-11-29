class FatchAllMembersModel {
  String? message;
  List<Object>? object;
  bool? success;

  FatchAllMembersModel({this.message, this.object, this.success});

  FatchAllMembersModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['object'] != null) {
      object = <Object>[];
      json['object'].forEach((v) {
        object!.add(new Object.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.object != null) {
      data['object'] = this.object!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    return data;
  }
}

class Object {
  String? userName;
  String? fullName;
  String? userProfilePic;
  String? userUuid;
  bool? isExpert;

  Object({this.userName, this.fullName, this.userProfilePic, this.isExpert});

  Object.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    fullName = json['fullName'];
    userProfilePic = json['userProfilePic'];
    userUuid = json['userUuid'];
    isExpert = json['isExpert'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['fullName'] = this.fullName;
    data['userProfilePic'] = this.userProfilePic;
    data['userUuid'] = this.userUuid;
    data['isExpert'] = this.isExpert;
    return data;
  }
}
