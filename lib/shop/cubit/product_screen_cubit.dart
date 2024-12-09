
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/shop/models/product_model.dart';
import 'package:shopping_app/shop/repository/repo.dart';

class ProductCubit extends Cubit<List<ProductModel>> {
  ProductCubit() : super([]);
  void fetchProducts() async {
    try {
      // Fetch the product list using the repository method.
      final productList = await ApiCallReepo.fetchproduct();

      // Emit the fetched product list to update the state.
      emit(productList);
    } catch (e) {
      // Handle any errors that may occur during the API call.
      print('Error fetching products: $e');
      // Optionally, emit an empty list or keep the previous state in case of an error.
      emit([]);
    }
  }
}
