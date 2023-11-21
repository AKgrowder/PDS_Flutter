import 'package:pds/API/Model/fetch_room_detail_model/fetch_room_detail_model.dart';

abstract class FetchRoomDetailState {}

class FetchRoomDetailLoadingState extends FetchRoomDetailState {}

class FetchRoomDetailInitialState extends FetchRoomDetailState {}

class FetchRoomDetailLoadedState extends FetchRoomDetailState {
  final FetchRoomDetailModel fetchRoomDetailModel;
  FetchRoomDetailLoadedState(this.fetchRoomDetailModel);
}

class FetchRoomDetailErrorState extends FetchRoomDetailState {
  final dynamic error;
  FetchRoomDetailErrorState(this.error);
}
