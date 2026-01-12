import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_project/core/network/end_points.dart';
import 'package:iti_final_project/core/network/fake_dio_helper.dart';
import 'package:iti_final_project/feature/model/feature_model.dart';
part 'feature_state.dart';

class FeatureCubit extends Cubit<FeatureState> {
  FeatureCubit() : super(FeatureInitial());
  getFeatureProduct()async {
    try {
      emit(FeatureLoading());
      final Response response = await DioHelperFake.getRequest(
          endPoint: AppEndPoints.productFeature);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final list =List <FeatureModel>.from((
            response.data as List
        ).map((e)=>FeatureModel.fromJson(e)));
        emit(FeatureSuccess(list));
      }
    }

    on DioException catch(e){
      emit(FeatureFailure(e.toString()));

    }

    catch(e){
      emit(FeatureFailure(e.toString()));
    }
  }

}
