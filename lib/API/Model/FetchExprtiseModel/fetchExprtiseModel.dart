class FetchExprtise {
  String? message;
  List<Object>? object;
  bool? success;

  FetchExprtise({this.message, this.object, this.success});

  FetchExprtise.fromJson(Map<String, dynamic> json) {
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