import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Model/GetAllPrivateRoom/GetAllPrivateRoom_Model.dart';
import '../../Repo/repository.dart';
import 'GetAllPrivateRoom_state.dart';

class GetAllPrivateRoomCubit extends Cubit<GetAllPrivateRoomState> {
  GetAllPrivateRoomCubit() : super(GetAllPrivateRoomInitialState()) {}
  Future<void> GetAllPrivateRoomAPI() async {
    try {
      emit(GetAllPrivateRoomLoadingState());
      GetAllPrivateRoomModel PublicRModel =
          await Repository().GetAllPrivateRoom();
      if (PublicRModel.success == true) {
        emit(GetAllPrivateRoomLoadedState(PublicRModel));
      } else {
        // emit(GetAllPrivateRoomErrorState('No Data Found!'));
        emit(GetAllPrivateRoomErrorState('${PublicRModel.message}'));
      }
    } catch (e) {
      emit(GetAllPrivateRoomErrorState(e.toString()));
    }
  }

  
}
