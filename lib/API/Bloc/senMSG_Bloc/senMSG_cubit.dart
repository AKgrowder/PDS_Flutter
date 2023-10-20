import 'dart:io';

import 'package:pds/API/Bloc/senMSG_Bloc/senMSG_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Repo/repository.dart';

class senMSGCubit extends Cubit<senMSGState> {
  senMSGCubit() : super(senMSGInitialState()) {}

  List<String> dataList = [];
  dynamic comentApiClass;
  // Future<void> senMSGAPI(String Room_ID, String MSG, BuildContext context,
  //     {bool ShowLoader = false}) async {
  //   dynamic PublicRModel;
  //   try {
  //     ShowLoader == false ? emit(senMSGLoadingState()) : SizedBox();
  //     PublicRModel = await Repository().SendMSG(Room_ID, MSG, context);
  //     if (PublicRModel.success == true) {
  //       print('staus Get');
  //       emit(senMSGLoadedState(PublicRModel));
  //       coomentPage(Room_ID, context);
  //     } 
  //   } catch (e) {
  //     print('senMSGApi-$e');
  //     emit(senMSGErrorState(PublicRModel));
  //   }
  // }

  Future<void> coomentPage(
      String Room_ID, BuildContext context, String currentPage,
      {bool ShowLoader = true}) async {
    print('roomId-$Room_ID');

    try {
      ShowLoader == true ? SizedBox() : emit(senMSGLoadingState());
      comentApiClass =
          await Repository().commentApi(Room_ID, currentPage, context);

      if (comentApiClass.success == true) {
        print("comentApiClass.sucuess-");
        emit(ComentApiState(comentApiClass));
      } else {
        emit(senMSGErrorState('No Data Found!'));
      }
    } catch (e) {
      print('Catthceroor-${e.toString()}');
      emit(senMSGErrorState(comentApiClass));
    }
  }

  Future<void> coomentPagePagenation(
      String Room_ID, BuildContext context, String currentPage,
      {bool ShowLoader = true}) async {
    print('roomId-$Room_ID');
    dynamic comentApiClassPagenation;
    try {
      ShowLoader == true ? SizedBox() : emit(senMSGLoadingState());
      comentApiClassPagenation =
          await Repository().commentApi(Room_ID, currentPage, context);
      if (comentApiClassPagenation.object.messageOutputList != null) {
        print("comentApiClass.sucuess-");

        comentApiClass.object.messageOutputList.content
            .insertAll(0,comentApiClassPagenation.object.messageOutputList.content.reversed
                        .toList());

        comentApiClass.object.messageOutputList.pageable.pageNumber =
            comentApiClassPagenation
                .object.messageOutputList.pageable.pageNumber;
        comentApiClass.object.messageOutputList.totalElements =
            comentApiClassPagenation.object.messageOutputList.totalElements;

        emit(ComentApiState(comentApiClass));
        // emit(ComentApiClassPagenation(comentApiClassPagenation));
      } /* else {
        emit(senMSGErrorState('No Data Found!'));
      } */
    } catch (e) {
      print('Catthceroor-${e.toString()}');
      emit(senMSGErrorState(comentApiClassPagenation));
    }
  }

  Future<void> chatImageMethod(
    String Room_ID,
    BuildContext context,
    String userUid,
    File imageFile,
  ) async {
    print('roomId-$Room_ID');
    print("userUid-$userUid");
    dynamic responce;
    try {
      responce =
          await Repository().chatImage(context, Room_ID, userUid, imageFile);
      print('dfbsdfhsdf-$responce');
      if (responce['success'] == true) {
        print("comentApiClass.sucuess-");
        emit(ComentApiIntragtionWithChatState(responce));
      } else {
        emit(senMSGErrorState('No Data Found!'));
      }
    } catch (e) {
      print('Catthceroor-${e.toString()}');
      emit(senMSGErrorState(responce['message']));
    }
  }
}
