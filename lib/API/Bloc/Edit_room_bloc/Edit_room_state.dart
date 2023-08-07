
 
import 'package:archit_s_application1/API/Model/Edit_room_model/edit_room_model.dart';

import '../../Model/creat_form/creat_form_Model.dart';

abstract class EditroomState {}

class EditroomLoadingState extends EditroomState {}

class EditroomInitialState extends EditroomState {}

class EditroomLoadedState extends EditroomState {
  final EditRoomModel editRoom;
  EditroomLoadedState(this.editRoom);
}

class EditroomErrorState extends EditroomState {
  final String error;
  EditroomErrorState(this.error);
}
