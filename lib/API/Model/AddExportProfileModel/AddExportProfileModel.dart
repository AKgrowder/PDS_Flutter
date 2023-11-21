class AddExpertProfile {
  String? message;
  Object? object;
  bool? success;

  AddExpertProfile({this.message, this.object, this.success});

  AddExpertProfile.fromJson(Map<String, dynamic> json) {
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
  String? uid;
  String? expertiseName;

  Object({this.uid, this.expertiseName});

  Object.fromJson(Map<String, dynamic> json) {
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