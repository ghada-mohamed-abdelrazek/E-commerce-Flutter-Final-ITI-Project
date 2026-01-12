import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_project/core/resources/app_color.dart';
import 'package:iti_final_project/feature/homenav/cart/cart_cubit.dart';
import 'package:iti_final_project/feature/homenav/cart/view.dart';
import 'package:iti_final_project/feature/model/cart_model.dart';
import 'package:iti_final_project/feature/model/feature_model.dart';


class FeatureDetailsPage extends StatefulWidget {
  const FeatureDetailsPage({super.key, required this.featuremodel});
  final FeatureModel featuremodel ;

  @override
  State<FeatureDetailsPage> createState() => _FeatureDetailsPageState();
}

class _FeatureDetailsPageState extends State<FeatureDetailsPage> {
  bool isFavorite = false;
  final List<String> sizes = ["8", "10", "38", "40"];
  int selectedSizeIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  // Top Image
                  Expanded(
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.network(
                            widget.featuremodel.image??"",
                          ),
                        ),

                        // Back button
                        Positioned(
                          top: 50,
                          left: 16,
                          child:GestureDetector(
                            child: CircleAvatar(
                                backgroundColor: Color(0xffD3D0D0),
                                child: Icon(Icons.arrow_back)),
                            onTap: () => Navigator.pop(context),
                          ),
                        ),
                        // Heart button
                        Positioned(
                          top: 50,
                          right: 16,
                          child:GestureDetector(
                            onTap: () {
                              setState(() {
                                isFavorite = !isFavorite;
                              });
                            },
                            child: CircleAvatar(
                              backgroundColor: Color(0xffD3D0D0),

                              child: Icon(
                                isFavorite ? Icons.favorite : Icons.favorite_border,
                                color: isFavorite ? Colors.red.shade900 : Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title + Price
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.featuremodel.title ?? "",
                                  style:  TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Text(
                                "\$${widget.featuremodel.price ?? 0.00}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.primaryColor,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 10),

                          // Rating row
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 22),
                              SizedBox(width: 6),
                              Text(
                                "${widget.featuremodel.rating ?? 0.00}",
                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                              ),
                              SizedBox(width: 8),
                              Text(
                                "((${widget.featuremodel.rating?.count} reviews)  Review)",
                                style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),

                          SizedBox(height: 18),

                          Text(
                            "Description",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                          ),
                          SizedBox(height: 8),
                          Text(
                            widget.featuremodel.description ?? "No description available",
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              height: 1.35,
                            ),
                          ),

                          SizedBox(height: 18),

                          Text(
                            "Size",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                          ),
                          SizedBox(height: 10),

                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: List.generate(sizes.length, (i) {
                              final selected = i == selectedSizeIndex;
                              return GestureDetector(
                                onTap: () => setState(() => selectedSizeIndex = i),
                                child: Container(
                                  width: 54,
                                  height: 44,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: selected
                                          ? AppColor.primaryColor
                                          : Colors.grey.shade300,
                                      width: 1.2,
                                    ),
                                  ),
                                  child: Text(
                                    sizes[i],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: selected
                                          ? AppColor.primaryColor
                                          : Colors.black87,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),

                          SizedBox(height: 20),

                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 54,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(28),
                                      ),
                                      elevation: 0,
                                    ),
                                    onPressed: () {
                                      context.read<CartCubit>().addToCart(CartProduct.fromFeature(widget.featuremodel));
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Added to cart!'),
                                          duration: Duration(seconds: 2),
                                          backgroundColor: AppColor.primaryColor,
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "Buy Now",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                height: 54,
                                width: 64,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(28),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    context.read<CartCubit>().addToCart(CartProduct.fromFeature(widget.featuremodel));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Added to cart!'),
                                        duration: Duration(seconds: 2),
                                        backgroundColor: AppColor.primaryColor,
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.shopping_bag_outlined,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

