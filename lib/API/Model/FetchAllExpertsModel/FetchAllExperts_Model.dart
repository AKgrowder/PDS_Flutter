class FetchAllExpertsModel {
  String? message;
  List<Object>? object;
  bool? success;

  FetchAllExpertsModel({this.message, this.object, this.success});

  FetchAllExpertsModel.fromJson(Map<String, dynamic> json) {
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
  String? uuid;
  String? userName;
  double? fees;
  String? workingHours;
  String? userEmail;
  List<Expertise>? expertise;
  String? profilePic;
  String? followStatus;

  Object(
      {this.uuid,
      this.userName,
      this.fees,
      this.workingHours,
      this.userEmail,
      this.expertise,
      this.profilePic,
      this.followStatus});

  Object.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    userName = json['userName'];
    fees = json['fees'];
    workingHours = json['workingHours'];
    userEmail = json['userEmail'];
    if (json['expertise'] != null) {
      expertise = <Expertise>[];
      json['expertise'].forEach((v) {
        expertise!.add(new Expertise.fromJson(v));
      });
    }
    profilePic = json['profilePic'];
    followStatus = json['followStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['userName'] = this.userName;
    data['fees'] = this.fees;
    data['workingHours'] = this.workingHours;
    data['userEmail'] = this.userEmail;
    if (this.expertise != null) {
      data['expertise'] = this.expertise!.map((v) => v.toJson()).toList();
    }
    data['profilePic'] = this.profilePic;
    data['followStatus'] = this.followStatus;
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
