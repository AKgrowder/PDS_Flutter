class GetAppUserPostModel {
  String? message;
  Object? object;
  bool? success;

  GetAppUserPostModel({this.message, this.object, this.success});

  GetAppUserPostModel.fromJson(Map<String, dynamic> json) {
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
  List<Content>? content;
  Pageable? pageable;
  bool? last;
  int? totalPages;
  int? totalElements;
  int? size;
  int? number;
  Sort? sort;
  bool? first;
  int? numberOfElements;
  bool? empty;

  Object(
      {this.content,
      this.pageable,
      this.last,
      this.totalPages,
      this.totalElements,
      this.size,
      this.number,
      this.sort,
      this.first,
      this.numberOfElements,
      this.empty});

  Object.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <Content>[];
      json['content'].forEach((v) {
        content!.add(new Content.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
    last = json['last'];
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    size = json['size'];
    number = json['number'];
    sort = json['sort'] != null ? new Sort.fromJson(json['sort']) : null;
    first = json['first'];
    numberOfElements = json['numberOfElements'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content!.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable!.toJson();
    }
    data['last'] = this.last;
    data['totalPages'] = this.totalPages;
    data['totalElements'] = this.totalElements;
    data['size'] = this.size;
    data['number'] = this.number;
    if (this.sort != null) {
      data['sort'] = this.sort!.toJson();
    }
    data['first'] = this.first;
    data['numberOfElements'] = this.numberOfElements;
    data['empty'] = this.empty;
    return data;
  }
}

class Content {
  String? postUid;
  String? createdAt;
  String? userUid;
  String? userAccountType;
  String? postUserName;
  String? userProfilePic;
  String? postLink;
  String? description;
  String? translatedDescription;
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
  String? userCompanyPageType;
bool? isReports; 
  Content(
      {this.postUid,
      this.createdAt,
      this.userUid,
      this.userAccountType,
      this.postUserName,
      this.userProfilePic,
      this.postLink,
      this.description,
      this.translatedDescription,
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
      this.repostOn,
      this.userCompanyPageType,this.isReports});

  Content.fromJson(Map<String, dynamic> json) {
    postUid = json['postUid'];
    createdAt = json['createdAt'];
    userUid = json['userUid'];
    userAccountType = json['userAccountType'];
    postUserName = json['postUserName'];
    userProfilePic = json['userProfilePic'];
    postLink = json['postLink'];
    description = json['description'];
    translatedDescription = json['translatedDescription'];
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
    repostOn = json['repostOn'] != null
        ? new RepostOn.fromJson(json['repostOn'])
        : null;
    userCompanyPageType = json['userCompanyPageType'];
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
    data['translatedDescription'] = this.translatedDescription;
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
    if (this.repostOn != null) {
      data['repostOn'] = this.repostOn!.toJson();
    }
    data['userCompanyPageType'] = this.userCompanyPageType;
    return data;
  }
}

class RepostOn {
  String? postUid;
  String? createdAt;
  String? userUid;
  String? userAccountType;
  String? postUserName;
  String? userProfilePic;
  String? postLink;
  String? description;
  String? translatedDescription;
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
  String? repostOn;
  String? userCompanyPageType;

  RepostOn(
      {this.postUid,
      this.createdAt,
      this.userUid,
      this.userAccountType,
      this.postUserName,
      this.userProfilePic,
      this.postLink,
      this.description,
      this.translatedDescription,
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
      this.repostOn,
      this.userCompanyPageType});

  RepostOn.fromJson(Map<String, dynamic> json) {
    postUid = json['postUid'];
    createdAt = json['createdAt'];
    userUid = json['userUid'];
    userAccountType = json['userAccountType'];
    postUserName = json['postUserName'];
    userProfilePic = json['userProfilePic'];
    postLink = json['postLink'];
    description = json['description'];
    translatedDescription = json['translatedDescription'];
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
    userCompanyPageType = json['userCompanyPageType'];
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
    data['translatedDescription'] = this.translatedDescription;
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
    data['userCompanyPageType'] = this.userCompanyPageType;
    return data;
  }
}

class Pageable {
  Sort? sort;
  int? offset;
  int? pageNumber;
  int? pageSize;
  bool? paged;
  bool? unpaged;

  Pageable(
      {this.sort,
      this.offset,
      this.pageNumber,
      this.pageSize,
      this.paged,
      this.unpaged});

  Pageable.fromJson(Map<String, dynamic> json) {
    sort = json['sort'] != null ? new Sort.fromJson(json['sort']) : null;
    offset = json['offset'];
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    paged = json['paged'];
    unpaged = json['unpaged'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sort != null) {
      data['sort'] = this.sort!.toJson();
    }
    data['offset'] = this.offset;
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    data['paged'] = this.paged;
    data['unpaged'] = this.unpaged;
    return data;
  }
}

class Sort {
  bool? sorted;
  bool? unsorted;
  bool? empty;

  Sort({this.sorted, this.unsorted, this.empty});

  Sort.fromJson(Map<String, dynamic> json) {
    sorted = json['sorted'];
    unsorted = json['unsorted'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sorted'] = this.sorted;
    data['unsorted'] = this.unsorted;
    data['empty'] = this.empty;
    return data;
  }
}
