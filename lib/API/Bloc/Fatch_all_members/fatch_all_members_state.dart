 
 
import 'package:pds/API/Model/RoomExistsModel/RoomExistsModel.dart';

import '../../Model/FatchAllMembers/fatchallmembers_model.dart';

abstract class FatchAllMembersState {}

class FatchAllMembersLoadingState extends FatchAllMembersState {}

class FatchAllMembersInitialState extends FatchAllMembersState {}

class FatchAllMembersLoadedState extends FatchAllMembersState {
  final FatchAllMembersModel FatchAllMembersData;
  FatchAllMembersLoadedState(this.FatchAllMembersData);
}

class FatchAllMembersErrorState extends FatchAllMembersState {
  final dynamic error;
  FatchAllMembersErrorState(this.error);
}


class RoomExistsLoadedState extends FatchAllMembersState {
  final RoomExistsModel roomExistsModel;
  RoomExistsLoadedState(this.roomExistsModel);
}
