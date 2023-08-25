class FetchRoomDetailModel {
  String? message;
  Object? object;
  bool? success;

  FetchRoomDetailModel({this.message, this.object, this.success});

  FetchRoomDetailModel.fromJson(Map<String, dynamic> json) {
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
  String? roomUid;
  String? companyName;
  String? roomName;
  String? roomDescription;
  Null? document;
  String? createdDate;

  Object(
      {this.roomUid,
      this.companyName,
      this.roomName,
      this.roomDescription,
      this.document,
      this.createdDate});

  Object.fromJson(Map<String, dynamic> json) {
    roomUid = json['roomUid'];
    companyName = json['companyName'];
    roomName = json['roomName'];
    roomDescription = json['roomDescription'];
    document = json['document'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roomUid'] = this.roomUid;
    data['companyName'] = this.companyName;
    data['roomName'] = this.roomName;
    data['roomDescription'] = this.roomDescription;
    data['document'] = this.document;
    data['createdDate'] = this.createdDate;
    return data;
  }
}
