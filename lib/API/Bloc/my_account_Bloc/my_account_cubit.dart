
import 'package:archit_s_application1/API/Bloc/my_account_Bloc/my_account_state.dart';
import 'package:archit_s_application1/API/Model/myaccountModel/myaccountModel.dart';
import 'package:archit_s_application1/API/Repo/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAccountCubit extends Cubit<MyAccountState> {
  MyAccountCubit() : super(MyAccountInitialState()) {}
  Future<void> MyAccount(BuildContext context) async {
    dynamic myAccontDetails;
    try {
      emit(MyAccountLoadingState());
        myAccontDetails = await Repository().myAccount(    context);
      if (myAccontDetails.success == true) {
        emit(MyAccountLoadedState(myAccontDetails));
      }  
    } catch (e) {
      emit(MyAccountErrorState(myAccontDetails));
    }
  }

 
}
