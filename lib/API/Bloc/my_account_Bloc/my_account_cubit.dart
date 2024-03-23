import 'dart:io';
import 'package:pds/API/Bloc/my_account_Bloc/my_account_state.dart';
import 'package:pds/API/Repo/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAccountCubit extends Cubit<MyAccountState> {
  MyAccountCubit() : super(MyAccountInitialState()) {}
  Future<void> MyAccount(BuildContext context) async {
    dynamic myAccontDetails;
    try {
      emit(MyAccountLoadingState());
      myAccontDetails = await Repository().myAccount(context);
      if (myAccontDetails == "Something Went Wrong, Try After Some Time.") {
        emit(MyAccountErrorState("${myAccontDetails}"));
      } else {
        if (myAccontDetails.success == true) {
          emit(MyAccountLoadedState(myAccontDetails));
        }
      }
    } catch (e) {
      emit(MyAccountErrorState(myAccontDetails));
    }
  }

  Future<void> upoldeProfilePic(File imageFile, BuildContext context) async {
    print('thsi upoldeProfilePic');
    dynamic chooseDocument;
    try {
      emit(MyAccountLoadingState());
      chooseDocument = await Repository().userProfile(imageFile, context);
      if (chooseDocument == "Something Went Wrong, Try After Some Time.") {
        emit(MyAccountErrorState("${chooseDocument}"));
      } else {
        if (chooseDocument.success == true) {
          emit(chooseDocumentLoadedState(chooseDocument));
        } else {
          emit(chooseDocumentLoadedState(chooseDocument));
        }
      }
    } catch (e) {
      print('LoginScreen-${e.toString()}');
      emit(MyAccountErrorState(chooseDocument));
    }
  }

  Future<void> upoldeProfilePic1(File imageFile, BuildContext context) async {
    print('thsi cover image');
    dynamic chooseDocument;
    try {
      emit(MyAccountLoadingState());
      chooseDocument =
          await Repository().userProfileprofileCover(imageFile, context);
      if (chooseDocument == "Something Went Wrong, Try After Some Time.") {
        emit(MyAccountErrorState("${chooseDocument}"));
      } else {
        if (chooseDocument.success == true) {
          emit(chooseDocumentLoadedState1(chooseDocument));
        } else {
          emit(chooseDocumentLoadedState1(chooseDocument));
        }
      }
    } catch (e) {
      print('LoginScreen-${e.toString()}');
      emit(MyAccountErrorState(chooseDocument));
    }
  }

  Future<void> fetchExprties(BuildContext context) async {
    dynamic fetchExprtise;
    try {
      emit(MyAccountLoadingState());
      fetchExprtise = await Repository().fetchExprtise(context);
      if (fetchExprtise == "Something Went Wrong, Try After Some Time.") {
        emit(MyAccountErrorState("${fetchExprtise}"));
      } else {
        if (fetchExprtise.success == true) {
          emit(FetchExprtiseRoomLoadedState(fetchExprtise));
        }
      }
    } catch (e) {
      emit(MyAccountErrorState(fetchExprtise));
    }
  }

  Future<void> chooseDocumentprofile(
      String file, String fileName, BuildContext context) async {
    print('if this function');
    dynamic createForm;
    try {
      emit(MyAccountLoadingState());
      createForm =
          await Repository().chooseProfileFile2(file, fileName, context);
      print('createFormDataCheck-${createForm.message}');
      if (createForm == "Something Went Wrong, Try After Some Time.") {
        emit(MyAccountErrorState("${createForm}"));
      } else {
        if (createForm.success == true) {
          print('createFormdataGet-----${createForm.object}');
          emit(chooseDocumentLoadedState2(createForm));
        }
      }
    } catch (e) {
      print('error data-$e');
      emit(MyAccountErrorState(createForm));
    }
  }

  Future<void> addExpertProfile(params, BuildContext context) async {
    dynamic fetchExprtise;
    try {
      emit(MyAccountLoadingState());
      fetchExprtise = await Repository().addEXpertAPiCaling(params, context);
      print("sddgfdgsfgfg-${fetchExprtise.message}");
      if (fetchExprtise == "Something Went Wrong, Try After Some Time.") {
        emit(MyAccountErrorState("${fetchExprtise}"));
      } else {
        if (fetchExprtise.success == true) {
          emit(AddExportLoadedState(fetchExprtise));
        }else{
           emit(UserExistLoadedState(fetchExprtise.message));
        }
      }
    } catch (e) {
      emit(MyAccountErrorState(fetchExprtise));
    }
  }

  Future<void> cretaForumUpdate(
      Map<String, dynamic> params, BuildContext context,
      {String? apiname}) async {
    dynamic createForm;
    try {
      emit(MyAccountLoadingState());
      createForm = await Repository().cretaForumUpdate(params, context);
      print("creadfhd-${createForm.message}");
      if (createForm == "Something Went Wrong, Try After Some Time.") {
        emit(MyAccountErrorState("${createForm}"));
      } else {
        if (createForm.success == true) {
          emit(CreatFourmLoadedState(createForm));
        } else {
          print("ddfgdfgffg-${createForm} ");
          emit(UserExistLoadedState(createForm.message));
        }
      }
    } catch (e) {
      print("e --$e");
      emit(MyAccountErrorState(createForm));
    }
  }

  Future<void> UpdateProfileEmployee(
      Map<String, dynamic> params, BuildContext context) async {
    dynamic updateProfile;
    try {
      emit(MyAccountLoadingState());
      updateProfile = await Repository().employeeApiUpdate(params, context);
      if (updateProfile == "Something Went Wrong, Try After Some Time.") {
        emit(MyAccountErrorState("${updateProfile}"));
      } else {
        if (updateProfile.success == true) {
          emit(UpdateProfileLoadedState(updateProfile));
        }else{
           emit(UserExistLoadedState(updateProfile.message));
        }
      }
    } catch (e) {
      emit(MyAccountErrorState(updateProfile));
    }
  }

  Future<void> emailVerifaction(BuildContext context, String email) async {
    dynamic emailVerifaction;
    try {
      emit(MyAccountLoadingState());
      emailVerifaction = await Repository().emailVerifaction(context, email);
      if (emailVerifaction == "Something Went Wrong, Try After Some Time.") {
        emit(MyAccountErrorState("${emailVerifaction}"));
      } else {
        if (emailVerifaction.success == true) {
          emit(EmailVerifactionLoadedState(emailVerifaction));
        }
      }
    } catch (e) {
      emit(MyAccountErrorState(emailVerifaction));
    }
  }

  Future<void> IndustryTypeAPI(BuildContext context) async {
    dynamic industryType;
    try {
      emit(MyAccountLoadingState());
      industryType = await Repository().IndustryType(context);
      if (industryType == "Something Went Wrong, Try After Some Time.") {
        emit(MyAccountErrorState("${industryType}"));
      } else {
        if (industryType.success == true) {
          emit(IndustryTypeLoadedState(industryType));
        }
      }
    } catch (e) {
      emit(MyAccountErrorState(industryType));
    }
  }
}
