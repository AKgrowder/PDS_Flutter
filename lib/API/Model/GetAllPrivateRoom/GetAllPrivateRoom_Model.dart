// class GetAllPrivateRoomModel {
//   String? message;
//   List<Object>? object;
//   bool? success;

//   GetAllPrivateRoomModel({this.message, this.object, this.success});

//   GetAllPrivateRoomModel.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     if (json['object'] != null) {
//       object = <Object>[];
//       json['object'].forEach((v) {
//         object!.add(new Object.fromJson(v));
//       });
//     }
//     success = json['success'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['message'] = this.message;
//     if (this.object != null) {
//       data['object'] = this.object!.map((v) => v.toJson()).toList();
//     }
//     data['success'] = this.success;
//     return data;
//   }
// }

// class Object {
//   String? uid;
//   String? roomQuestion;
//   String? roomType;
//   Null? user;

//   Object({this.uid, this.roomQuestion, this.roomType, this.user});

//   Object.fromJson(Map<String, dynamic> json) {
//     uid = json['uid'];
//     roomQuestion = json['roomQuestion'];
//     roomType = json['roomType'];
//     user = json['user'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['uid'] = this.uid;
//     data['roomQuestion'] = this.roomQuestion;
//     data['roomType'] = this.roomType;
//     data['user'] = this.user;
//     return data;
//   }
// }


class GetAllPrivateRoomModel {
  String? message;
  List<Object>? object;
  bool? success;

  GetAllPrivateRoomModel({this.message, this.object, this.success});

  GetAllPrivateRoomModel.fromJson(Map<String, dynamic> json) {
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
  String? roomQuestion;
  String? roomType;
  String? createdDate;
  String? description;
  List<UsersList>? usersList;

  Object(
      {this.uid,
      this.roomQuestion,
      this.roomType,
      this.createdDate,
      this.description,
      this.usersList});

  Object.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    roomQuestion = json['roomQuestion'];
    roomType = json['roomType'];
    createdDate = json['createdDate'];
    description = json['description'];
    if (json['usersList'] != null) {
      usersList = <UsersList>[];
      json['usersList'].forEach((v) {
        usersList!.add(new UsersList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['roomQuestion'] = this.roomQuestion;
    data['roomType'] = this.roomType;
    data['createdDate'] = this.createdDate;
    data['description'] = this.description;
    if (this.usersList != null) {
      data['usersList'] = this.usersList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UsersList {
  String? uuid;
  String? userName;
  String? name;

  UsersList({this.uuid, this.userName, this.name});

  UsersList.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    userName = json['userName'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['userName'] = this.userName;
    data['name'] = this.name;
    return data;
  }
}
