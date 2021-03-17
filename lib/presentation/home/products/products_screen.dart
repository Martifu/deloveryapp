import 'package:deliveryapp/domain/model/product.dart';
import 'package:deliveryapp/domain/repository/api_repository.dart';
import 'package:deliveryapp/presentation/home/cart/cart_bloc.dart';
import 'package:deliveryapp/presentation/home/products/products_bloc.dart';
import 'package:deliveryapp/presentation/theme.dart';
import 'package:deliveryapp/presentation/widgets/delivery_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen._();
  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductsBLoC(
        apiRepositoryInterface: context.read<ApiRepositoryInterface>(),
      )..loadProducts(),
      builder: (_, __) => ProductsScreen._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final productsBloc = Provider.of<ProductsBLoC>(context);
    final cartBloc = Provider.of<CartBLoC>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: productsBloc.productsList.isNotEmpty
          ? GridView.builder(
              padding: const EdgeInsets.all(20.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 2.7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: productsBloc.productsList.length,
              itemBuilder: (context, index) {
                final product = productsBloc.productsList[index];
                return _ItemProduct(
                  product: product,
                  onTap: () {
                    cartBloc.add(product);
                  },
                );
              })
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class _ItemProduct extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  _ItemProduct({Key key, this.product, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Theme.of(context).canvasColor,
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: CircleAvatar(
                backgroundColor: Colors.black,
                child: ClipOval(
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Image.asset(
                      product.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    product.description,
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(color: DeliveryColors.lightGrey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '\$${product.price} USD',
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                ],
              ),
            ),
            DeliveryButton(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
              ),
              text: 'Add',
              onTap: onTap,
            )
          ],
        ),
      ),
    );
  }
}
