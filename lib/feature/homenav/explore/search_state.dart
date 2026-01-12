part of 'search_cubit.dart';

abstract class SearchState {
  get productmodel => null;
}

final class SearchInitial extends SearchState {}
final class SearchLoading extends SearchState {}
final class SearchSuccess  extends SearchState {
  final List<ProductModel> productmodel;
  final int totalFound;

  SearchSuccess(this.productmodel,this.totalFound );
}
final class SearchFailure extends SearchState {
  final String errMsg;
  SearchFailure(this.errMsg);
}
