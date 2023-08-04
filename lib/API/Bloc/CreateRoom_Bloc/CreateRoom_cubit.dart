import 'package:flutter_bloc/flutter_bloc.dart'; 
import '../../Model/CreateRoomModel/CreateRoom_Model.dart';
import '../../Repo/repository.dart';
import 'CreateRoom_state.dart'; 

class CreateRoomCubit extends Cubit<CreateRoomState> {
  CreateRoomCubit() : super(CreateRoomInitialState()) {}
  Future<void> CreateRoomAPI(Map<String, String> params) async {
    try {
      emit(CreateRoomLoadingState());
      CreateRoomModel PublicRModel =
          await Repository().CreateRoomAPI(params);
      if (PublicRModel.success == true) {
        emit(CreateRoomLoadedState(PublicRModel));
      } else {
        // emit(CreateRoomErrorState('No Data Found!'));
        emit(CreateRoomErrorState('${PublicRModel.message}'));
      }
    } catch (e) {
      emit(CreateRoomErrorState(e.toString()));
    }
  }
}
