// import 'package:animated_snack_bar/animated_snack_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../core/resources/app_loading.dart';
// import '../../../../core/resources/app_text_style.dart';
// import '../../../../core/resources/snack_bar.dart';
// import '../../../model/category_model.dart';
// import '../cubit/category/category_cubit.dart';
//
// class CategoriesScreen extends StatelessWidget {
//   const CategoriesScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => CategoryCubit()..getCategories(),
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           title: Text(
//             'Categories',
//             style: AppTextStyle.primaryStyle,
//           ),
//         ),
//         body: BlocConsumer<CategoryCubit, CategoryState>(
//           listener: (context, state) {
//             if (state is CategoryFailure) {
//               showMySnackBar(
//                 msg: state.error,
//                 type: AnimatedSnackBarType.error,
//                 context: context,
//               );
//             }
//           },
//           builder: (context, state) {
//             if (state is CategoryLoading) {
//               return AppLoading();
//             }
//
//             if (state is CategorySuccess) {
//               return GridView.builder(
//                 padding: EdgeInsets.all(16),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 16,
//                   mainAxisSpacing: 16,
//                   childAspectRatio: 0.85,
//                 ),
//                 itemCount: state.categories.length,
//                 itemBuilder: (context, index) {
//                   final category = state.categories[index];
//                   return CategoryCard(
//                     category: category,
//                   );
//                 },
//               );
//             }
//
//             return SizedBox();
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class CategoryCard extends StatelessWidget {
//   final CategoryModel category;
//
//   const CategoryCard({
//     Key? key,
//     required this.category,
//   }) : super(key: key);
//
//   //
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<String>(
//       future: _getFirstProductImage(),
//       builder: (context, snapshot) {
//         return GestureDetector(
//           onTap: () {
//             // Navigate to category products
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => CategoryProductsScreen(
//                   categorySlug: category.slug,
//                   categoryName: category.name,
//                 ),
//               ),
//             );
//           },
//           child: Container(
//             decoration: BoxDecoration(
//               color: Color(0xffF8F7F7),
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // Image Container
//                 Expanded(
//                   child: Container(
//                     margin: EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       color: Colors.white,
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(12),
//                       child: snapshot.hasData && snapshot.data!.isNotEmpty
//                           ? Image.network(
//                         snapshot.data!,
//                         fit: BoxFit.cover,
//                         width: double.infinity,
//                         errorBuilder: (context, error, stackTrace) {
//                           return _buildPlaceholder();
//                         },
//                         loadingBuilder: (context, child, loadingProgress) {
//                           if (loadingProgress == null) return child;
//                           return Center(
//                             child: CircularProgressIndicator(
//                               valueColor: AlwaysStoppedAnimation<Color>(
//                                 AppColor.primaryColor,
//                               ),
//                             ),
//                           );
//                         },
//                       )
//                           : _buildPlaceholder(),
//                     ),
//                   ),
//                 ),
//
//                 // Category Name
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
//                   child: Text(
//                     category.name,
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black87,
//                     ),
//                     textAlign: TextAlign.center,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildPlaceholder() {
//     return Center(
//       child: Icon(
//         Icons.category_outlined,
//         size: 48,
//         color: Colors.grey[400],
//       ),
//     );
//   }
// }