
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

 