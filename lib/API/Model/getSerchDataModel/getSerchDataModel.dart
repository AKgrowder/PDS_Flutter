class GetDataInSerch {
  String? message;
  List<String>? object;
  bool? success;

  GetDataInSerch({this.message, this.object, this.success});

  GetDataInSerch.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    object = json['object'].cast<String>();
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