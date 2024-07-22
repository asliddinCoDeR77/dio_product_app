import 'package:dio_shop/blocs/products_bloc/product_bloc.dart';
import 'package:dio_shop/data/repositorys/products_repositorys.dart';
import 'package:dio_shop/data/services/dio_product_services.dart';
import 'package:dio_shop/ui/screens/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final dioProductServices = DioProductServices();
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) {
            return ProductsRepositorys(dioProductsService: dioProductServices);
          },
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return ProductBloc(
                productsRepositorys: context.read<ProductsRepositorys>(),
              );
            },
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductsScreen(),
    );
  }
}
