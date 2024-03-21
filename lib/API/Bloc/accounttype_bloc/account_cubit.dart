import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pds/API/Bloc/accounttype_bloc/account_state.dart';

import '../../Repo/repository.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountInitialState()) {}
  Future<void> accountTypeApi(String accountType, BuildContext context) async {
    dynamic accounType;
    try {
      emit(AccountLoadingState());
      accounType = await Repository().accountTypeMethod(accountType, context);
      if (accounType.success == true) {
        emit(AccountLoadedState(accounType));
      }
    } catch (e) {
      emit(AccountErrorState(e.toString()));
    }
  }

  Future<void> get_assigned_users_of_company_pageApi(
      String companyPageUid, BuildContext context) async {
    dynamic getAssingDataGet;
    try {
      emit(AccountLoadingState());
      getAssingDataGet = await Repository()
          .get_assigned_users_of_company_page(context, companyPageUid);
      if (getAssingDataGet.success == true) {
        emit(GetAssignedUsersOfCompanyPageLoadedState(getAssingDataGet));
      }
    } catch (e) {
      emit(AccountErrorState(e.toString()));
    }
  }
}
