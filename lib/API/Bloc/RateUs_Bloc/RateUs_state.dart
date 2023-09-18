 
import 'package:pds/API/Model/RateUseModel/Rateuse_model.dart';

abstract class RateUSState {}

class RateUSLoadingState extends RateUSState {}

class RateUSInitialState extends RateUSState {}

class RateUSLoadedState extends RateUSState {
  final RateUsModel rateUsData;
  //  List<BannerModel> bannerImg;

  RateUSLoadedState(
    this.rateUsData,
    // this.bannerImg,
  );
}

class RateUSErrorState extends RateUSState {
  final String error;
  RateUSErrorState(this.error);
}