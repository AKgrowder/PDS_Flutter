import 'package:pds/API/Model/FollwersModel/FllowersModel.dart';
import 'package:pds/API/Model/GetAdminRolesForCompanyPageModel/GetAdminRolesForCompanyPageModel.dart';
import 'package:pds/API/Model/Getalluset_list_Model/get_all_userlist_model.dart';
import 'package:pds/API/Model/like_Post_Model/like_Post_Model.dart';
import 'package:pds/API/Model/removeFolloweModel/removeFollowerModel.dart';

abstract class FolllwerBlockState {}

class FollwertBlockLoadingState extends FolllwerBlockState {}

class FollwertBlockInitialState extends FolllwerBlockState {}

class FollwertBlockLoadedState extends FolllwerBlockState {
  /*  final FollwertBlockModel FollwertBlock;
  FollwertBlockLoadedState(this.FollwertBlock); */
}

class FollwertErrroState extends FolllwerBlockState {
  String? error;
  FollwertErrroState(this.error);
}

class RemoveLoddingState extends FolllwerBlockState {
  Remove_Follower? remove_Follower;
  RemoveLoddingState(this.remove_Follower);
}

class PostLikeLoadedState extends FolllwerBlockState {
  final LikePost likePost;
  PostLikeLoadedState(this.likePost);
}

class FollowersClass extends FolllwerBlockState {
  final FollowersClassModel followersClassModel;
  FollowersClass(this.followersClassModel);
}

class FollowersClass1 extends FolllwerBlockState {
  final FollowersClassModel followersClassModel1;
  FollowersClass1(this.followersClassModel1);
}


class GetAllUserLoadedState extends FolllwerBlockState {
  final GetAllUserListModel getAllUserRoomData;
  GetAllUserLoadedState(this.getAllUserRoomData);
}

class AdminRoleForCompnyUserLoadedState extends FolllwerBlockState {
  final GetAdminRolesForCompanyPage getAdminRoleForCompnyUser;
  AdminRoleForCompnyUserLoadedState(this.getAdminRoleForCompnyUser);
}
