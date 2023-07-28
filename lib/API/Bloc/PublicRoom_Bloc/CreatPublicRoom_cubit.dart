import 'package:flutter_bloc/flutter_bloc.dart'; 
import '../../Model/AddThread/CreateRoom_Model.dart';
import '../../Repo/repository.dart';
import 'CreatPublicRoom_state.dart'; 

class CreatPublicRoomCubit extends Cubit<CreatPublicRoomState> {
  CreatPublicRoomCubit() : super(CreatPublicRoomInitialState()) {}
  Future<void> CreatPublicRoomAPI(Map<String, String> params) async {
    try {
      emit(CreatPublicRoomLoadingState());
      CreatPublicRoomModel PublicRModel = await Repository().CreatPublicRoom(params);
      if (PublicRModel.success == true) {
        
        emit(CreatPublicRoomLoadedState(PublicRModel));
      }else{
        emit(CreatPublicRoomErrorState('No Data Found!'));
      }
    } catch (e) {
      emit(CreatPublicRoomErrorState(e.toString()));
    }
  }
}
