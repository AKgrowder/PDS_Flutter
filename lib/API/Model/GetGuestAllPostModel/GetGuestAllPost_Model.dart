class GetGuestAllPostModel {
  String? message;
  Object? object;
  bool? success;

  GetGuestAllPostModel({this.message, this.object, this.success});

  GetGuestAllPostModel.fromJson(Map<String, dynamic> json) {
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
  String? postUserName;
  String? userProfilePic;
  String? postLink;
  String? translatedDescription;
  String? description;
  List<String>? postData;
  String? postDataType;
  String? postType;
  bool? isLiked;
  bool? isSaved;
  String? isFollowing;
  int? likedCount;
  int? commentCount;
  RepostOn? repostOn;
  int? repostCount;
  String? userAccountType;
  String? thumbnailImageUrl;
  // bool? isfalsegu;
  // bool? isfalsehin;
  // bool? isTrsnalteoption;

  Content({
    this.postUid,
    this.createdAt,
    this.userUid,
    this.postUserName,
    this.userProfilePic,
    this.postLink,
    this.translatedDescription,
    this.description,
    this.postData,
    this.postDataType,
    this.postType,
    this.isLiked,
    this.isSaved,
    this.isFollowing,
    this.likedCount,
    this.commentCount,
    this.repostOn,
    this.repostCount,
    this.userAccountType,
    this.thumbnailImageUrl,
    // this.isfalsegu,
    // this.isfalsehin,
    // this.isTrsnalteoption

  });

  Content.fromJson(Map<String, dynamic> json) {
    postUid = json['postUid'];
    createdAt = json['createdAt'];
    userUid = json['userUid'];
    postUserName = json['postUserName'];
    userProfilePic = json['userProfilePic'];
    translatedDescription = json['translatedDescription'];
    postLink = json['postLink'];
    description = json['description'];
    postData = json['postData'].cast<String>();
    postDataType = json['postDataType'];
    postType = json['postType'];
    isLiked = json['isLiked'];
    isSaved = json['isSaved'];
    isFollowing = json['isFollowing'];
    likedCount = json['likedCount'];
    commentCount = json['commentCount'];
    repostOn = json['repostOn'] != null
        ? new RepostOn.fromJson(json['repostOn'])
        : null;
    repostCount = json['repostCount'];
    userAccountType = json['userAccountType'];
    thumbnailImageUrl = json['thumbnailImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postUid'] = this.postUid;
    data['createdAt'] = this.createdAt;
    data['userUid'] = this.userUid;
    data['postUserName'] = this.postUserName;
    data['userProfilePic'] = this.userProfilePic;
    data['translatedDescription'] = this.translatedDescription;
    data['postLink'] = this.postLink;
    data['description'] = this.description;
    data['postData'] = this.postData;
    data['postDataType'] = this.postDataType;
    data['postType'] = this.postType;
    data['isLiked'] = this.isLiked;
    data['isSaved'] = this.isSaved;
    data['isFollowing'] = this.isFollowing;
    data['likedCount'] = this.likedCount;
    data['commentCount'] = this.commentCount;
    if (this.repostOn != null) {
      data['repostOn'] = this.repostOn!.toJson();
    }
    data['repostCount'] = this.repostCount;
    data['userAccountType'] = this.userAccountType;
    data['thumbnailImageUrl'] = this.thumbnailImageUrl;
    return data;
  }
}

class RepostOn {
  String? postUid;
  String? createdAt;
  String? userUid;
  String? postUserName;
  String? userProfilePic;
  String? postLink;
  String? description;
  List<String>? postData;
  String? postDataType;
  String? postType;
  bool? isLiked;
  bool? isSaved;
  String? isFollowing;
  int? likedCount;
  int? commentCount;
  Null? repostOn;
  int? repostCount;
  String? userAccountType;
  String? thumbnailImageUrl;

  RepostOn({
    this.postUid,
    this.createdAt,
    this.userUid,
    this.postUserName,
    this.userProfilePic,
    this.postLink,
    this.description,
    this.postData,
    this.postDataType,
    this.postType,
    this.isLiked,
    this.isSaved,
    this.isFollowing,
    this.likedCount,
    this.commentCount,
    this.repostOn,
    this.repostCount,
    this.userAccountType,
    this.thumbnailImageUrl,
  });

  RepostOn.fromJson(Map<String, dynamic> json) {
    postUid = json['postUid'];
    createdAt = json['createdAt'];
    userUid = json['userUid'];
    postUserName = json['postUserName'];
    userProfilePic = json['userProfilePic'];
    postLink = json['postLink'];
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
    repostOn = json['repostOn'];
    userAccountType = json['userAccountType'];
    thumbnailImageUrl = json['thumbnailImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postUid'] = this.postUid;
    data['createdAt'] = this.createdAt;
    data['userUid'] = this.userUid;
    data['postUserName'] = this.postUserName;
    data['userProfilePic'] = this.userProfilePic;
    data['postLink'] = this.postLink;
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
    data['userAccountType'] = this.userAccountType;
    data['thumbnailImageUrl'] = this.thumbnailImageUrl;
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
