import 'package:deliveryapp/presentation/home/home_controller.dart';
import 'package:deliveryapp/presentation/routes/delivery_navigation.dart';
import 'package:deliveryapp/presentation/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  final controller = Get.find<HomeController>();

  void logout() async {
    await controller.logOut();
    Get.offAllNamed(DeliveryRoutes.splash);
  }

  void onThemeUpdated(bool isDark) {
    controller.updateTheme(isDark);
    Get.changeTheme(isDark ? darkTheme : lightTheme);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final user = controller.user.value;
      return Scaffold(
          appBar: AppBar(
            title: Text('Profile'),
          ),
          body: user.image != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 30.0,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: DeliveryColors.green,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: AssetImage(user.image)),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            user.username,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).accentColor),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(25),
                              child: Card(
                                color: Theme.of(context).canvasColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        'Personal Information',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).accentColor),
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Text(
                                        'martin0013esp@hotamail.com',
                                        textAlign: TextAlign.start,
                                      ),
                                      Row(
                                        children: [
                                          Text('Dark Mode'),
                                          Spacer(),
                                          Obx(() {
                                            return Switch(
                                              activeColor:
                                                  DeliveryColors.purple,
                                              value: controller.darkTheme.value,
                                              onChanged: onThemeUpdated,
                                            );
                                          })
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            Center(
                              child: RaisedButton(
                                onPressed: logout,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    'Log Out',
                                    style: TextStyle(
                                        color: DeliveryColors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                color: DeliveryColors.purple,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            )
                          ],
                        )),
                  ],
                )
              : SizedBox.shrink());
    });
  }
}
