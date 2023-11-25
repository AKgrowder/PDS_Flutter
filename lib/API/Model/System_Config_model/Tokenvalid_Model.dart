class TokenvalidModel {
  String? message;
  Object? object;
  bool? success;

  TokenvalidModel({this.message, this.object, this.success});

  TokenvalidModel.fromJson(Map<String, dynamic> json) {
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
  bool? isActive;

  Object({this.isActive});

  Object.fromJson(Map<String, dynamic> json) {
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isActive'] = this.isActive;
    return data;
  }
}
