import 'package:dio_shop/blocs/products_bloc/product_bloc.dart';
import 'package:dio_shop/blocs/products_bloc/product_events.dart';
import 'package:dio_shop/blocs/products_bloc/product_state.dart';
import 'package:dio_shop/data/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<ProductBloc>().add(GetProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(CupertinoIcons.shopping_cart))
        ],
        centerTitle: true,
        title: const Text("Products"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is LoadingProductState) {
              return const Center(
                child: const SpinKitCircle(
                  color: Colors.green,
                ),
              );
            }
            if (state is ErrorProductsState) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }

            List<Product> products = [];

            if (state is LoadedProductState) {
              products = state.products;
            }

            return products.isEmpty
                ? const Center(
                    child: Text("Productlar mavjud emas!!!"),
                  )
                : ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const CircleAvatar(),
                        title: Text(products[index].category.name),
                        subtitle: Text(
                          products[index].description,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                                size: 22,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 22,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
