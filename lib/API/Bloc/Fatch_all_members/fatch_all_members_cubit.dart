import 'package:flutter_bloc/flutter_bloc.dart'; 
import '../../Model/FatchAllMembers/fatchallmembers_model.dart';
import '../../Repo/repository.dart'; 
import 'fatch_all_members_state.dart';

class FatchAllMembersCubit extends Cubit<FatchAllMembersState> {
  FatchAllMembersCubit() : super(FatchAllMembersInitialState()) {}
  Future<void> FatchAllMembersAPI(String Roomuid) async {
    try {
      emit(FatchAllMembersLoadingState());
      FatchAllMembersModel PublicRModel =
          await Repository().FatchAllMembersAPI(Roomuid);
      if (PublicRModel.success == true) {
        emit(FatchAllMembersLoadedState(PublicRModel));
      } else {
        emit(FatchAllMembersErrorState('No Data Found!'));
      }
    } catch (e) {
      emit(FatchAllMembersErrorState(e.toString()));
    }
  }
}
