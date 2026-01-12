import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_project/core/resources/app_color.dart';
import 'package:iti_final_project/feature/homenav/explore/search_cubit.dart';

import '../../../../core/resources/app_loading.dart';
import '../../../../core/resources/snack_bar.dart';
import '../../../widget/product_item.dart';
import '../../home/cubit/product/product_cubit.dart';
import '../../home/details/item_details.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({super.key, this.query});

  final query;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit()..search(query: query.trim()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: CircleAvatar(
                  backgroundColor: Color(0xffF8F7F7),
                  child: Icon(Icons.arrow_back, color: Colors.black)),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 25,
          ),
          child: BlocConsumer<SearchCubit, SearchState>(
            listener: (context, state) {
              if (state is SearchFailure) {
                showMySnackBar(
                  msg: "No Data Found",
                  type: AnimatedSnackBarType.error,
                  context: context,
                );
              }
            },
            builder: (context, state) {
              if(state is SearchLoading){
                return AppLoading();
              }
              if (state is SearchSuccess) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Text("Results for ",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize:14,
                              color: Color(0xff817F7F)
                          ),
                        ),
                        Text(" $query",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Colors.black
                          ),
                        ),
                        Spacer(),
                        Text(" ${state.totalFound} Results Found ",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize:14,
                              color: AppColor.primaryColor
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 20),
                    Expanded(
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
                    ),
                  ],
                );
              }
              return SizedBox();

            },
          ),
        ),
      ),
    );
  }
}
