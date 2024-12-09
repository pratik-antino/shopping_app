// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/shop/models/product_model.dart';

class CartCubit extends Cubit<CartProdcuts> {
  CartCubit()
      : super(
          CartProdcuts(
            cartList: [],
            totalCartValue: 0,
          ),
        );

  void addProduct(ProductModel product) {
    final List<ProductModel> cartlist = List<ProductModel>.from(state.cartList)
      ..add(product);
    final totalSum = _calculatetotal(cartlist);
    emit(
      state.copyWith(
        cartList: cartlist,
        totalCartValue: totalSum,
      ),
    );
  }

  void removeProduct(ProductModel product) {
    final List<ProductModel> cartlist = List<ProductModel>.from(state.cartList)
      ..remove(product);
    final totalSum = _calculatetotal(cartlist);
    emit(
      state.copyWith(
        cartList: cartlist,
        totalCartValue: totalSum,
      ),
    );

  }
}

int _calculatetotal(List<ProductModel> newList) {
  final newTOtoal =
      newList.fold(0, (total, product) => total + product.productPrice);
  return newTOtoal;
}

class CartProdcuts {
  List<ProductModel> cartList;
  int totalCartValue;
  CartProdcuts({
    required this.cartList,
    required this.totalCartValue,
  });

  CartProdcuts copyWith({
    List<ProductModel>? cartList,
    int? totalCartValue,
  }) {
    return CartProdcuts(
      cartList: cartList ?? this.cartList,
      totalCartValue: totalCartValue ?? this.totalCartValue,
    );
  }
}
