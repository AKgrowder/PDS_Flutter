class HashtagViewDataModel {
  String? message;
  Object? object;
  bool? success;

  HashtagViewDataModel({this.message, this.object, this.success});

  HashtagViewDataModel.fromJson(Map<String, dynamic> json) {
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
  String? hashtagName;
  List<Posts>? posts;

  Object({this.hashtagName, this.posts});

  Object.fromJson(Map<String, dynamic> json) {
    hashtagName = json['hashtagName'];
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts!.add(new Posts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hashtagName'] = this.hashtagName;
    if (this.posts != null) {
      data['posts'] = this.posts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Posts {
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
  String? isFollowing;
  int? likedCount;
  int? commentCount;
  String? thumbnailImageUrl;
  String? postLink;

  Posts({
    this.postUid,
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
    this.commentCount,
    this.thumbnailImageUrl,
    this.postLink,
  });

  Posts.fromJson(Map<String, dynamic> json) {
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
    thumbnailImageUrl = json['thumbnailImageUrl'];
    postLink = json['postLink'];
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
    data['thumbnailImageUrl'] = this.thumbnailImageUrl;
    data['postLink'] = this.postLink;
    return data;
  }
}
