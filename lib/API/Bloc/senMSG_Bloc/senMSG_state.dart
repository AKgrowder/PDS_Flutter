import 'package:pds/API/Model/coment/coment_model.dart';

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

// class ComentApiClassPagenation extends senMSGState {
//   final ComentApiModel comentApiClassPagenation;

//   ComentApiClassPagenation(this.comentApiClassPagenation);
// }

class ComentApiIntragtionWithChatState extends senMSGState {
  final dynamic comentApiClass1;
  ComentApiIntragtionWithChatState(this.comentApiClass1);
}
