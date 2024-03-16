class StaeMessageModel {
  String? message;
  Object? object;
  bool? success;

  StaeMessageModel({this.message, this.object, this.success});

  StaeMessageModel.fromJson(Map<String, dynamic> json) {
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
  int? totalElements;
  int? totalPages;
  bool? last;
  int? size;
  int? number;
  Sort? sort;
  int? numberOfElements;
  bool? first;
  bool? empty;

  Object(
      {this.content,
      this.pageable,
      this.totalElements,
      this.totalPages,
      this.last,
      this.size,
      this.number,
      this.sort,
      this.numberOfElements,
      this.first,
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
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
    last = json['last'];
    size = json['size'];
    number = json['number'];
    sort = json['sort'] != null ? new Sort.fromJson(json['sort']) : null;
    numberOfElements = json['numberOfElements'];
    first = json['first'];
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
    data['totalElements'] = this.totalElements;
    data['totalPages'] = this.totalPages;
    data['last'] = this.last;
    data['size'] = this.size;
    data['number'] = this.number;
    if (this.sort != null) {
      data['sort'] = this.sort!.toJson();
    }
    data['numberOfElements'] = this.numberOfElements;
    data['first'] = this.first;
    data['empty'] = this.empty;
    return data;
  }
}

class Content {
  String? userFrom;
  String? userTo;
  String? userUid;
  String? userProfilePic;
  String? userChatInboxUid;
  String? userChatMessageUid;
  String? message;
  String? createdAt;
  String? messageType;
  bool? isStarred;
  bool? isForwarded;
  bool? isEdited;
  int? messageSeenStatus;

  Content(
      {this.userFrom,
      this.userTo,
      this.userUid,
      this.userProfilePic,
      this.userChatInboxUid,
      this.userChatMessageUid,
      this.message,
      this.createdAt,
      this.messageType,
      this.isStarred,
      this.isForwarded,
      this.isEdited,
      this.messageSeenStatus});

  Content.fromJson(Map<String, dynamic> json) {
    userFrom = json['userFrom'];
    userTo = json['userTo'];
    userUid = json['userUid'];
    userProfilePic = json['userProfilePic'];
    userChatInboxUid = json['userChatInboxUid'];
    userChatMessageUid = json['userChatMessageUid'];
    message = json['message'];
    createdAt = json['createdAt'];
    messageType = json['messageType'];
    isStarred = json['isStarred'];
    isForwarded = json['isForwarded'];
    isEdited = json['isEdited'];
    messageSeenStatus = json['messageSeenStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userFrom'] = this.userFrom;
    data['userTo'] = this.userTo;
    data['userUid'] = this.userUid;
    data['userProfilePic'] = this.userProfilePic;
    data['userChatInboxUid'] = this.userChatInboxUid;
    data['userChatMessageUid'] = this.userChatMessageUid;
    data['message'] = this.message;
    data['createdAt'] = this.createdAt;
    data['messageType'] = this.messageType;
    data['isStarred'] = this.isStarred;
    data['isForwarded'] = this.isForwarded;
    data['isEdited'] = this.isEdited;
    data['messageSeenStatus'] = this.messageSeenStatus;
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