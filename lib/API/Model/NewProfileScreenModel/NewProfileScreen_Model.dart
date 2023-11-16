import 'dart:developer';

class NewProfileScreen_Model {
  String? message;
  Object? object;
  bool? success;

  NewProfileScreen_Model({this.message, this.object, this.success});

  NewProfileScreen_Model.fromJson(Map<String, dynamic> json) {
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
  String? isApproved;
  String? userDocument;
  String? companyName;
  String? jobProfile;
  double? fees;
  String? workingHours;
  String? rejectionReason;
  String? userName;
  String? name;
  String? email;
  String? module;
  String? approvalStatus;
  String? mobileNo;
  String? userUid;
  String? profileUid;
  String? userProfilePic;
  String? userBackgroundPic;
  List<IndustryTypes>? industryTypes;
  List<Expertise>? expertise;
  bool? isEmailVerified;
  String? aboutMe;
  String? isFollowing;
  int? followersCount;
  int? followingCount;
  int? postCount;

  Object(
      {this.isApproved,
      this.userDocument,
      this.companyName,
      this.jobProfile,
      this.fees,
      this.workingHours,
      this.rejectionReason,
      this.userName,
      this.name,
      this.email,
      this.module,
      this.approvalStatus,
      this.mobileNo,
      this.userUid,
      this.profileUid,
      this.userProfilePic,
      this.userBackgroundPic,
      this.industryTypes,
      this.expertise,
      this.isEmailVerified,
      this.aboutMe,
      this.isFollowing,
      this.followersCount,
      this.followingCount,
      this.postCount});

  Object.fromJson(Map<String, dynamic> json) {
    log("gdfhgfhgdfbh-$json");
    isApproved = json['isApproved'];
    userDocument = json['userDocument'];
    companyName = json['companyName'];
    jobProfile = json['jobProfile'];
    fees = json['fees'];
    workingHours = json['workingHours'];
    rejectionReason = json['rejectionReason'];
    userName = json['userName'];
    name = json['name'];
    email = json['email'];
    module = json['module'];
    approvalStatus = json['approvalStatus'];
    mobileNo = json['mobileNo'];
    userUid = json['userUid'];
    profileUid = json['profileUid'];
    userProfilePic = json['userProfilePic'];
    userBackgroundPic = json['userBackgroundPic'];
    if (json['industryTypes'] != null) {
      industryTypes = <IndustryTypes>[];
      json['industryTypes'].forEach((v) {
        industryTypes!.add(new IndustryTypes.fromJson(v));
      });
    }
    if (json['expertise'] != null) {
      expertise = <Expertise>[];
      json['expertise'].forEach((v) {
        expertise!.add(new Expertise.fromJson(v));
      });
    }
    isEmailVerified = json['isEmailVerified'];
    aboutMe = json['aboutMe'];
    isFollowing = json['isFollowing'];
    followersCount = json['followersCount'];
    followingCount = json['followingCount'];
    postCount = json['postCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isApproved'] = this.isApproved;
    data['userDocument'] = this.userDocument;
    data['companyName'] = this.companyName;
    data['jobProfile'] = this.jobProfile;
    data['fees'] = this.fees;
    data['workingHours'] = this.workingHours;
    data['rejectionReason'] = this.rejectionReason;
    data['userName'] = this.userName;
    data['name'] = this.name;
    data['email'] = this.email;
    data['module'] = this.module;
    data['approvalStatus'] = this.approvalStatus;
    data['mobileNo'] = this.mobileNo;
    data['uuid'] = this.userUid;
    data['profileUid'] = this.profileUid;
    data['userProfilePic'] = this.userProfilePic;
    data['userBackgroundPic'] = this.userBackgroundPic;
    if (this.industryTypes != null) {
      data['industryTypes'] =
          this.industryTypes!.map((v) => v.toJson()).toList();
    }
    if (this.expertise != null) {
      data['expertise'] = this.expertise!.map((v) => v.toJson()).toList();
    }
    data['isEmailVerified'] = this.isEmailVerified;
    data['aboutMe'] = this.aboutMe;
    data['isFollowing'] = this.isFollowing;
    data['followersCount'] = this.followersCount;
    data['followingCount'] = this.followingCount;
    data['postCount'] = this.postCount;
    return data;
  }
}

class IndustryTypes {
  String? industryTypeUid;
  String? industryTypeName;

  IndustryTypes({this.industryTypeUid, this.industryTypeName});

  IndustryTypes.fromJson(Map<String, dynamic> json) {
    industryTypeUid = json['industryTypeUid'];
    industryTypeName = json['industryTypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['industryTypeUid'] = this.industryTypeUid;
    data['industryTypeName'] = this.industryTypeName;
    return data;
  }
}

class Expertise {
  String? uid;
  String? expertiseName;

  Expertise({this.uid, this.expertiseName});

  Expertise.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    expertiseName = json['expertiseName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['expertiseName'] = this.expertiseName;
    return data;
  }
}
