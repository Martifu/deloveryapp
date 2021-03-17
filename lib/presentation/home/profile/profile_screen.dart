import 'package:deliveryapp/domain/repository/api_repository.dart';
import 'package:deliveryapp/domain/repository/local_storage_repository.dart';
import 'package:deliveryapp/presentation/home/profile/profile_bloc.dart';
import 'package:deliveryapp/presentation/main_bloc.dart';
import 'package:deliveryapp/presentation/splash_screen/splash_screen.dart';
import 'package:deliveryapp/presentation/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home_bloc.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen._();
  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileBLoC(
          localRepositoryInterface: context.read<LocalRepositoryInterface>(),
          apiRepositoryInterface: context.read<ApiRepositoryInterface>())
        ..loadCurrentTheme(),
      builder: (_, __) => ProfileScreen._(),
    );
  }

  Future<void> logout(BuildContext context) async {
    final profileBloc = Provider.of<ProfileBLoC>(context, listen: false);

    await profileBloc.logOut();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => SplashScreen.init(context),
      ),
      (route) => false,
    );
  }

  void onThemeUpdated(BuildContext context, bool isDark) {
    final profileBloc = Provider.of<ProfileBLoC>(context, listen: false);
    profileBloc.updateTheme(isDark);
    final mainBloc = context.read<MainBLoC>();
    mainBloc.loadTheme();
  }

  @override
  Widget build(BuildContext context) {
    final homeBloc = Provider.of<HomeBLoC>(context);
    final profileBloc = Provider.of<ProfileBLoC>(context);
    final user = homeBloc.user;
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: user?.image != null
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
                                          color: Theme.of(context).accentColor),
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
                                        Switch(
                                            activeColor: DeliveryColors.purple,
                                            value: profileBloc.isDark,
                                            onChanged: (val) {
                                              onThemeUpdated(context, val);
                                              print(profileBloc.isDark);
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
                              onPressed: () => logout(context),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
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
  }
}
