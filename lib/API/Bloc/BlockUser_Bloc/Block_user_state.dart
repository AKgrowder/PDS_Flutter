import '../../Model/BlockeUserModel/BlockUser_list_model.dart';
import '../../Model/BlockeUserModel/BlockUser_model.dart';

abstract class BlockUserState {}

class BlockUserLoadingState extends BlockUserState {}

class BlockUserInitialState extends BlockUserState {}

class BlockUserLoadedState extends BlockUserState {
  final BlockUserModel blockUserModel;
  BlockUserLoadedState(this.blockUserModel);
}
class BlockUserListLoadedState extends BlockUserState {
  final BlockUserListModel blockUserListModel;
  BlockUserListLoadedState(this.blockUserListModel);
}

class BlockUserErrorState extends BlockUserState {
  final dynamic error;
  BlockUserErrorState(this.error);
}
