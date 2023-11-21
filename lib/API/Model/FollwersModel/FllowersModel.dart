class FollowersClassModel {
  String? message;
  List<Object>? object;
  bool? success;

  FollowersClassModel({this.message, this.object, this.success});

  FollowersClassModel.fromJson(Map<String, dynamic> json) {
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
  String? followerUid;
  String? userUid;
  String? userName;
  String? name;
  String? userProfilePic;
  String? isFollow;
  

  Object(
      {this.followerUid,
      this.userUid,
      this.userName,
      this.name,
      this.userProfilePic,
      this.isFollow});

  Object.fromJson(Map<String, dynamic> json) {
    followerUid = json['followerUid'];
    userUid = json['userUid'];
    userName = json['userName'];
    name = json['name'];
    userProfilePic = json['userProfilePic'];
    isFollow = json['isFollow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['followerUid'] = this.followerUid;
    data['userUid'] = this.userUid;
    data['userName'] = this.userName;
    data['name'] = this.name;
    data['userProfilePic'] = this.userProfilePic;
    data['isFollow'] = this.isFollow;
    return data;
  }
}