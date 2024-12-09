import 'package:shopping_app/shop/models/product_model.dart';
import 'package:uuid/uuid.dart';

class ApiCallReepo {
  final u = const Uuid().v1();
  static Future<List<ProductModel>>fetchproduct() async{
     List<ProductModel> fetchedList =[
      ProductModel(
          productId: const Uuid().v1(),
          productname: 'Product1',
          productDescription: 'productDescription',
          productPrice: 500),
      ProductModel(
          productId: const Uuid().v1(),
          productname: 'Product2',
          productDescription: 'productDescription',
          productPrice: 700),
      ProductModel(
          productId: const Uuid().v1(),
          productname: 'Product3',
          productDescription: 'productDescription',
          productPrice: 567),
      ProductModel(
          productId: const Uuid().v1(),
          productname: 'Product4',
          productDescription: 'productDescription',
          productPrice: 780),
      ProductModel(
          productId: const Uuid().v1(),
          productname: 'Product5',
          productDescription: 'productDescription',
          productPrice: 3200),
      ProductModel(
          productId: const Uuid().v1(),
          productname: 'Product6',
          productDescription: 'productDescription',
          productPrice: 300),
      ProductModel(
          productId: const Uuid().v1(),
          productname: 'Product7',
          productDescription: 'productDescription',
          productPrice: 4500),
      ProductModel(
          productId: const Uuid().v1(),
          productname: 'Product8',
          productDescription: 'productDescription',
          productPrice: 560),
      ProductModel(
          productId: const Uuid().v1(),
          productname: 'Product9',
          productDescription: 'productDescription',
          productPrice: 120),
    ];
    Future.delayed(const Duration(seconds: 40));


    return fetchedList;
  }
}
