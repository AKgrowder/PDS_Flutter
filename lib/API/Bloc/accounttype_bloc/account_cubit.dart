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
      if(accounType.success == true){
        emit(AccountLoadedState(accounType));
      }
    } catch (e) {
      emit(AccountErrorState(e.toString()));
    }
  }
}
