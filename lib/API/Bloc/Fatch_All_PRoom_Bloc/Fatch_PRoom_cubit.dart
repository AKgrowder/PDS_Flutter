import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Model/HomeScreenModel/PublicRoomModel.dart';
import '../../Repo/repository.dart';
import 'Fatch_PRoom_state.dart';

class FetchAllPublicRoomCubit extends Cubit<FetchAllPublicRoomState> {
  FetchAllPublicRoomCubit() : super(FetchAllPublicRoomInitialState()) {}
  Future<void> FetchAllPublicRoom() async {
    try {
      emit(FetchAllPublicRoomLoadingState());
      PublicRoomModel PublicRModel = await Repository().FetchAllPublicRoom();
      if (PublicRModel.success == true) {
        emit(FetchAllPublicRoomLoadedState(PublicRModel));
      }else{
        emit(FetchAllPublicRoomErrorState(PublicRModel.message.toString()));
      }
    } catch (e) {
      emit(FetchAllPublicRoomErrorState(e.toString()));
    }
  }
}
