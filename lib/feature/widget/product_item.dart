import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_project/core/resources/app_color.dart';
import '../../core/resources/app_text_style.dart';
import '../homenav/cart/cart_cubit.dart';
import '../model/cart_model.dart';


class ProductItem extends StatefulWidget {
  const ProductItem({super.key, required this.productImg, required this.productTitle, required this.productPrice,});
  final String productImg;
  final String productTitle;
  final String productPrice;

  @override
  State<ProductItem> createState() => _ProductItemState();

}

class _ProductItemState extends State<ProductItem> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 100,
      margin: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColor.background,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(8),
            bottomLeft: Radius.circular(8)
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        spacing: 4,
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),

            ),
            child: Stack(
              children: [
                SizedBox(
                  height: 110,
                  child: Image.network(
                    widget.productImg,
                    width: 140,
                  ),
                ),
                Positioned(
                  top: 5,
                  right:5 ,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red.shade900 : Colors.black,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.productTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.itemStyle,

                    ),
                    Row(
                      children: [
                        Text(
                          "\$ ${widget.productPrice.toString()}",
                          style: AppTextStyle.itemStylePrice,
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: (){
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Added to cart!'),
                                  duration: Duration(seconds: 2),
                                  backgroundColor: AppColor.primaryColor,
                                ),
                              );

                          },
                          child: CircleAvatar(
                            backgroundColor: AppColor.primaryColor,
                            radius: 14,
                            child: Icon(Icons.add, color: Colors.white,),
                          ),
                        ),

                      ],
                    )
                  ],
                ),

          )

        ],
      ),
    );
  }
}