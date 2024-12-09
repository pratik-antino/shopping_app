import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/shop/cubit/cart_cubit.dart';
import 'package:shopping_app/shop/cubit/product_screen_cubit.dart';
import 'package:shopping_app/shop/screen/product_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductCubit>(
          create: (BuildContext context) => ProductCubit(),
        ),
        BlocProvider<CartCubit>(
          create: (BuildContext context) => CartCubit(),
        ),
      ],
      child: const MaterialApp(home: ProductListScren()),
    );
  }
}

void _firebaseMessagingBackgroundHandler(RemoteMessage message) {}
