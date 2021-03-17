import 'package:deliveryapp/domain/repository/api_repository.dart';
import 'package:deliveryapp/domain/repository/local_storage_repository.dart';
import 'package:deliveryapp/presentation/home/cart/cart_bloc.dart';
import 'package:deliveryapp/presentation/home/cart/cart_screen.dart';
import 'package:deliveryapp/presentation/home/home_bloc.dart';
import 'package:deliveryapp/presentation/home/products/products_screen.dart';
import 'package:deliveryapp/presentation/home/profile/profile_screen.dart';
import 'package:deliveryapp/presentation/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen._();
  static Widget init(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => HomeBLoC(
          apiRepositoryInterface: context.read<ApiRepositoryInterface>(),
          localRepositoryInterface: context.read<LocalRepositoryInterface>(),
        )..loadUser(),
        builder: (_, __) => HomeScreen._(),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<HomeBLoC>(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: IndexedStack(
            index: bloc.indexSelected,
            children: [
              ProductsScreen.init(context),
              Placeholder(),
              CartScreen(
                onShopping: () {
                  bloc.updateSelectedndex(0);
                },
              ),
              Placeholder(),
              ProfileScreen.init(context),
            ],
          )),
          _DeliveryNavigationBar(
            index: bloc.indexSelected,
            onIndexSelected: (index) => {
              bloc.updateSelectedndex(index),
            },
          ),
        ],
      ),
    );
  }
}

class _DeliveryNavigationBar extends StatelessWidget {
  final int index;
  final ValueChanged<int> onIndexSelected;

  _DeliveryNavigationBar({Key key, this.index, this.onIndexSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeBloc = Provider.of<HomeBLoC>(context);
    final cartBloc = Provider.of<CartBLoC>(context);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(context).bottomAppBarColor,
              width: 2,
            )),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Material(
                child: IconButton(
                  icon: Icon(Icons.home),
                  color: index == 0
                      ? DeliveryColors.green
                      : DeliveryColors.lightGrey,
                  onPressed: () => onIndexSelected(0),
                ),
              ),
              Material(
                child: IconButton(
                  icon: Icon(Icons.store),
                  color: index == 1
                      ? DeliveryColors.green
                      : DeliveryColors.lightGrey,
                  onPressed: () => onIndexSelected(1),
                ),
              ),
              Material(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 23,
                      backgroundColor: DeliveryColors.purple,
                      child: IconButton(
                        icon: Icon(Icons.shopping_basket),
                        color: index == 2
                            ? DeliveryColors.green
                            : DeliveryColors.white,
                        onPressed: () => onIndexSelected(2),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: cartBloc.totalItems == 0
                          ? SizedBox.shrink()
                          : CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.pinkAccent,
                              child: Text(
                                cartBloc.totalItems.toString(),
                                style: TextStyle(
                                  color: DeliveryColors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              Material(
                child: IconButton(
                  icon: Icon(Icons.favorite_border),
                  color: index == 3
                      ? DeliveryColors.green
                      : DeliveryColors.lightGrey,
                  onPressed: () => onIndexSelected(3),
                ),
              ),
              InkWell(
                onTap: () => onIndexSelected(4),
                child: homeBloc.user?.image == null
                    ? const SizedBox.shrink()
                    : CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.red,
                        backgroundImage: AssetImage(homeBloc.user.image),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
