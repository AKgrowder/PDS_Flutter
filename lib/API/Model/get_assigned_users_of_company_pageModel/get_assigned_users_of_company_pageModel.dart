class GetAssignedUsersOfCompanyPage {
  String? message;
  List<Object>? object;
  bool? success;

  GetAssignedUsersOfCompanyPage({this.message, this.object, this.success});

  GetAssignedUsersOfCompanyPage.fromJson(Map<String, dynamic> json) {
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
  String? userCompanyPageUid;
  String? userUid;
  String? userName;
  String? userProfilePic;

  Object(
      {this.userCompanyPageUid,
      this.userUid,
      this.userName,
      this.userProfilePic});

  Object.fromJson(Map<String, dynamic> json) {
    userCompanyPageUid = json['userCompanyPageUid'];
    userUid = json['userUid'];
    userName = json['userName'];
    userProfilePic = json['userProfilePic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userCompanyPageUid'] = this.userCompanyPageUid;
    data['userUid'] = this.userUid;
    data['userName'] = this.userName;
    data['userProfilePic'] = this.userProfilePic;
    return data;
  }
}