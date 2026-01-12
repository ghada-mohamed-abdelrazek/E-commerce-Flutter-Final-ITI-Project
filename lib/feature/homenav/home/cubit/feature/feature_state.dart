part of 'feature_cubit.dart';

abstract class FeatureState {}

final class FeatureInitial extends FeatureState {}
final class FeatureLoading extends FeatureState {}
final class FeatureSuccess extends FeatureState {
  List <FeatureModel> featuremodel;
  FeatureSuccess(this.featuremodel);

}
final class FeatureFailure extends FeatureState {
  final String errMsg;
  FeatureFailure(this.errMsg);
}
