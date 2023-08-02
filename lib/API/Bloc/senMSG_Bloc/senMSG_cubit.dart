import 'package:archit_s_application1/API/Bloc/Fatch_All_PRoom_Bloc/Fatch_PRoom_cubit.dart';
import 'package:archit_s_application1/API/Bloc/senMSG_Bloc/senMSG_state.dart';
import 'package:archit_s_application1/API/Model/coment/coment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Model/SendMSG/SendMSG_Model.dart';
import '../../Repo/repository.dart';

class senMSGCubit extends Cubit<senMSGState> {
  senMSGCubit() : super(senMSGInitialState()) {}
  String currentPage = '0';
  String record = '300';
  List<String> dataList = [];
  Future<void> senMSGAPI(String Room_ID, String MSG,{bool ShowLoader = false}) async {
    try {
      ShowLoader == false ? emit(senMSGLoadingState()) : SizedBox();
      sendMSGModel PublicRModel = await Repository().SendMSG(Room_ID, MSG);
      if (PublicRModel.success == true) {
        print('staus Get');
        emit(senMSGLoadedState(PublicRModel));
        coomentPage(Room_ID);
      } else {
        emit(senMSGErrorState('No Data Found!'));
      }
    } catch (e) {
      print('senMSGApi-$e');
      emit(senMSGErrorState(e.toString()));
    }
  }

  Future<void> coomentPage(String Room_ID, {bool ShowLoader = true}) async {
    print('roomId-$Room_ID');
    try {
      ShowLoader == true ?  SizedBox():emit(senMSGLoadingState()) ;
      ComentApiModel comentApiClass =
          await Repository().commentApi(Room_ID, currentPage, record);

      if (comentApiClass.success == true) {
        print("comentApiClass.sucuess-");
        emit(ComentApiState(comentApiClass));
      } else {
        emit(senMSGErrorState('No Data Found!'));
      }
    } catch (e) {
      print('Catthceroor-${e.toString()}');
      emit(senMSGErrorState(e.toString()));
    }
  }
}
