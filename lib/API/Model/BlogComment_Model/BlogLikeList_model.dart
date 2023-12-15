class BlogLikeListModel {
  String? message;
  List<Object>? object;
  bool? success;

  BlogLikeListModel({this.message, this.object, this.success});

  BlogLikeListModel.fromJson(Map<String, dynamic> json) {
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
  String? likeUid;
  String? profilePic;
  String? userUid;
  String? userName;
  String? likedAt;
  String? isFollowing;
  bool? active;

  Object(
      {this.likeUid,
      this.profilePic,
      this.userUid,
      this.userName,
      this.likedAt,
      this.isFollowing,
      this.active});

  Object.fromJson(Map<String, dynamic> json) {
    likeUid = json['likeUid'];
    profilePic = json['profilePic'];
    userUid = json['userUid'];
    userName = json['userName'];
    likedAt = json['likedAt'];
    isFollowing = json['isFollowing'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['likeUid'] = this.likeUid;
    data['profilePic'] = this.profilePic;
    data['userUid'] = this.userUid;
    data['userName'] = this.userName;
    data['likedAt'] = this.likedAt;
    data['isFollowing'] = this.isFollowing;
    data['active'] = this.active;
    return data;
  }
}
