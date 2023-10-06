import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Repo/repository.dart';
import 'Fatch_PRoom_state.dart';

class FetchAllPublicRoomCubit extends Cubit<FetchAllPublicRoomState> {
  FetchAllPublicRoomCubit() : super(FetchAllPublicRoomInitialState()) {}
  Future<void> FetchAllPublicRoom(BuildContext context) async {
    dynamic PublicRModel;
    try {
      emit(FetchAllPublicRoomLoadingState());
      PublicRModel = await Repository().FetchAllPublicRoom(context);
      if (PublicRModel.success == true) {
        emit(FetchAllPublicRoomLoadedState(PublicRModel));
      }
    } catch (e) {
      emit(FetchAllPublicRoomErrorState(PublicRModel));
    }
  }

  Future<void> FetchAllExpertsAPI(BuildContext context) async {
    dynamic PublicRModel;
    try {
      emit(FetchAllPublicRoomLoadingState());
      PublicRModel = await Repository().FetchAllExpertsAPI(context);
      if (PublicRModel.success == true) {
        emit(FetchAllExpertsLoadedState(PublicRModel));
      }
    } catch (e) {
      emit(FetchAllPublicRoomErrorState(PublicRModel));
    }
  }

  Future<void> chckUserStaus(BuildContext context) async {
    dynamic checkUserStausModel;
    try {
      emit(FetchAllPublicRoomLoadingState());
      checkUserStausModel = await Repository().checkUserActive(context);
      if (checkUserStausModel.success == true) {
        emit(CheckuserLoadedState(checkUserStausModel));
      }
    } catch (e) {
      emit(FetchAllPublicRoomErrorState(checkUserStausModel));
    }
  }

  Future<void> FetchPublicRoom(String uuid, BuildContext context) async {
    dynamic FetchPublicRoomModel;
    try {
      emit(FetchAllPublicRoomLoadingState());
      FetchPublicRoomModel = await Repository().FetchPublicRoom(uuid, context);
      if (FetchPublicRoomModel.success == true) {
        emit(FetchPublicRoomLoadedState(FetchPublicRoomModel));
      }
    } catch (e) {
      emit(FetchAllPublicRoomErrorState(FetchPublicRoomModel));
    }
  }

  Future<void> MyPublicRoom(String uuid, BuildContext context,
      {bool loder = true}) async {
    dynamic FetchPublicRoomModel;
    try {
      loder == true ? SizedBox() : emit(FetchAllPublicRoomLoadingState());
      FetchPublicRoomModel = await Repository().MyPublicRoom1(uuid, context);
      if (FetchPublicRoomModel.success == true) {
        emit(MyPublicRoom1LoadedState(FetchPublicRoomModel));
      }
    } catch (e) {
      emit(FetchAllPublicRoomErrorState(FetchPublicRoomModel));
    }
  }

  Future<void> UserModel(
    BuildContext context,
  ) async {
    dynamic systemConfigModel;
    try {
      emit(FetchAllPublicRoomLoadingState());
      systemConfigModel = await Repository().UserModel(context);
      if (systemConfigModel.success == true) {
        emit(fetchUserModulemodelLoadedState(systemConfigModel));
      }
    } catch (e) {
      emit(FetchAllPublicRoomErrorState(systemConfigModel));
    }
  }

  Future<void> GetallBlog(BuildContext context) async {
    dynamic getallBlogmodel;
    try {
      emit(GetallblogLoadingState());
      getallBlogmodel = await Repository().GetallBlog(context);
      if (getallBlogmodel.success == true) {
        emit(GetallblogLoadedState(getallBlogmodel));
      }
    } catch (e) {
      emit(FetchAllPublicRoomErrorState(getallBlogmodel));
    }
  }

  Future<void> MyAccount(BuildContext context) async {
    dynamic myAccontDetails;
    try {
      emit(FetchAllPublicRoomLoadingState());
      myAccontDetails = await Repository().myAccount(context);
      if (myAccontDetails.success == true) {
        emit(GetUserProfileLoadedState(myAccontDetails));
      }
    } catch (e) {
      emit(FetchAllPublicRoomErrorState(myAccontDetails));
    }
  }

  Future<void> DeleteRoomm(String roomuId, BuildContext context) async {
    dynamic GetAllPrivateRoom;
    try {
      emit(FetchAllPublicRoomLoadingState());
      GetAllPrivateRoom = await Repository().DeleteRoomApi(roomuId, context);
      if (GetAllPrivateRoom.success == true) {
        emit(DeleteRoomLoadedState(GetAllPrivateRoom));
      } else {
        emit(FetchAllPublicRoomErrorState(GetAllPrivateRoom.message));
      }
    } catch (e) {
      emit(FetchAllPublicRoomErrorState(GetAllPrivateRoom));
    }
  }

  Future<void> pinAndunPinMethod(BuildContext context, String uuid) async {
    dynamic pinAndUnPin;
    try {
      emit(FetchAllPublicRoomLoadingState());
      pinAndUnPin = await Repository().pinAndUnPin(context, uuid);
      if (pinAndUnPin.success == true) {
        emit(SelectedDataPinAndUnpin(pinAndUnPin));
      } else {
        emit(FetchAllPublicRoomErrorState(pinAndUnPin.message));
      }
    } catch (e) {
      emit(FetchAllPublicRoomErrorState(pinAndUnPin));
    }
  }

  Future<void> getCountOfSavedRoom(
    BuildContext context,
  ) async {
    dynamic pinAndUnPin;
    try {
      emit(FetchAllPublicRoomLoadingState());
      pinAndUnPin = await Repository().getCountOfSavedRoomMethod(context);
      if (pinAndUnPin.success == true) {
        emit(GetTotalSavedataCount(pinAndUnPin));
      } else {
        emit(FetchAllPublicRoomErrorState(pinAndUnPin.message));
      }
    } catch (e) {
      emit(FetchAllPublicRoomErrorState(pinAndUnPin));
    }
  }

   Future<void> AutoEnterinRoom(
    BuildContext context,
    String RoomID
  ) async {
    dynamic AutoEnterRoom;
    try {
      emit(FetchAllPublicRoomLoadingState());
      AutoEnterRoom = await Repository().AutoEnterinAPI(context,RoomID);
      if (AutoEnterRoom.success == true) {
        emit(AutoEnterinLoadedState(AutoEnterRoom));
      } else {
        emit(FetchAllPublicRoomErrorState(AutoEnterRoom.message));
      }
    } catch (e) {
      emit(FetchAllPublicRoomErrorState(AutoEnterRoom));
    }
  }
}
