import 'package:archit_s_application1/API/Bloc/senMSG_Bloc/senMSG_state.dart';
import 'package:archit_s_application1/API/Model/coment/coment_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Model/SendMSG/SendMSG_Model.dart';
import '../../Repo/repository.dart';

class senMSGCubit extends Cubit<senMSGState> {
  senMSGCubit() : super(senMSGInitialState()) {}
  Future<void> senMSGAPI(String Room_ID, String MSG) async {
    try {
      emit(senMSGLoadingState());
      sendMSGModel PublicRModel = await Repository().SendMSG(Room_ID, MSG);
      if (PublicRModel.success == true) {
        emit(senMSGLoadedState(PublicRModel));
      } else {
        emit(senMSGErrorState('No Data Found!'));
      }
    } catch (e) {
      emit(senMSGErrorState(e.toString()));
    }
  }

  Future<void> coomentPage(
    String Room_ID,
  ) async {
    print('roomId-$Room_ID');
    try {
      emit(senMSGLoadingState());
      ComentApiClass comentApiClass =
          await Repository().commentApi(Room_ID, '0', '10');
     
      if (comentApiClass.success == true) {
        print("comentApiClass.sucuess-");
        emit(ComentApiState(comentApiClass));
      }
    } catch (e) {
      print('erorro-${e.toString()}');
      emit(senMSGErrorState(e.toString()));
    }
  }
}
