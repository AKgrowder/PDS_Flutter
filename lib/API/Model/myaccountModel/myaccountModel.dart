class MyAccontDetails {
  String? message;
  Object? object;
  bool? success;

  MyAccontDetails({this.message, this.object, this.success});

  MyAccontDetails.fromJson(Map<String, dynamic> json) {
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
  dynamic isApproved;
  String? userDocument;
  dynamic companyName;
  String? jobProfile;
  String? documentName;
  double? fees;
  String? workingHours;
  String? rejectionReason;
  String? userName;
  String? name;
  String? email;
  String? module;
  String? approvalStatus;
  String? mobileNo;
  String? uuid;
  String? userProfilePic;
  List<Expertise>? expertise;
  bool?isEmailVerified; 

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
      this.documentName,
      this.email,
      this.module,
      this.approvalStatus,
      this.mobileNo,
      this.uuid,
      this.userProfilePic,
      this.expertise,
      this.isEmailVerified
      });

  Object.fromJson(Map<String, dynamic> json) {
    
    isApproved = json['isApproved'];
    userDocument = json['userDocument'];
    companyName = json['companyName'];
    jobProfile = json['jobProfile'];
    documentName = json['documentName'];
    fees = json['fees'];
    workingHours = json['workingHours'];
    rejectionReason = json['rejectionReason'];
    userName = json['userName'];
    name = json['name'];
    email = json['email'];
    module = json['module'];
    approvalStatus = json['approvalStatus'];
    mobileNo = json['mobileNo'];
    uuid = json['uuid'];
    userProfilePic = json['userProfilePic'];
    isEmailVerified = json['isEmailVerified'];
    if (json['expertise'] != null) {
      expertise = <Expertise>[];
      json['expertise'].forEach((v) {
        expertise!.add(new Expertise.fromJson(v));
      });
    }
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
    data['uuid'] = this.uuid;
    data['userProfilePic'] = this.userProfilePic;
    if (this.expertise != null) {
      data['expertise'] = this.expertise!.map((v) => v.toJson()).toList();
    }
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