import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_project/core/resources/app_loading.dart';
import 'package:iti_final_project/feature/homenav/home/cubit/product/product_cubit.dart';
import 'package:iti_final_project/feature/widget/product_item.dart';

import '../../../../core/resources/snack_bar.dart';
import '../details/item_details.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      ProductCubit()
        ..getAllProduct(),
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
                    SizedBox(width: 100),
                    Text("Products",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.black
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                BlocConsumer<ProductCubit, ProductState>(
                  listener: (context, state) {
                    if (state is ProductFailure) {
                      showMySnackBar(
                        msg: "No Data Found",
                        type: AnimatedSnackBarType.error,
                        context: context,
                      );
                    }
                  },
                  builder: (context, state) {
                    if(state is ProductLoading){
                      return AppLoading();
                    }
                    if (state is ProductSuccess) {
                      return Expanded(
                        child: GridView.builder(

                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio:0.8

                            ),
                            itemCount: state.productmodel.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDetailsPage(productmodel:state.productmodel[index],)));
                                },
                                child: ProductItem(
                                  productImg:state.productmodel[index].images?.isNotEmpty == true
                                      ? state.productmodel[index].images![0]
                                      : '',
                                  productTitle:state.productmodel[index].title??"",
                                  productPrice: (state.productmodel[index].price??"").toString(),),
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
