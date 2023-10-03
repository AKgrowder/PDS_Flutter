// class ComentApiModel {
//   String? message;
//   Object? object;
//   bool? success;

//   ComentApiModel({this.message, this.object, this.success});

//   ComentApiModel.fromJson(Map<String, dynamic> json) {
//     print('jsone Check data-$json');
//     message = json['message'];
//     object =
//         json['object'] != null ? new Object.fromJson(json['object']) : null;
//     success = json['success'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['message'] = this.message;
//     if (this.object != null) {
//       data['object'] = this.object!.toJson();
//     }
//     data['success'] = this.success;
//     return data;
//   }
// }

// class Object {
//   String? roomUid;
//   String? roomQuestion;
//   MessageOutputList? messageOutputList;

//   Object({this.roomUid, this.roomQuestion, this.messageOutputList});

//   Object.fromJson(Map<String, dynamic> json) {
//     print('OBJECT`$json');

//     roomUid = json['roomUid'];
//     roomQuestion = json['roomQuestion'];
//     messageOutputList = json['messageOutputList'] != null
//         ? new MessageOutputList.fromJson(json['messageOutputList'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['roomUid'] = this.roomUid;
//     data['roomQuestion'] = this.roomQuestion;
//     if (this.messageOutputList != null) {
//       data['messageOutputList'] = this.messageOutputList!.toJson();
//     }
//     return data;
//   }
// }

// class MessageOutputList {
//   List<Content>? content;
//   Pageable? pageable;
//   int? totalPages;
//   int? totalElements;
//   bool? last;
//   int? size;
//   int? number;
//   Sort? sort;
//   int? numberOfElements;
//   bool? first;
//   bool? empty;

//   MessageOutputList(
//       {this.content,
//       this.pageable,
//       this.totalPages,
//       this.totalElements,
//       this.last,
//       this.size,
//       this.number,
//       this.sort,
//       this.numberOfElements,
//       this.first,
//       this.empty});

//   MessageOutputList.fromJson(Map<String, dynamic> json) {
//     if (json['content'] != null) {
//       content = <Content>[];
//       json['content'].forEach((v) {
//         content!.add(new Content.fromJson(v));
//       });
//     }
//     pageable = json['pageable'] != null
//         ? new Pageable.fromJson(json['pageable'])
//         : null;
//     totalPages = json['totalPages'];
//     totalElements = json['totalElements'];
//     last = json['last'];
//     size = json['size'];
//     number = json['number'];
//     sort = json['sort'] != null ? new Sort.fromJson(json['sort']) : null;
//     numberOfElements = json['numberOfElements'];
//     first = json['first'];
//     empty = json['empty'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.content != null) {
//       data['content'] = this.content!.map((v) => v.toJson()).toList();
//     }
//     if (this.pageable != null) {
//       data['pageable'] = this.pageable!.toJson();
//     }
//     data['totalPages'] = this.totalPages;
//     data['totalElements'] = this.totalElements;
//     data['last'] = this.last;
//     data['size'] = this.size;
//     data['number'] = this.number;
//     if (this.sort != null) {
//       data['sort'] = this.sort!.toJson();
//     }
//     data['numberOfElements'] = this.numberOfElements;
//     data['first'] = this.first;
//     data['empty'] = this.empty;
//     return data;
//   }
// }

// class Content {
//   String? uid;
//   String? message;
//   String? messageType;
//   String? userName;
//   Null? messageCount;

//   Content(
//       {this.uid,
//       this.message,
//       this.messageType,
//       this.userName,
//       this.messageCount});

//   Content.fromJson(Map<String, dynamic> json) {
//     uid = json['uid'];
//     message = json['message'];
//     messageType = json['messageType'];
//     userName = json['userName'];
//     messageCount = json['messageCount'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['uid'] = this.uid;
//     data['message'] = this.message;
//     data['messageType'] = this.messageType;
//     data['userName'] = this.userName;
//     data['messageCount'] = this.messageCount;
//     return data;
//   }
// }

// class Pageable {
//   Sort? sort;
//   int? offset;
//   int? pageNumber;
//   int? pageSize;
//   bool? paged;
//   bool? unpaged;

//   Pageable(
//       {this.sort,
//       this.offset,
//       this.pageNumber,
//       this.pageSize,
//       this.paged,
//       this.unpaged});

//   Pageable.fromJson(Map<String, dynamic> json) {
//     sort = json['sort'] != null ? new Sort.fromJson(json['sort']) : null;
//     offset = json['offset'];
//     pageNumber = json['pageNumber'];
//     pageSize = json['pageSize'];
//     paged = json['paged'];
//     unpaged = json['unpaged'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.sort != null) {
//       data['sort'] = this.sort!.toJson();
//     }
//     data['offset'] = this.offset;
//     data['pageNumber'] = this.pageNumber;
//     data['pageSize'] = this.pageSize;
//     data['paged'] = this.paged;
//     data['unpaged'] = this.unpaged;
//     return data;
//   }
// }

// class Sort {
//   bool? empty;
//   bool? sorted;
//   bool? unsorted;

//   Sort({this.empty, this.sorted, this.unsorted});

//   Sort.fromJson(Map<String, dynamic> json) {
//     empty = json['empty'];
//     sorted = json['sorted'];
//     unsorted = json['unsorted'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['empty'] = this.empty;
//     data['sorted'] = this.sorted;
//     data['unsorted'] = this.unsorted;
//     return data;
//   }
// }


class ComentApiModel {
  String? message;
  Object? object;
  bool? success;

  ComentApiModel({this.message, this.object, this.success});

  ComentApiModel.fromJson(Map<String, dynamic> json) {
  
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
  String? roomUid;
  String? roomQuestion;
  String? ownerUserName;
  String? ownerUserUid;
  String? createdAt;
  MessageOutputList? messageOutputList;

  Object(
      {this.roomUid,
      this.roomQuestion,
      this.ownerUserName,
      this.ownerUserUid,
      this.createdAt,
      this.messageOutputList});

  Object.fromJson(Map<String, dynamic> json) {
    roomUid = json['roomUid'];
    roomQuestion = json['roomQuestion'];
    ownerUserName = json['ownerUserName'];
    ownerUserUid = json['ownerUserUid'];
    createdAt = json['createdAt'];
    messageOutputList = json['messageOutputList'] != null
        ? new MessageOutputList.fromJson(json['messageOutputList'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roomUid'] = this.roomUid;
    data['roomQuestion'] = this.roomQuestion;
    data['ownerUserName'] = this.ownerUserName;
    data['ownerUserUid'] = this.ownerUserUid;
    data['createdAt'] = this.createdAt;
    if (this.messageOutputList != null) {
      data['messageOutputList'] = this.messageOutputList!.toJson();
    }
    return data;
  }
}

class MessageOutputList {
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

  MessageOutputList(
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

  MessageOutputList.fromJson(Map<String, dynamic> json) {
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
  String? uid;
  String? message;
  String? messageType;
  String? userName;
  String? messageCount;
  String? userCode;
  String? userProfilePic;
  String? createdAt;
  bool? isDeleted;

  Content(
      {this.uid,
      this.message,
      this.messageType,
      this.userName,
      this.messageCount,
      this.userCode,
      this.userProfilePic,
      this.createdAt,
      this.isDeleted});

  Content.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    message = json['message'];
    messageType = json['messageType'];
    userName = json['userName'];
    messageCount = json['messageCount'];
    userCode = json['userCode'];
    userProfilePic = json['userProfilePic'];
    createdAt = json['createdAt'];
    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['message'] = this.message;
    data['messageType'] = this.messageType;
    data['userName'] = this.userName;
    data['messageCount'] = this.messageCount;
    data['userCode'] = this.userCode;
    data['userProfilePic'] = this.userProfilePic;
    data['createdAt'] = this.createdAt;
    data['isDeleted'] = this.isDeleted;
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
