class GetSavePostModel {
  String? message;
  List<Object>? object;
  bool? success;

  GetSavePostModel({this.message, this.object, this.success});

  GetSavePostModel.fromJson(Map<String, dynamic> json) {
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
  String? postUid;
  String? createdAt;
  String? userUid;
  String? postUserName;
  String? userProfilePic;
  String? description;
  List<String>? postData;
  String? postDataType;
  String? postType;
  bool? isLiked;
  bool? isSaved;
  bool? isFollowing;
  int? likedCount;
  int? commentCount;

  Object(
      {this.postUid,
      this.createdAt,
      this.userUid,
      this.postUserName,
      this.userProfilePic,
      this.description,
      this.postData,
      this.postDataType,
      this.postType,
      this.isLiked,
      this.isSaved,
      this.isFollowing,
      this.likedCount,
      this.commentCount});

  Object.fromJson(Map<String, dynamic> json) {
    postUid = json['postUid'];
    createdAt = json['createdAt'];
    userUid = json['userUid'];
    postUserName = json['postUserName'];
    userProfilePic = json['userProfilePic'];
    description = json['description'];
    postData = json['postData'].cast<String>();
    postDataType = json['postDataType'];
    postType = json['postType'];
    isLiked = json['isLiked'];
    isSaved = json['isSaved'];
    isFollowing = json['isFollowing'];
    likedCount = json['likedCount'];
    commentCount = json['commentCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postUid'] = this.postUid;
    data['createdAt'] = this.createdAt;
    data['userUid'] = this.userUid;
    data['postUserName'] = this.postUserName;
    data['userProfilePic'] = this.userProfilePic;
    data['description'] = this.description;
    data['postData'] = this.postData;
    data['postDataType'] = this.postDataType;
    data['postType'] = this.postType;
    data['isLiked'] = this.isLiked;
    data['isSaved'] = this.isSaved;
    data['isFollowing'] = this.isFollowing;
    data['likedCount'] = this.likedCount;
    data['commentCount'] = this.commentCount;
    return data;
  }
}
