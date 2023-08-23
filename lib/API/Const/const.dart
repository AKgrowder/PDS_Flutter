class Config {



  static const String somethingWentWrong = "Something Went Wrong";
  static const String servernotreachable =
      "Servar Not Rechable, Try After Some Time.";




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
  static const String createRoom = "user/api/createRoom";
  static const String inviteUser = "user/api/inviteUserToRoom";
  static const String fetchExprtise = "user/api/fetchExprtise";
  static const String addExport = "user/addExpertProfile";
  static const String Invitations = "user/api/getRoomInvitations";
  static const String fetchallmembers = "user/api/fetchAllMembers/";
  static const String editroom = "user/api/updateRoom";
  static const String acceptRejectInvitationAPI =
      "user/api/acceptRejectInvitation";
  static const String DeleteRoom = "user/api/deleteRoom";
  static const String checkUserActive = "user/api/isForumCreated";
  static const String uploadfile = 'user/api/uploadFIle';
  static const String uploadProfile= 'user/api/uploadProfilePic';
   static const String addDeviceDetail = "auth/auth/addDeviceDetail";
  static const String fetchAllExperts = "user/api/fetchAllExperts";
}
