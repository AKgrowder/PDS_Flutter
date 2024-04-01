class CommenModel {
  int? code;
  String? message;
  String? status;
  dynamic data;
  String? pageNumber;

  CommenModel(
      {this.code, this.message, this.status, this.data, this.pageNumber});

  CommenModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? json['data'] : null;
    pageNumber = json['pageNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['pageNumber'] = this.pageNumber;
    return data;
  }
}
