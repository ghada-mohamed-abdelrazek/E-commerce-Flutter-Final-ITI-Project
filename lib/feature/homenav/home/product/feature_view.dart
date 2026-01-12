import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_project/core/resources/app_loading.dart';
import 'package:iti_final_project/feature/homenav/home/cubit/feature/feature_cubit.dart';
import 'package:iti_final_project/feature/homenav/home/details/feature_details.dart';
import 'package:iti_final_project/feature/widget/feature_item.dart';
import '../../../../core/resources/snack_bar.dart';

class FeatureScreen extends StatelessWidget {
  const FeatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      FeatureCubit()..getFeatureProduct(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 25,
          ),
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: CircleAvatar(
                          backgroundColor: Color(0xffF8F7F7),
                          child: Icon(Icons.arrow_back, color: Colors.black)),
                    ),
                    SizedBox(width: 80),
                    Text("Feature Products",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.black
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                BlocConsumer<FeatureCubit, FeatureState>(
                  listener: (context, state) {
                    if (state is FeatureFailure) {
                      showMySnackBar(
                        msg: "No Data Found",
                        type: AnimatedSnackBarType.error,
                        context: context,
                      );
                    }
                  },
                  builder: (context, state) {
                    if(state is FeatureLoading){
                      return AppLoading();
                    }
                    if (state is FeatureSuccess) {
                      return Expanded(
                        child: GridView.builder(

                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 10,
                                childAspectRatio:0.75

                            ),
                            itemCount: state.featuremodel.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          FeatureDetailsPage(featuremodel:state.featuremodel[index],)));
                                },
                                child: FeatureItem(
                                  productImg:state.featuremodel[index].image??"",
                                  productTitle:state.featuremodel[index].title??"",
                                  productPrice: (state.featuremodel[index].price??"").toString(),),
                              );
                            }),
                      );
                    }
                    return SizedBox();
                  },
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
