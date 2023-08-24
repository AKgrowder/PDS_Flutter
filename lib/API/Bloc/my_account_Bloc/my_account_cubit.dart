
import 'package:archit_s_application1/API/Bloc/my_account_Bloc/my_account_state.dart';
import 'package:archit_s_application1/API/Model/myaccountModel/myaccountModel.dart';
import 'package:archit_s_application1/API/Repo/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAccountCubit extends Cubit<MyAccountState> {
  MyAccountCubit() : super(MyAccountInitialState()) {}
  Future<void> MyAccount() async {
    try {
      emit(MyAccountLoadingState());
      MyAccontDetails myAccontDetails = await Repository().myAccount();
      if (myAccontDetails.success == true) {
        emit(MyAccountLoadedState(myAccontDetails));
      } else {
        emit(MyAccountErrorState(myAccontDetails.message.toString()));
      }
    } catch (e) {
      emit(MyAccountErrorState(e.toString()));
    }
  }

 
}
