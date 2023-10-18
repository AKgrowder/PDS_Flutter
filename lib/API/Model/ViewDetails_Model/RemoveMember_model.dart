class RemoveUserModel {
  String? message;
  Object? object;
  bool? success;

  RemoveUserModel({this.message, this.object, this.success});

  RemoveUserModel.fromJson(Map<String, dynamic> json) {
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
  String? message;
  String? removeExitAt;

  Object({this.message, this.removeExitAt});

  Object.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    removeExitAt = json['removeExitAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['removeExitAt'] = this.removeExitAt;
    return data;
  }
}
