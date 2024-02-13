import 'package:pds/API/Model/ReadAllModel/ReadAll_model.dart';

abstract class ReadAllMSGState {}

class ReadAllMSGLoadingState extends ReadAllMSGState {}

class ReadAllMSGInitialState extends ReadAllMSGState {}

class ReadAllMSGLoadedState extends ReadAllMSGState {
  final ReadAllModel ReadAllMSGModelData;
  ReadAllMSGLoadedState(this.ReadAllMSGModelData);
}

class ReadAllMSGErrorState extends ReadAllMSGState {
  final dynamic error;
  ReadAllMSGErrorState(this.error);
}

