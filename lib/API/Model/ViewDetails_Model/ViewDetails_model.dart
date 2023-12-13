class ViewDetailsModel {
  String? message;
  Object? object;
  bool? success;

  ViewDetailsModel({this.message, this.object, this.success});

  ViewDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String? userUuid;
  String? userName;
  String? userEmail;
  String? userMobile;
  String? profilePic;
  String? userId;
  Object(
      {this.userUuid,
      this.userName,
      this.userEmail,
      this.userMobile,
      this.profilePic,
      this.userId});

  Object.fromJson(Map<String, dynamic> json) {
    userUuid = json['userUuid'];
    userName = json['userName'];
    userEmail = json['userEmail'];
    userMobile = json['userMobile'];
    profilePic = json['profilePic'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userUuid'] = this.userUuid;
    data['userName'] = this.userName;
    data['userEmail'] = this.userEmail;
    data['userMobile'] = this.userMobile;
    data['profilePic'] = this.profilePic;
    return data;
  }
}
