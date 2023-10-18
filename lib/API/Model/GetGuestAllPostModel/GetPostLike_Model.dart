class GetPostLikeModel {
  String? message;
  List<Object>? object;
  bool? success;
  GetPostLikeModel({this.message, this.object, this.success});
  GetPostLikeModel.fromJson(Map<String, dynamic> json) {
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
  String? likeUid;
  String? profilePic;
  String? userName;
  String? likedAt;
  bool? isFollowing;

  Object(
      {this.userUid,
      this.likeUid,
      this.profilePic,
      this.userName,
      this.likedAt,
      this.isFollowing});

  Object.fromJson(Map<String, dynamic> json) {
    likeUid = json['likeUid'];
    profilePic = json['profilePic'];
    userName = json['userName'];
    likedAt = json['likedAt'];
    isFollowing = json['isFollowing'];
    userUid = json['userUid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['likeUid'] = this.likeUid;
    data['profilePic'] = this.profilePic;
    data['userName'] = this.userName;
    data['likedAt'] = this.likedAt;
    data['isFollowing'] = this.isFollowing;
    return data;
  }
}
