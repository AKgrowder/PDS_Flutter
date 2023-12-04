
class SearchUserForInbox {
  String? message;
  List<Object>? object;
  bool? success;

  SearchUserForInbox({this.message, this.object, this.success});

  SearchUserForInbox.fromJson(Map<String, dynamic> json) {
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
  String? userUid;
  String? userName;
  String? userProfilePic;

  Object({this.userUid, this.userName, this.userProfilePic});

  Object.fromJson(Map<String, dynamic> json) {
    userUid = json['userUid'];
    userName = json['userName'];
    userProfilePic = json['userProfilePic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userUid'] = this.userUid;
    data['userName'] = this.userName;
    data['userProfilePic'] = this.userProfilePic;
    return data;
  }
}
