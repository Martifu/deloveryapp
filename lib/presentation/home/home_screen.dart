import 'package:deliveryapp/presentation/home/cart/cart_controller.dart';
import 'package:deliveryapp/presentation/home/cart/cart_screen.dart';
import 'package:deliveryapp/presentation/home/home_controller.dart';
import 'package:deliveryapp/presentation/home/products/products_screen.dart';
import 'package:deliveryapp/presentation/home/profile/profile_screen.dart';
import 'package:deliveryapp/presentation/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetWidget<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: Obx(() {
            return IndexedStack(
              index: controller.currentIndex.value,
              children: [
                ProductsScreen(),
                Placeholder(),
                CartScreen(
                  onShopping: () {
                    controller.updateSelectedndex(0);
                  },
                ),
                Placeholder(),
                ProfileScreen(),
              ],
            );
          })),
          Obx(() {
            return _DeliveryNavigationBar(
              index: controller.currentIndex.value,
              onIndexSelected: (index) =>
                  {controller.updateSelectedndex(index)},
            );
          })
        ],
      ),
    );
  }
}

class _DeliveryNavigationBar extends StatelessWidget {
  final int index;
  final ValueChanged<int> onIndexSelected;
  final controller = Get.find<HomeController>();
  final cartController = Get.find<CartController>();

  _DeliveryNavigationBar({Key key, this.index, this.onIndexSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        child: Obx(
                          () => cartController.totalItems.value == 0
                              ? SizedBox.shrink()
                              : CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.pinkAccent,
                                  child: Text(
                                    cartController.totalItems.value.toString(),
                                    style: TextStyle(
                                      color: DeliveryColors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                        )),
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
                  child: Obx(() {
                    final user = controller.user.value;
                    return user.image == null
                        ? const SizedBox.shrink()
                        : CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.red,
                            backgroundImage: AssetImage(user.image),
                          );
                  })),
            ],
          ),
        ),
      ),
    );
  }
}
