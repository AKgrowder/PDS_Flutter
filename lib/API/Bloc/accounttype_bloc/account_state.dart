import 'package:pds/API/Model/accountType/accountTypeModel.dart';

abstract class AccountState {}

class AccountLoadingState extends AccountState {}

class AccountInitialState extends AccountState {}

class AccountLoadedState extends AccountState {
   final AccountType accountType;
  AccountLoadedState(this.accountType);
}

class AccountErrorState extends AccountState {
  final dynamic error;
  AccountErrorState(this.error);
}

