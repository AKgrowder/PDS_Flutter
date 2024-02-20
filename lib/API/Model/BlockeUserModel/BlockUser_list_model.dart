class BlockUserListModel {
  String? message;
  List<Object>? object;
  bool? success;

  BlockUserListModel({this.message, this.object, this.success});

  BlockUserListModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? userProfilePic;
  String? userUid;
  String? blockedAt;

  Object(
      {this.userName,
      this.name,
      this.userProfilePic,
      this.userUid,
      this.blockedAt});

  Object.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    name = json['name'];
    userProfilePic = json['userProfilePic'];
    userUid = json['userUid'];
    blockedAt = json['blockedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['name'] = this.name;
    data['userProfilePic'] = this.userProfilePic;
    data['userUid'] = this.userUid;
    data['blockedAt'] = this.blockedAt;
    return data;
  }
}
