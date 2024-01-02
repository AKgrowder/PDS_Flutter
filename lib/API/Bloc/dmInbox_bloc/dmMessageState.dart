import 'package:pds/API/Model/GetAllInboxImagesModel/GetAllInboxImagesModel.dart';
import 'package:pds/API/Model/createDocumentModel/createDocumentModel.dart';
import 'package:pds/API/Model/inboxScreenModel/SeenAllMessageModel.dart';
import 'package:pds/API/Model/inboxScreenModel/inboxScrrenModel.dart';

abstract class getInboxState {}

class getInboxLoadingState extends getInboxState {}

class getInboxInitialState extends getInboxState {}

class getInboxLoadedState extends getInboxState {
  final GetInboxMessagesModel getInboxMessagesModel;
  getInboxLoadedState(this.getInboxMessagesModel);
}

class getInboxErrorState extends getInboxState {
  final dynamic error;
  getInboxErrorState(this.error);
}

class AddPostImaegState extends getInboxState {
  final ChooseDocument1 imageDataPost;
  AddPostImaegState(this.imageDataPost);
}

class SendImageInUserChatState extends getInboxState {
  final dynamic chatImageData;
  SendImageInUserChatState(this.chatImageData);
}

class GetAllInboxImagesState extends getInboxState {
  final GetAllInboxImages getAllInboxImages;
  GetAllInboxImagesState(this.getAllInboxImages);
}


class SeenAllMessageLoadedState extends getInboxState {
  final SeenAllMessageModel SeenAllMessageModelData;
  SeenAllMessageLoadedState(this.SeenAllMessageModelData);
}
