import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/phonePay.dart';
import 'package:shopping_app/shop/cubit/cart_cubit.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cart Products'),
        ),
        body: BlocBuilder<CartCubit, CartProdcuts>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.cartList.length,
                      itemBuilder: (context, index) {
                        final product = state.cartList[index];
                        return ListTile(
                          title: Text(product.productname),
                          leading: IconButton(
                              onPressed: () {
                                context
                                    .read<CartCubit>()
                                    .removeProduct(product);
                              },
                              icon: const Icon(Icons.delete)),
                          trailing: Text(
                            product.productPrice.toString(),
                          ),
                        );
                      }),
                ),
                Text(
                  'Total Cart value: ${state.totalCartValue}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PhonepayScreen(
                          paymentAmount: state.totalCartValue * 100,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Proceed To Payment',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }
}
