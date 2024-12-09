import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/shop/cubit/cart_cubit.dart';
import 'package:shopping_app/shop/cubit/product_screen_cubit.dart';
import 'package:shopping_app/shop/models/product_model.dart';

class ProductListScren extends StatefulWidget {
  const ProductListScren({super.key});

  @override
  State<ProductListScren> createState() => _ProductListScrenState();
}

class _ProductListScrenState extends State<ProductListScren> {
  late FirebaseMessaging _messaging;
  String _message = '';
  @override
  void initState() {
    super.initState();
    _messaging = FirebaseMessaging.instance;

    // Request permission for iOS
    _messaging.requestPermission();

    // Get the FCM token (for testing purposes)
    _messaging.getToken().then((token) {
      print('FCM Token: $token');
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      setState(() {
        _message = message.notification?.body ?? '';
      });
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle message opened from background
    });
  }

  @override
  Widget build(BuildContext context) {
    context.read<ProductCubit>().fetchProducts();
    final List<ProductModel> productList = context.watch<ProductCubit>().state;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Products List'),
          actions: [
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: BlocBuilder<CartCubit, CartProdcuts>(
                      builder: (context, state) {
                        return Badge.count(
                          count: state.cartList.length,
                          child: GestureDetector(
                            onTap: () {
                              throw Exception();
                            },
                            child: const Icon(
                              Icons.shopping_bag,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ))
              ],
            ),
          ]),
      body: productList.isNotEmpty
          ? GridView.builder(
              itemCount: productList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                final product = productList[index];
                return Card(
                    shape: const RoundedRectangleBorder(),
                    child: GestureDetector(
                      onTap: () {
                        context.read<CartCubit>().addProduct(product);
                      },
                      child: ListTile(
                        title: Text(product.productname),
                        subtitle: Text(
                          product.productDescription,
                        ),
                      ),
                    ));
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
