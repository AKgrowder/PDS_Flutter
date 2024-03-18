import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/Comapny_Manage_bloc/Comapny_Manage_state.dart';
import 'package:pds/API/Repo/repository.dart';

class ComapnyManageCubit extends Cubit<ComapnyManageState> {
  ComapnyManageCubit() : super(ComapnyManageInitialState()) {}
  Future<void> upoldeProfilePic(File imageFile, BuildContext context) async {
    print('thsi upoldeProfilePic');
    dynamic chooseDocument;
    try {
      emit(ComapnyManageLoadingState());
      chooseDocument = await Repository().userProfile(imageFile, context);
      if (chooseDocument == "Something Went Wrong, Try After Some Time.") {
        emit(ComapnyManageErrorState("${chooseDocument}"));
      } else {
        if (chooseDocument.success == true) {
          emit(chooseDocumentLoadedState(chooseDocument));
        } else {
          emit(ComapnyManageErrorState(chooseDocument));
        }
      }
    } catch (e) {
      print('LoginScreen-${e.toString()}');
      emit(ComapnyManageErrorState(chooseDocument));
    }
  }

  Future<void> compenypageuplod(
      Map<String, dynamic> params, BuildContext context) async {
    dynamic compenypagee;
    try {
      emit(ComapnyManageLoadingState());
      compenypagee = await Repository().compenypage(params, context);
      print("sddgfdgsfgfg-${compenypagee.message}");
      if (compenypagee == "Something Went Wrong, Try After Some Time.") {
        emit(ComapnyManageErrorState("${compenypagee}"));
      } else {
        if (compenypagee.success == true) {
          emit(compenypagelodedstate(compenypagee));
        } else {
          emit(ComapnyManageErrorState(compenypagee.message));
        }
      }
    } catch (e) {
      emit(ComapnyManageErrorState(compenypagee));
    }
  }

  Future<void> getallcompenypagee(BuildContext context) async {
    dynamic getallcompenypagee;
    try {
      emit(ComapnyManageLoadingState());
      getallcompenypagee = await Repository().getallcompenypage(context);
      print("sddgfdgsfgfg-${getallcompenypagee.message}");
      if (getallcompenypagee == "Something Went Wrong, Try After Some Time.") {
        emit(ComapnyManageErrorState("${getallcompenypagee}"));
      } else {
        if (getallcompenypagee.success == true) {
          emit(Getallcompenypagelodedstate(getallcompenypagee));
        } else {
          emit(ComapnyManageErrorState(getallcompenypagee.message));
        }
      }
    } catch (e) {
      emit(ComapnyManageErrorState(getallcompenypagee));
    }
  }

  Future<void> deletecompenypagee(BuildContext context, String pageUid) async {
    dynamic deletcomnyaPage;
    try {
      emit(ComapnyManageLoadingState());
      deletcomnyaPage = await Repository().delete_company_pages(
        pageUid,
        context,
      );
      print("sddgfdgsfgfg-${deletcomnyaPage.message}");

      if (deletcomnyaPage.success == true) {
        emit(CompnayDeletPageState(deletcomnyaPage));
      } else {
        emit(CompnayDeletPageState(deletcomnyaPage.message));
      }
    } catch (e) {
      emit(ComapnyManageErrorState(e.toString()));
    }
  }

  Future<void> getAllCompnayType(BuildContext context) async {
    dynamic getAllCompnayTypedataGet;
    try {
      emit(ComapnyManageLoadingState());
      getAllCompnayTypedataGet = await Repository().get_all_company_type(
        context,
      );
      print("sddgfdgsfgfg-${getAllCompnayTypedataGet.message}");

      if (getAllCompnayTypedataGet.success == true) {
        emit(GetAllCompanyTypeGet(getAllCompnayTypedataGet));
      }
    } catch (e) {
      emit(ComapnyManageErrorState(e.toString()));
    }
  }
}
