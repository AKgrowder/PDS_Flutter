import 'package:pds/API/Model/CreateStory_Model/all_stories.dart';
import 'package:pds/API/Model/GetAllInboxImagesModel/GetAllInboxImagesModel.dart';
import 'package:pds/API/Model/MarkStarred/MarkStarredModel.dart';
import 'package:pds/API/Model/acceptRejectInvitaionModel/getAllNotificationCount.dart';
import 'package:pds/API/Model/createDocumentModel/createDocumentModel.dart';
import 'package:pds/API/Model/inboxScreenModel/LiveStatusModel.dart';
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

class GetNotificationCountLoadedState extends getInboxState {
  final getAllNotificationCount GetNotificationCountData;
  GetNotificationCountLoadedState(this.GetNotificationCountData);
}

class SeenAllMessageLoadedState extends getInboxState {
  final SeenAllMessageModel SeenAllMessageModelData;
  SeenAllMessageLoadedState(this.SeenAllMessageModelData);
}


class LiveStatusLoadedState extends getInboxState {
  final LiveStatusModel LiveStatusModelData;
  LiveStatusLoadedState(this.LiveStatusModelData);
}


class GetAllStoryLoadedState extends getInboxState {
  final GetAllStoryModel getAllStoryModel;
  GetAllStoryLoadedState(this.getAllStoryModel);
}

class GetAllStarClass extends getInboxState {
  final MarkStarred markStarred;
  GetAllStarClass(this.markStarred);
}
