import 'package:deliveryapp/presentation/home/cart/cart_bloc.dart';
import 'package:deliveryapp/presentation/home/products/product_cart.dart';
import 'package:deliveryapp/presentation/theme.dart';
import 'package:deliveryapp/presentation/widgets/delivery_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  final VoidCallback onShopping;

  CartScreen({Key key, this.onShopping}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<CartBLoC>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: bloc.totalItems == 0
          ? _EmptyCart(
              onShopping: onShopping,
            )
          : _FullCart(),
    );
  }
}

class _FullCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<CartBLoC>();
    final totals = bloc.totalPrice.toStringAsFixed(2);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: ListView.builder(
              itemExtent: 230,
              scrollDirection: Axis.horizontal,
              itemCount: bloc.cartList.length,
              itemBuilder: (context, index) {
                final productCart = bloc.cartList[index];
                return _ShoppingCartProduct(
                  productCart: productCart,
                  onDelete: () {
                    bloc.deleteProduct(productCart);
                  },
                  onIncrement: () {
                    bloc.increment(productCart);
                  },
                  onDecrement: () {
                    bloc.decrement(productCart);
                  },
                );
              },
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Theme.of(context).canvasColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Subtotal',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(
                                      color: Theme.of(context).accentColor),
                            ),
                            Text(
                              '0.0 usd',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(
                                      color: Theme.of(context).accentColor),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Delivery',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(
                                      color: Theme.of(context).accentColor),
                            ),
                            Text(
                              'Free',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(
                                      color: Theme.of(context).accentColor),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total:',
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '\$$totals usd',
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  DeliveryButton(
                    text: 'Checkout',
                    onTap: () {},
                    padding: EdgeInsets.all(20.0),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ShoppingCartProduct extends StatelessWidget {
  final ProductCart productCart;
  final VoidCallback onDelete;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  _ShoppingCartProduct(
      {Key key,
      this.productCart,
      this.onDelete,
      this.onIncrement,
      this.onDecrement})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Stack(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Theme.of(context).canvasColor,
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 2,
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        child: ClipOval(
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Image.asset(
                              productCart.product.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            productCart.product.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            productCart.product.description,
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
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: onDecrement,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: DeliveryColors.veryLightGrey,
                                    ),
                                    child: Icon(
                                      Icons.remove,
                                      color: DeliveryColors.dark,
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(productCart.qty.toString())),
                                InkWell(
                                  onTap: onIncrement,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: DeliveryColors.purple,
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: DeliveryColors.white,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '\$${productCart.product.price} ',
                                  style: TextStyle(color: DeliveryColors.green),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: InkWell(
                onTap: onDelete,
                child: CircleAvatar(
                  backgroundColor: DeliveryColors.pink,
                  child: Icon(Icons.delete_outline),
                ),
              ),
            )
          ],
        ));
  }
}

class _EmptyCart extends StatelessWidget {
  final VoidCallback onShopping;

  const _EmptyCart({Key key, this.onShopping}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          'assets/sad.png',
          height: 90,
        ),
        const SizedBox(height: 20),
        Text('There are no products.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Theme.of(context).accentColor)),
        const SizedBox(height: 10),
        Center(
          child: RaisedButton(
            onPressed: onShopping,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Go Shopping',
                style: TextStyle(
                    color: DeliveryColors.white, fontWeight: FontWeight.bold),
              ),
            ),
            color: DeliveryColors.purple,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        )
      ],
    );
  }
}
