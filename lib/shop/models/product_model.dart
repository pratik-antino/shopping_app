// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductModel {
  String productId;
  String productname;
  String productDescription;
  int productPrice;
  ProductModel({
    required this.productId,
    required this.productname,
    required this.productDescription,
    required this.productPrice,
  });

  ProductModel copyWith({
    String? productId,
    String? productname,
    String? productDescription,
    int? productPrice,
  }) {
    return ProductModel(
      productId: productId ?? this.productId,
      productname: productname ?? this.productname,
      productDescription: productDescription ?? this.productDescription,
      productPrice: productPrice ?? this.productPrice,
    );
  }
}
