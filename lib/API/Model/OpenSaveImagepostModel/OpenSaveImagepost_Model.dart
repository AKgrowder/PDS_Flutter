class OpenSaveImagepostModel {
  String? message;
  Object? object;
  bool? success;

  OpenSaveImagepostModel({this.message, this.object, this.success});

  OpenSaveImagepostModel.fromJson(Map<String, dynamic> json) {
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
  int? repostCount;
  RepostOn? repostOn;
  String? thumbnailImageUrl;
  String? postLink;
  String? translatedDescription;
  bool? isTrsnalteoption;
  String? userAccountType;

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
      this.commentCount,
      this.repostCount,
      this.repostOn,
      this.thumbnailImageUrl,this.postLink,this.translatedDescription,this.isTrsnalteoption,this.userAccountType});

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
    repostCount = json['repostCount'];
    repostOn = json['repostOn'] != null
        ? new RepostOn.fromJson(json['repostOn'])
        : null;
    thumbnailImageUrl = json['thumbnailImageUrl'];
    postLink = json['postLink'];
    translatedDescription = json['translatedDescription'];
    isTrsnalteoption = json['isTrsnalteoption'];
    userAccountType = json['userAccountType'];
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
    data['repostCount'] = this.repostCount;
    if (this.repostOn != null) {
      data['repostOn'] = this.repostOn!.toJson();
    }
    data['thumbnailImageUrl'] = this.thumbnailImageUrl;
    data['postLink'] = this.postLink;
    data['translatedDescription'] = this.translatedDescription;
    data['isTrsnalteoption'] = this.isTrsnalteoption;
    data['userAccountType'] = this.userAccountType;
    return data;
  }
}

class RepostOn {
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
  int? repostCount;
  RepostOn? repostOn;
  String? thumbnailImageUrl;
  String? translatedDescription;
  bool? isTrsnalteoption;
  String? userAccountType;

  RepostOn({
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
    this.repostCount,
    this.repostOn,
    this.thumbnailImageUrl,
    this.translatedDescription,this.isTrsnalteoption,this.userAccountType
  });

  RepostOn.fromJson(Map<String, dynamic> json) {
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
    repostCount = json['repostCount'];
    repostOn = json['repostOn'] != null
        ? new RepostOn.fromJson(json['repostOn'])
        : null;
    thumbnailImageUrl = json['thumbnailImageUrl'];
    translatedDescription = json['translatedDescription'];
    isTrsnalteoption = json['isTrsnalteoption'];
    userAccountType = json['userAccountType'];
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
    data['repostCount'] = this.repostCount;
    data['repostOn'] = this.repostOn;
    data['thumbnailImageUrl'] = this.thumbnailImageUrl;
    data['translatedDescription'] = this.translatedDescription;
    data['isTrsnalteoption'] = this.isTrsnalteoption;
    data['userAccountType'] = this.userAccountType;
    return data;
  }
}
