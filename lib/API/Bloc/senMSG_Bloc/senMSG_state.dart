import 'package:archit_s_application1/API/Model/coment/coment_model.dart';

import '../../Model/SendMSG/SendMSG_Model.dart';

abstract class senMSGState {}

class senMSGLoadingState extends senMSGState {}

class senMSGInitialState extends senMSGState {}

class senMSGLoadedState extends senMSGState {
  final sendMSGModel PublicRoomData;
  senMSGLoadedState(this.PublicRoomData);
}

class senMSGErrorState extends senMSGState {
  final String error;
  senMSGErrorState(this.error);
}

class ComentApiState extends senMSGState {
  final ComentApiClass comentApiClass;

  ComentApiState(this.comentApiClass);

  ComentApiClass get props => comentApiClass;
}
