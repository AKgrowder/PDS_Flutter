

abstract class CommenClassState {}

class CommenClassLoadingState extends CommenClassState {}

class CommenClassInitialState extends CommenClassState {}

class CommenClassLoadedState extends CommenClassState {

  CommenClassLoadedState();
}

class CommenClassErrorState extends CommenClassState {
  final dynamic error;
  CommenClassErrorState(this.error);
}
