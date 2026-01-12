import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iti_final_project/core/resources/app_images.dart';
import 'package:iti_final_project/core/resources/snack_bar.dart';
import 'package:iti_final_project/feature/homenav/explore/view.dart';
import 'package:iti_final_project/feature/homenav/home/cubit/feature/feature_cubit.dart';
import 'package:iti_final_project/feature/homenav/home/cubit/product/product_cubit.dart';
import 'package:iti_final_project/feature/homenav/home/cubit/user/user_cubit.dart';
import 'package:iti_final_project/feature/homenav/home/details/feature_details.dart';
import 'package:iti_final_project/feature/homenav/home/product/feature_view.dart';
import 'package:iti_final_project/feature/homenav/home/product/view.dart';

import '../../../core/resources/app_color.dart';
import '../../../core/resources/app_loading.dart';
import '../../../core/resources/app_text_style.dart';
import '../../widget/card_item.dart';
import '../explore/searchResult/view.dart';
import 'details/item_details.dart';

class HomeSrceen extends StatefulWidget {
  const HomeSrceen ({super.key});
  @override
  State<HomeSrceen> createState() => _HomeSrceenState();
}

class _HomeSrceenState extends State<HomeSrceen> {
  int currentIndex = 0;
  final _totalDots = 4;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
  providers: [
    BlocProvider(
  create: (context) => ProductCubit()..getAllProduct(),
),
    BlocProvider(
      create: (context) => FeatureCubit()..getFeatureProduct(),
    ),
    BlocProvider(
      create: (context) => UserCubit()..getUser(3),
    ),
  ],
  child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation:0,
        leadingWidth: 0,
        title: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor:Color(0xffF8F7F7) ,
            child:ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network("https://i.imgur.com/LDOO4Qs.jpg")),
            
          ),
          title: Text("Hello !" , style: AppTextStyle.primaryTitleStyle,),
          subtitle: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserFailure) {
              return Center(child: Text(state.message));
            }
            if (state is UserSuccess) {
              final user = state.user;
              final first = user.name?.firstname ?? "User";
              final last = user.name?.lastname ?? "";
              final fullName = "$first $last".trim();
              return Text(fullName , style: AppTextStyle.primaryStyle,);
            }
            return SizedBox();
  },
),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CircleAvatar(
              backgroundColor:Color(0xffF8F7F7) ,
              child: SvgPicture.asset(AppImages.notify),
            )
          )
        ],
      ),
      body:SingleChildScrollView(
          physics:ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                    fillColor: Color(0xffF8F7F7),
                    filled: true,
                    prefixIcon: GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SearchScreen(showBackButton: true,)));
                        },child: Icon(Icons.search)),
                    hint: Text("Search here",style: AppTextStyle.secondaryStyleAsk,),
                    enabledBorder:OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.transparent
                        ),
                        borderRadius: BorderRadius.circular(25)
                    ),
                    focusedBorder:OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.transparent
                        ),
                        borderRadius: BorderRadius.circular(25)
                    )
                ),
                onSubmitted: (value){
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => SearchResult(query: value)
                      )
                  );
                },
              ),
            ),

            CarouselSlider(
              options: CarouselOptions(
                  height: 180,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(microseconds:800 ),
                enlargeCenterPage: true,
                aspectRatio: 16/9,
                // viewportFraction: 0.8,
                onPageChanged: (index,reason){
                    setState(() {
                      currentIndex=index;
                    });
                }

              ),

              items: [1, 2, 3, 4].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: 500,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      margin: EdgeInsets.symmetric(
                          horizontal: 8
                      ),
                      decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Row(
                        spacing:3,
                        children: [
                             Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Get Winter Discount', style: TextStyle(fontSize: 14 , color: Colors.white, fontWeight: FontWeight.w600)),
                                Text('20% OFF', style: TextStyle(fontSize: 24 , color: Colors.white,fontWeight: FontWeight.w600)),
                                Text('For children', style: TextStyle(fontSize: 20 , color: Colors.white,fontWeight: FontWeight.w600)),
                              ],
                            ),
                          Spacer(),
                          Image.asset(AppImages.background,
                            width: 89,
                            height: 150,
                            fit:BoxFit.fitHeight ,
                          ),
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            SizedBox( height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DotsIndicator(
                  dotsCount: 4,
                  position: currentIndex.toDouble(),
                  decorator: DotsDecorator(
                    activeColor: AppColor.primaryColor,
                    color: Colors.grey.shade300,
                    size: const Size.square(8.0),
                    activeSize: const Size(18.0, 8.0),
                    activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Featured",
                    style: AppTextStyle.primaryStyle,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FeatureScreen()));
                    },
                    child: Text(
                      "See All",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff6055D8)
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
                  return SizedBox(
                    height: 200,
                    child: ListView.builder(
                        itemCount: state.featuremodel.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, int index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        FeatureDetailsPage(featuremodel:state.featuremodel[index],)));
                              },
                              child: CardItem(
                                productImg:state.featuremodel[index].image??"",
                                productTitle:state.featuremodel[index].title??"",
                                productPrice: (state.featuremodel[index].price??"").toString(),
                              ));
                        }),
                  );
                }
                return SizedBox();
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Most Popular",
                    style: AppTextStyle.primaryStyle,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductScreen()));
                    },
                    child: Text(
                      "See All",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff6055D8)
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
                  return SizedBox(
                    height: 200,
                    child: ListView.builder(
                        itemCount: state.productmodel.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, int index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        ProductDetailsPage(productmodel: state.productmodel[index],)));
                              },
                              child: CardItem(
                                productImg:state.productmodel[index].images?.isNotEmpty == true
                                    ? state.productmodel[index].images![0]
                                    : '',
                                productTitle:state.productmodel[index].title??"",
                                productPrice: (state.productmodel[index].price??"").toString(),
                              ));
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
);
  }
}