import 'package:pds/API/Bloc/my_account_Bloc/my_account_state.dart';
import 'package:pds/API/Model/getCountOfSavedRoomModel/getCountOfSavedRoomModel.dart';
import 'package:pds/API/Model/myaccountModel/myaccountModel.dart';
import 'package:pds/API/Model/pinAndUnpinModel/pinAndUnpinModel.dart';

import '../../Model/FetchAllExpertsModel/FetchAllExperts_Model.dart';
import '../../Model/Get_all_blog_Model/get_all_blog_model.dart';
import '../../Model/HomeScreenModel/MyPublicRoom_model.dart';
import '../../Model/HomeScreenModel/PublicRoomModel.dart';
import '../../Model/HomeScreenModel/getLoginPublicRoom_model.dart';
import '../../Model/System_Config_model/fetchUserModule_model.dart';
import '../../Model/checkUserStatusModel/chekuserStausModel.dart';
import '../../Model/delete_room_model/Delete_room_model.dart';

abstract class FetchAllPublicRoomState {}

class FetchAllPublicRoomLoadingState extends FetchAllPublicRoomState {}

class FetchAllPublicRoomInitialState extends FetchAllPublicRoomState {}

class FetchAllPublicRoomLoadedState extends FetchAllPublicRoomState {
  final PublicRoomModel PublicRoomData;
  FetchAllPublicRoomLoadedState(this.PublicRoomData);
}

// class FetchAllExpertsLoadedState extends FetchAllPublicRoomState {
//   final FetchAllExpertsModel FetchAllExpertsData;
//   FetchAllExpertsLoadedState(this.FetchAllExpertsData);
// }

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

class GetallblogLoadingState extends FetchAllPublicRoomState {}

class GetallblogLoadedState extends FetchAllPublicRoomState {
  final GetallBlogModel getallBlogdata;
  GetallblogLoadedState(this.getallBlogdata);
}

class GetUserProfileLoadedState extends FetchAllPublicRoomState {
  final MyAccontDetails myAccontDetails;

  GetUserProfileLoadedState(this.myAccontDetails);
}

class DeleteRoomLoadedState extends FetchAllPublicRoomState {
  final DeleteRoomModel DeleteRoom;
  DeleteRoomLoadedState(this.DeleteRoom);
}


class SelectedDataPinAndUnpin extends FetchAllPublicRoomState {
  final UnPinModel unPinModel;
  SelectedDataPinAndUnpin(this.unPinModel);
}

class AutoEnterinLoadedState extends FetchAllPublicRoomState {
  final AutoEnterRoomModel AutoEnterinData;
  AutoEnterinLoadedState(this.AutoEnterinData);
}

class GetTotalSavedataCount extends FetchAllPublicRoomState {
  final GetCountOfSavedRoomModel getCountOfSavedRoomModel;
  GetTotalSavedataCount(this.getCountOfSavedRoomModel);
}