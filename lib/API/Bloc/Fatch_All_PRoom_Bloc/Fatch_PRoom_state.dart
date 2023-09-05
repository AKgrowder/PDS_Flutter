import 'package:pds/API/Bloc/my_account_Bloc/my_account_state.dart';
import 'package:pds/API/Model/myaccountModel/myaccountModel.dart';

import '../../Model/FetchAllExpertsModel/FetchAllExperts_Model.dart';
import '../../Model/Get_all_blog_Model/get_all_blog_model.dart';
import '../../Model/HomeScreenModel/MyPublicRoom_model.dart';
import '../../Model/HomeScreenModel/PublicRoomModel.dart';
import '../../Model/HomeScreenModel/getLoginPublicRoom_model.dart';
import '../../Model/System_Config_model/fetchUserModule_model.dart';
import '../../Model/checkUserStatusModel/chekuserStausModel.dart';

abstract class FetchAllPublicRoomState {}

class FetchAllPublicRoomLoadingState extends FetchAllPublicRoomState {}

class FetchAllPublicRoomInitialState extends FetchAllPublicRoomState {}

class FetchAllPublicRoomLoadedState extends FetchAllPublicRoomState {
  final PublicRoomModel PublicRoomData;
  FetchAllPublicRoomLoadedState(this.PublicRoomData);
}

class FetchAllExpertsLoadedState extends FetchAllPublicRoomState {
  final FetchAllExpertsModel FetchAllExpertsData;
  FetchAllExpertsLoadedState(this.FetchAllExpertsData);
}

class FetchAllPublicRoomErrorState extends FetchAllPublicRoomState {
  final dynamic error;
  FetchAllPublicRoomErrorState(this.error);
}

class CheckuserLoadedState extends FetchAllPublicRoomState {
  final CheckUserStausModel CheckUserStausModeldata;
  CheckuserLoadedState(this.CheckUserStausModeldata);
}

class FetchPublicRoomLoadedState extends FetchAllPublicRoomState {
  final LoginPublicRoomModel FetchPublicRoomData;
  FetchPublicRoomLoadedState(this.FetchPublicRoomData);
}

class MyPublicRoom1LoadedState extends FetchAllPublicRoomState {
  final MyPublicRoom MyPublicRoomData;
  MyPublicRoom1LoadedState(this.MyPublicRoomData);
}

class fetchUserModulemodelLoadedState extends FetchAllPublicRoomState {
  final FetchUserModulemodel fetchUserModule;
  fetchUserModulemodelLoadedState(this.fetchUserModule);
}

class GetallblogLoadedState extends FetchAllPublicRoomState {
  final GetallBlogModel getallBlogdata;
  GetallblogLoadedState(this.getallBlogdata);
}

class GetUserProfileLoadedState extends FetchAllPublicRoomState {
  final MyAccontDetails myAccontDetails;

  GetUserProfileLoadedState(this.myAccontDetails);
}
