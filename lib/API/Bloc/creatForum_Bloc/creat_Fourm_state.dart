
 
import '../../Model/creat_form/creat_form_Model.dart';

abstract class CreatFourmState {}

class CreatFourmLoadingState extends CreatFourmState {}

class CreatFourmInitialState extends CreatFourmState {}

class CreatFourmLoadedState extends CreatFourmState {
  final CreateForm createForm;
  CreatFourmLoadedState(this.createForm);
}

class CreatFourmErrorState extends CreatFourmState {
  final String error;
  CreatFourmErrorState(this.error);
}
