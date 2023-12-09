/* 
class GetAllPrivateRoomModel {
  String? message;
  List<Object>? object;
  bool? success;

  GetAllPrivateRoomModel({this.message, this.object, this.success});

  GetAllPrivateRoomModel.fromJson(Map<String, dynamic> json) {
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
  String? uid;
  String? roomQuestion;
  String? roomType;
  String? createdDate;
  String? description;
  String? createdBy;
  String? roomLink;
  int? totalPage;
  ExpertUserProfile? expertUserProfile;
  List<UsersList>? usersList;

  Object(
      {this.uid,
      this.roomQuestion,
      this.roomType,
      this.createdDate,
      this.description,
      this.expertUserProfile,
      this.totalPage,
      this.roomLink,
      this.usersList});

  Object.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    roomQuestion = json['roomQuestion'];
    roomType = json['roomType'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    description = json['description'];
    totalPage = json["totalPage"];
    roomLink = json['roomLink'];
    expertUserProfile = json['expertUserProfile'] != null
        ? new ExpertUserProfile.fromJson(json['expertUserProfile'])
        : null;
    if (json['usersList'] != null) {
      usersList = <UsersList>[];
      json['usersList'].forEach((v) {
        usersList!.add(new UsersList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['roomQuestion'] = this.roomQuestion;
    data['roomType'] = this.roomType;
    data['createdDate'] = this.createdDate;
    data['description'] = this.description;
    data["totalPage"] = this.totalPage;
    data['roomLink'] = this.roomLink;
    if (this.expertUserProfile != null) {
      data['expertUserProfile'] = this.expertUserProfile!.toJson();
    }
    if (this.usersList != null) {
      data['usersList'] = this.usersList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExpertUserProfile {
  String? uuid;
  String? userName;
  String? name;
  bool? isExpert;
  String? userProfilePic;

  ExpertUserProfile(
      {this.uuid,
      this.userName,
      this.name,
      this.isExpert,
      this.userProfilePic});

  ExpertUserProfile.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    userName = json['userName'];
    name = json['name'];
    isExpert = json['isExpert'];
    userProfilePic = json['userProfilePic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['userName'] = this.userName;
    data['name'] = this.name;
    data['isExpert'] = this.isExpert;
    data['userProfilePic'] = this.userProfilePic;
    return data;
  }
}

class UsersList {
  String? uuid;
  String? userName;
  String? name;
  bool? isExpert;
  String? userProfilePic;

  UsersList(
      {this.uuid,
      this.userName,
      this.name,
      this.isExpert,
      this.userProfilePic});

  UsersList.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    userName = json['userName'];
    name = json['name'];
    isExpert = json['isExpert'];
    userProfilePic = json['userProfilePic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['userName'] = this.userName;
    data['name'] = this.name;
    data['isExpert'] = this.isExpert;
    data['userProfilePic'] = this.userProfilePic;
    return data;
  }
}
 */

class GetAllPrivateRoomModel {
  String? message;
  List<Object>? object;
  bool? success;

  GetAllPrivateRoomModel({this.message, this.object, this.success});

  GetAllPrivateRoomModel.fromJson(Map<String, dynamic> json) {
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
  String? uid;
  String? roomQuestion;
  String? createdBy;
  String? roomType;
  String? createdDate;
  String? description;
  ExpertUserProfile? expertUserProfile;
  List<UsersList>? usersList;
  int? totalPage;
  bool? isExpertPresent;
  String? roomLink;
  int? adminCount;
  bool? isLoginUserAdmin;

  Object(
      {this.uid,
      this.roomQuestion,
      this.createdBy,
      this.roomType,
      this.createdDate,
      this.description,
      this.expertUserProfile,
      this.usersList,
      this.totalPage,
      this.isExpertPresent,
      this.roomLink,
      this.adminCount,
      this.isLoginUserAdmin});

  Object.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    roomQuestion = json['roomQuestion'];
    createdBy = json['createdBy'];
    roomType = json['roomType'];
    createdDate = json['createdDate'];
    description = json['description'];
    expertUserProfile = json['expertUserProfile'] != null
        ? new ExpertUserProfile.fromJson(json['expertUserProfile'])
        : null;
    if (json['usersList'] != null) {
      usersList = <UsersList>[];
      json['usersList'].forEach((v) {
        usersList!.add(new UsersList.fromJson(v));
      });
    }
    totalPage = json['totalPage'];
    isExpertPresent = json['isExpertPresent'];
    roomLink = json['roomLink'];
    adminCount = json['adminCount'];
    isLoginUserAdmin = json['isLoginUserAdmin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['roomQuestion'] = this.roomQuestion;
    data['createdBy'] = this.createdBy;
    data['roomType'] = this.roomType;
    data['createdDate'] = this.createdDate;
    data['description'] = this.description;
    if (this.expertUserProfile != null) {
      data['expertUserProfile'] = this.expertUserProfile!.toJson();
    }
    if (this.usersList != null) {
      data['usersList'] = this.usersList!.map((v) => v.toJson()).toList();
    }
    data['totalPage'] = this.totalPage;
    data['isExpertPresent'] = this.isExpertPresent;
    data['roomLink'] = this.roomLink;
    data['adminCount'] = this.adminCount;
    data['isLoginUserAdmin'] = this.isLoginUserAdmin;
    return data;
  }
}

class ExpertUserProfile {
  String? uuid;
  String? userName;
  String? name;
  bool? isExpert;
  String? userProfilePic;
  String? approvalStatus;

  ExpertUserProfile({
    this.uuid,
    this.userName,
    this.name,
    this.isExpert,
    this.userProfilePic,
    this.approvalStatus,
  });

  ExpertUserProfile.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    userName = json['userName'];
    name = json['name'];
    isExpert = json['isExpert'];
    userProfilePic = json['userProfilePic'];
    approvalStatus = json['approvalStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['userName'] = this.userName;
    data['name'] = this.name;
    data['isExpert'] = this.isExpert;
    data['userProfilePic'] = this.userProfilePic;
    data['approvalStatus'] = this.approvalStatus;
    return data;
  }
}

class UsersList {
  String? uuid;
  String? userName;
  String? name;
  bool? isExpert;
  String? userProfilePic;

  UsersList(
      {this.uuid,
      this.userName,
      this.name,
      this.isExpert,
      this.userProfilePic});

  UsersList.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    userName = json['userName'];
    name = json['name'];
    isExpert = json['isExpert'];
    userProfilePic = json['userProfilePic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['userName'] = this.userName;
    data['name'] = this.name;
    data['isExpert'] = this.isExpert;
    data['userProfilePic'] = this.userProfilePic;
    return data;
  }
}
