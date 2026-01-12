
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/dio_helper.dart';
import '../../../core/network/end_points.dart';
import '../../model/product_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  Future<void> search({required String query}) async {
    try {
      emit(SearchLoading());
      final Response response = await DioHelper.getRequest(
          endPoint: AppEndPoints.search,
         queryParameters: {"q": query},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List products = (response.data['products'] as List?) ?? [];
        final productList = products.map((e) => ProductModel.fromJson(e)).toList();
        final int total = response.data['total'] ?? 0;
        emit(SearchSuccess(productList,total));
      }
    }
    on DioException catch(e){
      emit(SearchFailure(e.toString()));

    }

    catch(e){
      emit(SearchFailure(e.toString()));
    }

  }
}


