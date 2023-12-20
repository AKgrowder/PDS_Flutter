class Config {
  static const String somethingWentWrong =
      "Something Went Wrong, Try After Some Time.";
  static const String mobileNumberIsNotvaild = "Your Number is Not Register";
  // "your number is not vaild Please Enter correct Number";
  static const String servernotreachable =
      "Server Not Rechable, Try After Some Time.";
  static const String FetchAllPublicRoom = "guest/api/fetchAllPublicRoom";
  static const String CreateRoom = "guest/api/createRoom";
  static const String loginApi = "auth/auth/authenticate";
  static const String registerApi = "user/api/signup";
  static const String otpApi = "auth/auth/verifyOTP";
  static const String SendMSG = "guest/api/addMessageInRoom";
  static const String coomment = "guest/api/fetchInbox";
  static const String getUserDetails = "auth/auth/getMasterUserByUUID";
  static const String company = "user/api/addUserProfile";
  static const String FetchMyRoom = "user/api/fetchMyRoom";
  static const String createRoom1 = "user/api/createRoom";
  static const String inviteUser = "user/api/inviteUserToRoom";
  static const String fetchExprtise = "user/api/fetchExprtise";
  static const String addExport = "user/addExpertProfile";
  static const String Invitations = "user/api/getRoomInvitations";
  static const String fetchallmembers = "user/api/fetchAllMembers/";
  static const String editroom = "user/api/updateRoom";
  static const String acceptRejectInvitationAPI =
      "user/api/acceptRejectInvitation";
  static const String DeleteRoom = "user/api/room_closed_by_owner";
  static const String checkUserActive = "user/api/isForumCreated";
  static const String uploadfile = 'user/api/uploadFIle';
  static const String uploadProfile = 'user/api/uploadProfilePic';
  static const String addDeviceDetail = "auth/auth/addDeviceDetail";
  static const String fetchAllExperts = "user/api/fetchAllExperts";
  static const String myaccountApi = "user/api/fetchUserProfile";

  static const String systemconfig = "user/api/fetchSysConfig";
  static const String fetchUserModule = "user/api/fetchUserModule";
  static const String fetchRoomDetails = "user/api/fetchRoomDetails/";
  static const String forgetpassword = "user/api/forgotPassword/";
  static const String FetchPublicRoom = "guest/api/fetchOtherPublicRoom/";
  static const String fetchMyPublicRoom = "guest/api/fetchMyPublicRoom/";
  static const String updateUserProfile = "user/api/updateUserProfile";
  static const String changepassword = "auth/auth/changePassword";
  static const String changepasswordInSettingScrnee = "user/changeUserPassword";
  static const String logOut = "auth/auth/logoutByToken";
  static const String getallBlog = "guest/api/getAllBlog";
  static const String DeleteUser = "auth/auth/deleteForumUser/";
  static const String ReActivateUSer = "auth/auth/activeForumUser";
  static const String SelectRoomList = "user/api/fetchOwnerRoom";
  static const String loginerror = "Please Login With UserName";
  static const String RateUs = "guest/addRating";
  static const String emailVerifaction = "user/api/send_email_verify";
  static const String chatImageRoom = "user/sendImageInChat/";
  static const String unPin = "user/saveRoom";
  static const String unSavePin = "user/unsaveRoom";
  static const String getCountOfSavedRoom = "user/getCountOfSavedRoom";
  static const String AutoCheckINRoom = "user/api/member_joined_through_link/";
  static const String ViewDetails = "user/api/fetch_room_member_details";
  static const String RemoveUser = "user/api/member_exit_remove";
  static const String GuestGetAllPost = "guest/api/get_all_post";
  static const String UserGetAllPost = "user/api/get_all_post";
  static const String addPost = "user/api/add_post";
  static const String upload_data = "user/api/upload_data";
  static const String like_post = "user/api/like_post";
  static const String save_post = "user/api/save_post";
  static const String follow_user = "user/api/send_follow_request";
  static const String postLike = "Post unliked successfully";
  static const String GetPostAllLike = "user/api/get_all_likes";

  static const String Addcomments = "user/api/get_comments_on_post";
  //  static const String CreateStory = "user/api/create_story";
  static const String getcomments = "user/api/add_comment";
  static const String NewfetchUserProfile = "user/api/fetchUserProfile";
  static const String getAllStory = "user/api/get_all_story";
  static const String crateStroyCheck = "user/api/create_story";
  static const String industryType = "user/api/get_all_industry_types";
  static const String Deletepost = "user/api/delete_post";
  static const String GetAppPost = "user/api/get_all_posts_by_uid";
  static const String GetPostCommetAPI =
      "user/api/get_list_of_post_with_comments";
  static const String GetSavePostAPI = "user/api/get_all_saved_posts";
  static const String uploadStroy = "user/api/upload_story";
  static const String HashTagForYou = "user/api/hashtag_names_and_post_count";
  static const String HashTagView = "user/api/get_posts_by_hashtag";
  static const String getalluser = "user/api/get_all_user_list_for_hashtag";
  static const String add_update_about_me = "user/api/add_update_about_me";
  static const String get_about_me = "user/api/get_about_me";
  static const String get_all_request = "user/api/get_all_request";
  static const String accept_reject_follow_request =
      "user/api/accept_reject_follow_request";
  static const String HashTagBanner = "admin_portal/banners/latest";
  static const String deletecomment = "user/api/delete_comment_by_uid";

  static const String saveBlog = "guest/api/saveBlog";
  static const String LikeBlog = "guest/api/likeBlog";
  static const String getSavedBlogs = "guest/api/getSavedBlogs";
  static const String OpenSaveImagePost = "user/api/get_post_by_uid";
  static const String view_story = "user/api/view_story";
  static const String search_historyDataAdd =
      "user/api/add_hashtag_search_history";
  static const String get_hashtag_search_history =
      "user/api/get_hashtag_search_history";
  static const String PersonalChatList = "user/get_all_inbox_details";
  static const String StoryViewList = "user/api/story_view_details_of_user";
  static const String rePost = "user/api/add_repost";
  static const String get_all_followers = "user/api/get_all_followers";
  static const String get_all_followings = "user/api/get_all_followings";
  static const String remove_follower = "user/api/remove_follower";
  static const String SelectChatMember = "user/search_user_for_inbox";
  static const String validateTokenCheck = "auth/auth/validateTokenCheck";
  static const String logOutUserSttionExperied = "auth/auth/isTokenExpired";
  static const String roomExists = "user/api/assignAdminToOtherRoomMember";
  static const String search_user_for_inboxUrl = "user/search_user_for_inbox";
  static const String accountType = "user/api/change_account_type";
  static const String addExperience = "user/api/add_update_work_experience";
  static const String getExperience = "user/api/get_all_work_experiences";
  static const String deleteExperience = "user/api/delete_work_experience";
  static const String delete_story = "user/api/delete_story";
  static const String DMChatList = "user/get_inbox_messages";
  static const String get_all_hashtag = "user/api/get_all_hashtag";
  static const String blogComment = "user/api/get_all_comment_on_blog";
  static const String addBlogcomments = "user/api/add_comment_on_blog";
  static const String deleteBlogcomment = "user/api/delete_blog_comment_by_uid";
  static const String blogLikeList = "user/api/get_all_blog_likes";
  static const String create_user_chat = "user/create_user_chat";
  static const String get_UsersChatByUsername = "user/get_UsersChatByUsername";
  static const String userTag = "user/api/get_uuid_by_username";
  static const String selectMultipleUsers_Chat =
      "user/selectMultipleUsers_Chat";
  static const String chatImageDM = "user/send_image_in_user_chat"; // ankur 

}
