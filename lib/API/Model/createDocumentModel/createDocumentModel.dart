class ChooseDocument {
  String? message;
  String? object;
  bool? success;

  ChooseDocument({this.message, this.object, this.success});

  ChooseDocument.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    object = json['object'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['object'] = this.object;
    data['success'] = this.success;
    return data;
  }
}

class ChooseDocument1 {
  String? message;
  String? object;
  bool? success;

  ChooseDocument1({this.message, this.object, this.success});

  ChooseDocument1.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    object = json['object'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['object'] = this.object;
    data['success'] = this.success;
    return data;
  }
}