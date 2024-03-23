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
  Null? userAccountType;
  String? postUserName;
  String? userProfilePic;
  Null? postLink;
  String? description;
  List<String>? postData;
  String? thumbnailImageUrl;
  String? postDataType;
  String? postType;
  bool? isLiked;
  bool? isSaved;
  String? isFollowing;
  int? likedCount;
  int? commentCount;
  int? repostCount;
  RepostOn? repostOn;
  bool? isTrsnalteoption;
  String? translatedDescription;

  Object(
      {this.postUid,
      this.createdAt,
      this.userUid,
      this.userAccountType,
      this.postUserName,
      this.userProfilePic,
      this.postLink,
      this.description,
      this.postData,
      this.thumbnailImageUrl,
      this.postDataType,
      this.postType,
      this.isLiked,
      this.isSaved,
      this.isFollowing,
      this.likedCount,
      this.commentCount,
      this.repostCount,
      this.isTrsnalteoption,
      this.translatedDescription,
      this.repostOn});

  Object.fromJson(Map<String, dynamic> json) {
    postUid = json['postUid'];
    createdAt = json['createdAt'];
    userUid = json['userUid'];
    userAccountType = json['userAccountType'];
    postUserName = json['postUserName'];
    userProfilePic = json['userProfilePic'];
    postLink = json['postLink'];
    description = json['description'];
    postData = json['postData'].cast<String>();
    thumbnailImageUrl = json['thumbnailImageUrl'];
    postDataType = json['postDataType'];
    postType = json['postType'];
    isLiked = json['isLiked'];
    isSaved = json['isSaved'];
    isFollowing = json['isFollowing'];
    likedCount = json['likedCount'];
    commentCount = json['commentCount'];
    repostCount = json['repostCount'];
    isTrsnalteoption = json['isTrsnalteoption'];
    translatedDescription = json['translatedDescription'];
    repostOn = json['repostOn'] != null
        ? new RepostOn.fromJson(json['repostOn'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postUid'] = this.postUid;
    data['createdAt'] = this.createdAt;
    data['userUid'] = this.userUid;
    data['userAccountType'] = this.userAccountType;
    data['postUserName'] = this.postUserName;
    data['userProfilePic'] = this.userProfilePic;
    data['postLink'] = this.postLink;
    data['description'] = this.description;
    data['postData'] = this.postData;
    data['thumbnailImageUrl'] = this.thumbnailImageUrl;
    data['postDataType'] = this.postDataType;
    data['postType'] = this.postType;
    data['isLiked'] = this.isLiked;
    data['isSaved'] = this.isSaved;
    data['isFollowing'] = this.isFollowing;
    data['likedCount'] = this.likedCount;
    data['commentCount'] = this.commentCount;
    data['repostCount'] = this.repostCount;
    data['isTrsnalteoption'] = this.isTrsnalteoption;
    data['translatedDescription'] = this.translatedDescription;
    if (this.repostOn != null) {
      data['repostOn'] = this.repostOn!.toJson();
    }
    return data;
  }
}

class RepostOn {
  String? postUid;
  String? createdAt;
  String? userUid;
  Null? userAccountType;
  String? postUserName;
  String? userProfilePic;
  Null? postLink;
  String? description;
  List<String>? postData;
  Null? thumbnailImageUrl;
  String? postDataType;
  String? postType;
  bool? isLiked;
  bool? isSaved;
  String? isFollowing;
  int? likedCount;
  int? commentCount;
  int? repostCount;
  Null? repostOn;

  RepostOn(
      {this.postUid,
      this.createdAt,
      this.userUid,
      this.userAccountType,
      this.postUserName,
      this.userProfilePic,
      this.postLink,
      this.description,
      this.postData,
      this.thumbnailImageUrl,
      this.postDataType,
      this.postType,
      this.isLiked,
      this.isSaved,
      this.isFollowing,
      this.likedCount,
      this.commentCount,
      this.repostCount,
      this.repostOn});

  RepostOn.fromJson(Map<String, dynamic> json) {
    postUid = json['postUid'];
    createdAt = json['createdAt'];
    userUid = json['userUid'];
    userAccountType = json['userAccountType'];
    postUserName = json['postUserName'];
    userProfilePic = json['userProfilePic'];
    postLink = json['postLink'];
    description = json['description'];
    postData = json['postData'].cast<String>();
    thumbnailImageUrl = json['thumbnailImageUrl'];
    postDataType = json['postDataType'];
    postType = json['postType'];
    isLiked = json['isLiked'];
    isSaved = json['isSaved'];
    isFollowing = json['isFollowing'];
    likedCount = json['likedCount'];
    commentCount = json['commentCount'];
    repostCount = json['repostCount'];
    repostOn = json['repostOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postUid'] = this.postUid;
    data['createdAt'] = this.createdAt;
    data['userUid'] = this.userUid;
    data['userAccountType'] = this.userAccountType;
    data['postUserName'] = this.postUserName;
    data['userProfilePic'] = this.userProfilePic;
    data['postLink'] = this.postLink;
    data['description'] = this.description;
    data['postData'] = this.postData;
    data['thumbnailImageUrl'] = this.thumbnailImageUrl;
    data['postDataType'] = this.postDataType;
    data['postType'] = this.postType;
    data['isLiked'] = this.isLiked;
    data['isSaved'] = this.isSaved;
    data['isFollowing'] = this.isFollowing;
    data['likedCount'] = this.likedCount;
    data['commentCount'] = this.commentCount;
    data['repostCount'] = this.repostCount;
    data['repostOn'] = this.repostOn;
    return data;
  }
}
