import 'package:pds/API/Model/accountType/accountTypeModel.dart';
import 'package:pds/API/Model/get_assigned_users_of_company_pageModel/get_assigned_users_of_company_pageModel.dart';

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


class GetAssignedUsersOfCompanyPageLoadedState extends AccountState {
  final GetAssignedUsersOfCompanyPage getAssignedUsersOfCompanyPage;
  GetAssignedUsersOfCompanyPageLoadedState(this.getAssignedUsersOfCompanyPage);
}



