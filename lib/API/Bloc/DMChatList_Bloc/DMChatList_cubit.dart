// import 'package:pds/API/Bloc/DMChatList_Bloc/DMChatList_state.dart';
// import 'package:pds/API/Repo/repository.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

 

// class DMChatListCubit extends Cubit<DMChatListState> {
//   DMChatListCubit() : super(DMChatListInitialState()) {}
//   Future<void> DMChatListm(String roomuId, BuildContext context) async {
//     dynamic DMChatList;
//     try {
//       emit(DMChatListLoadingState());
//       DMChatList = await Repository().DMChatListApi(roomuId, context);
//       if (DMChatList == "Something Went Wrong, Try After Some Time.") {
//         emit(DMChatListErrorState("${DMChatList}"));
//       } else {
//         if (DMChatList.success == true) {
//           emit(DMChatListLoadedState(DMChatList));
//         } else {
//           emit(DMChatListErrorState(DMChatList.message));
//         }
//       }
//     } catch (e) {
//       emit(DMChatListErrorState(DMChatList));
//     }
//   }
// }
