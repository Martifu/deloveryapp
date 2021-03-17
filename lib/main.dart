import 'package:deliveryapp/data/datasource/api_repository_impl.dart';
import 'package:deliveryapp/data/datasource/local_repository_impl.dart';
import 'package:deliveryapp/domain/repository/api_repository.dart';
import 'package:deliveryapp/domain/repository/local_storage_repository.dart';
import 'package:deliveryapp/presentation/main_bloc.dart';
import 'package:deliveryapp/presentation/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presentation/home/cart/cart_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<ApiRepositoryInterface>(
            create: (_) => ApiRepositoryImpl(),
          ),
          Provider<LocalRepositoryInterface>(
            create: (_) => LocalRepositoryImpl(),
          ),
          ChangeNotifierProvider(create: (context) {
            return MainBLoC(
              localRepositoryInterface:
                  context.read<LocalRepositoryInterface>(),
            )..loadTheme();
          }),
          ChangeNotifierProvider(
            create: (_) => CartBLoC(),
          ),
        ],
        child: Builder(builder: (newContext) {
          return Consumer<MainBLoC>(builder: (context, bloc, _) {
            return bloc.currentTheme == null
                ? SizedBox.shrink()
                : MaterialApp(
                    debugShowCheckedModeBanner: false,
                    theme: bloc.currentTheme,
                    title: 'Delivery App',
                    home: SplashScreen.init(newContext),
                  );
          });
        }));
  }
}
