/* class FatchAllMembersModel {
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
  String? userUuid;
  String? email;
  String? userName;
  String? fullName;
  String? userProfilePic;
  bool? isExpert;
  bool? isActive;

  Object(
      {this.userUuid,
      this.email,
      this.userName,
      this.fullName,
      this.userProfilePic,
      this.isExpert,
      this.isActive});

  Object.fromJson(Map<String, dynamic> json) {
    userUuid = json['userUuid'];
    email = json['email'];
    userName = json['userName'];
    fullName = json['fullName'];
    userProfilePic = json['userProfilePic'];
    isExpert = json['isExpert'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userUuid'] = this.userUuid;
    data['email'] = this.email;
    data['userName'] = this.userName;
    data['fullName'] = this.fullName;
    data['userProfilePic'] = this.userProfilePic;
    data['isExpert'] = this.isExpert;
    data['isActive'] = this.isActive;
    return data;
  }
}
 */



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
  String? userUuid;
  String? email;
  String? userName;
  String? fullName;
  String? userProfilePic;
  bool? isExpert;
  bool? isActive;
  bool? isAdmin;

  Object(
      {this.userUuid,
      this.email,
      this.userName,
      this.fullName,
      this.userProfilePic,
      this.isExpert,
      this.isActive,
      this.isAdmin});

  Object.fromJson(Map<String, dynamic> json) {
    userUuid = json['userUuid'];
    email = json['email'];
    userName = json['userName'];
    fullName = json['fullName'];
    userProfilePic = json['userProfilePic'];
    isExpert = json['isExpert'];
    isActive = json['isActive'];
    isAdmin = json['isAdmin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userUuid'] = this.userUuid;
    data['email'] = this.email;
    data['userName'] = this.userName;
    data['fullName'] = this.fullName;
    data['userProfilePic'] = this.userProfilePic;
    data['isExpert'] = this.isExpert;
    data['isActive'] = this.isActive;
    data['isAdmin'] = this.isAdmin;
    return data;
  }
}
