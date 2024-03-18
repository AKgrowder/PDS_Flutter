import 'package:pds/API/Model/CreateStory_Model/all_stories.dart';
import 'package:pds/API/Model/Delete_Api_model/delete_api_model.dart';
import 'package:pds/API/Model/FetchAllExpertsModel/FetchAllExperts_Model.dart';
import 'package:pds/API/Model/GetGuestAllPostModel/GetGuestAllPost_Model.dart';
import 'package:pds/API/Model/GetGuestAllPostModel/ShareAppOpenPostModel.dart';
import 'package:pds/API/Model/IsTokenExpired/IsTokenExpired.dart';
import 'package:pds/API/Model/System_Config_model/system_config_model.dart';
import 'package:pds/API/Model/acceptRejectInvitaionModel/accept_rejectModel.dart';
import 'package:pds/API/Model/acceptRejectInvitaionModel/getAllNotificationCount.dart';
import 'package:pds/API/Model/acceptRejectInvitaionModel/seenNotificationModel.dart';
import 'package:pds/API/Model/createStroyModel/createStroyModel.dart';
import 'package:pds/API/Model/getCountOfSavedRoomModel/getCountOfSavedRoomModel.dart';
import 'package:pds/API/Model/getall_compeny_page_model/getall_compeny_page.dart';
import 'package:pds/API/Model/like_Post_Model/like_Post_Model.dart';
import 'package:pds/API/Model/myaccountModel/myaccountModel.dart';
import 'package:pds/API/Model/saveBlogModel/saveBlog_Model.dart';

import '../../Model/Get_all_blog_Model/get_all_blog_model.dart';
import '../../Model/RePost_Model/RePost_model.dart';
import '../../Model/UserTagModel/UserTag_model.dart';

abstract class GetGuestAllPostState {}

class GetGuestAllPostLoadingState extends GetGuestAllPostState {}

class GetGuestAllPostInitialState extends GetGuestAllPostState {}

class GetGuestAllPostLoadedState extends GetGuestAllPostState {
  final GetGuestAllPostModel GetGuestAllPostRoomData;
  GetGuestAllPostLoadedState(this.GetGuestAllPostRoomData);
}

class GetGuestAllPostErrorState extends GetGuestAllPostState {
  final dynamic error;
  GetGuestAllPostErrorState(this.error);
}

class PostLikeLoadedState extends GetGuestAllPostState {
  final LikePost likePost;
  PostLikeLoadedState(this.likePost);
}

class FetchAllExpertsLoadedState extends GetGuestAllPostState {
  final FetchAllExpertsModel AllExperData;
  FetchAllExpertsLoadedState(this.AllExperData);
}

class GetAllStoryLoadedState extends GetGuestAllPostState {
  final GetAllStoryModel getAllStoryModel;
  GetAllStoryLoadedState(this.getAllStoryModel);
}

class CreateStoryLodedState extends GetGuestAllPostState {
  final CreateStroy createStroy;
  CreateStoryLodedState(this.createStroy);
}

class DeletePostLoadedState extends GetGuestAllPostState {
  final DeletePostModel DeletePost;
  DeletePostLoadedState(this.DeletePost);
}

class GetUserProfileLoadedState extends GetGuestAllPostState {
  final MyAccontDetails myAccontDetails;

  GetUserProfileLoadedState(this.myAccontDetails);
}

class GetallblogsLoadedState extends GetGuestAllPostState {
  final GetallBlogModel getallBlogdata;
  GetallblogsLoadedState(this.getallBlogdata);
}

class saveBlogLoadedState extends GetGuestAllPostState {
  final saveBlogModel saveBlogModeData;
  saveBlogLoadedState(this.saveBlogModeData);
}

class likeBlogLoadedState extends GetGuestAllPostState {
  final saveBlogModel LikeBlogModeData;
  likeBlogLoadedState(this.LikeBlogModeData);
}

class RePostLoadedState extends GetGuestAllPostState {
  final RePostModel RePost;
  RePostLoadedState(this.RePost);
}

class SystemConfigLoadedState extends GetGuestAllPostState {
  final SystemConfigModel SystemConfigModelData;
  SystemConfigLoadedState(this.SystemConfigModelData);
}

class UserTagLoadedState extends GetGuestAllPostState {
  final UserTagModel userTagModel;
  UserTagLoadedState(this.userTagModel);
}

class AutoEnterinLoadedState extends GetGuestAllPostState {
  final AutoEnterRoomModel AutoEnterinData;
  AutoEnterinLoadedState(this.AutoEnterinData);
}

class OpenSharePostLoadedState extends GetGuestAllPostState {
  final ShareAppOpenPostModel OpenSharePostData;
  OpenSharePostLoadedState(this.OpenSharePostData);
}

class GetNotificationCountLoadedState extends GetGuestAllPostState {
  final getAllNotificationCount GetNotificationCountData;
  GetNotificationCountLoadedState(this.GetNotificationCountData);
}

class OnlineChatStatusLoadedState extends GetGuestAllPostState {
  final accept_rejectModel accept_rejectModelData;
  OnlineChatStatusLoadedState(this.accept_rejectModelData);
}

class WatchTimeSaveLoadedState extends GetGuestAllPostState {
  final seenNotificationModel accept_rejectModelData;
  WatchTimeSaveLoadedState(this.accept_rejectModelData);
}

class Getallmasterreporttype extends GetGuestAllPostState {
  dynamic get_all_master_report_type;
  Getallmasterreporttype(this.get_all_master_report_type);
}

class Getallcompenypagelodedstate extends GetGuestAllPostState {
  final GetAllCompenyPageModel getallcompenypagemodel;
  Getallcompenypagelodedstate(this.getallcompenypagemodel);
}
