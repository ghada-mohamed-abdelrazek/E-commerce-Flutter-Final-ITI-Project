import 'package:iti_final_project/feature/model/feature_model.dart';
import 'package:iti_final_project/feature/model/product_model.dart';

class CartProduct {
  final int id;
  final String title;
  final double price;
  final String image;

  const CartProduct({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
  });

  factory CartProduct.fromDummy(ProductModel p) {
    return CartProduct(
      id: p.id ?? -1,
      title: p.title ?? "",
      price: p.price ?? 0,
      image: (p.images != null && p.images!.isNotEmpty)
          ? p.images!.first
          : (p.thumbnail ?? ""),
    );
  }

  factory CartProduct.fromFeature(FeatureModel f) {
    return CartProduct(
      id: f.id ?? -1,
      title: f.title ?? "",
      price: (f.price ?? 0).toDouble(),
      image: f.image ?? "",
    );
  }
}
