
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/network/dio_helper.dart';
import '../../../../../core/network/end_points.dart';
import '../../../../model/product_model.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());
 Future<void>getAllProduct()async {
    try {
      emit(ProductLoading());
      final Response response = await DioHelper.getRequest(
          endPoint: AppEndPoints.product);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List products = response.data['products'];
        final productList = products.map((e) => ProductModel.fromJson(e)).toList();
        emit(ProductSuccess(productList));
      }
    }

    on DioException catch(e){
      emit(ProductFailure(e.toString()));

    }

    catch(e){
      emit(ProductFailure(e.toString()));
    }
  }

}
