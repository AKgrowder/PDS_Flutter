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
  String get propsError => error;
}

class ComentApiState extends senMSGState {
  final ComentApiModel comentApiClass;

  ComentApiState(this.comentApiClass);
 
}
