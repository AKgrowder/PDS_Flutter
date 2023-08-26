import 'package:pds/API/Bloc/Fatch_All_PRoom_Bloc/Fatch_PRoom_cubit.dart';
import 'package:pds/API/Bloc/senMSG_Bloc/senMSG_state.dart';
import 'package:pds/API/Model/coment/coment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Model/SendMSG/SendMSG_Model.dart';
import '../../Repo/repository.dart';

class senMSGCubit extends Cubit<senMSGState> {
  senMSGCubit() : super(senMSGInitialState()) {}
  String currentPage = '0';
  String record = '300';
  List<String> dataList = [];
  Future<void> senMSGAPI(String Room_ID, String MSG, BuildContext context,
      {bool ShowLoader = false}) async {
    dynamic PublicRModel;
    try {
      ShowLoader == false ? emit(senMSGLoadingState()) : SizedBox();
      PublicRModel = await Repository().SendMSG(Room_ID, MSG, context);
      if (PublicRModel.success == true) {
        print('staus Get');
        emit(senMSGLoadedState(PublicRModel));
        coomentPage(Room_ID,context);
      }
    } catch (e) {
      print('senMSGApi-$e');
      emit(senMSGErrorState(PublicRModel));
    }
  }

  Future<void> coomentPage(String Room_ID, BuildContext context,
      {bool ShowLoader = true}) async {
    print('roomId-$Room_ID');
    dynamic comentApiClass;
    try {
      ShowLoader == true ? SizedBox() : emit(senMSGLoadingState());
      comentApiClass =
          await Repository().commentApi(Room_ID, currentPage, record, context);

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
}
