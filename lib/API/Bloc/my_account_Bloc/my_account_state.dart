import 'package:archit_s_application1/API/Model/myaccountModel/myaccountModel.dart';

abstract class MyAccountState {}

class MyAccountLoadingState extends MyAccountState {}

class MyAccountInitialState extends MyAccountState {}

class MyAccountLoadedState extends MyAccountState {
  final MyAccontDetails myAccontDetails;
  MyAccountLoadedState(this.myAccontDetails);
}

class MyAccountErrorState extends MyAccountState {
  final String error;
  MyAccountErrorState(this.error);
}
