class StoryViewListModel {
  String? message;
  List<Object>? object;
  bool? success;

  StoryViewListModel({this.message, this.object, this.success});

  StoryViewListModel.fromJson(Map<String, dynamic> json) {
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
  String? viewUid;
  String? profilePic;
  String? userUid;
  String? userName;
  String? viewedAt;
  String? isFollowing;

  Object(
      {this.viewUid,
      this.profilePic,
      this.userUid,
      this.userName,
      this.viewedAt,
      this.isFollowing});

  Object.fromJson(Map<String, dynamic> json) {
    viewUid = json['viewUid'];
    profilePic = json['profilePic'];
    userUid = json['userUid'];
    userName = json['userName'];
    viewedAt = json['viewedAt'];
    isFollowing = json['isFollowing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['viewUid'] = this.viewUid;
    data['profilePic'] = this.profilePic;
    data['userUid'] = this.userUid;
    data['userName'] = this.userName;
    data['viewedAt'] = this.viewedAt;
    data['isFollowing'] = this.isFollowing;
    return data;
  }
}
