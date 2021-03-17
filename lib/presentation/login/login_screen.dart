import 'package:deliveryapp/domain/repository/api_repository.dart';
import 'package:deliveryapp/domain/repository/local_storage_repository.dart';
import 'package:deliveryapp/presentation/home/home_screen.dart';
import 'package:deliveryapp/presentation/login/login_bloc.dart';
import 'package:deliveryapp/presentation/theme.dart';
import 'package:deliveryapp/presentation/widgets/delivery_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const logoSize = 45.0;

class LoginScreen extends StatelessWidget {
  LoginScreen._();
  final _scaffolKey = GlobalKey<ScaffoldState>();
  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginBLoC(
        apiRepositoryInterface: context.read<ApiRepositoryInterface>(),
        localRepositoryInterface: context.read<LocalRepositoryInterface>(),
      ),
      builder: (_, __) => LoginScreen._(),
    );
  }

  void login(BuildContext context) async {
    final bloc = Provider.of<LoginBLoC>(context, listen: false);
    final result = await bloc.login();
    if (result) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => HomeScreen.init(context),
        ),
      );
    } else {
      _scaffolKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Login Incorrect'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final moreSize = 50.0;
    final bloc = context.watch<LoginBLoC>();

    return Scaffold(
      key: _scaffolKey,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  flex: 2,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: logoSize,
                        left: -moreSize / 2,
                        right: -moreSize / 2,
                        height: width + moreSize,
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: deliveryGradiants,
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [0.5, 1.0]),
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(size.width / 2))),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).canvasColor,
                          radius: logoSize,
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Image.asset('assets/logo.png'),
                          ),
                        ),
                      )
                    ],
                  )),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 30.0),
                        Text(
                          'Login',
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).accentColor,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40.0),
                        Text(
                          'Username',
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.caption.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context)
                                  .inputDecorationTheme
                                  .labelStyle
                                  .color),
                        ),
                        const SizedBox(height: 10.0),
                        TextField(
                          controller: bloc.usernameTextController,
                          decoration: InputDecoration(
                            hintText: 'Username',
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          'Password',
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.caption.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context)
                                  .inputDecorationTheme
                                  .labelStyle
                                  .color),
                        ),
                        const SizedBox(height: 10.0),
                        TextField(
                          obscureText: true,
                          controller: bloc.passwordTextController,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: Icon(
                              Icons.lock_open,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    gradient: LinearGradient(
                      colors: deliveryGradiants,
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: DeliveryButton(
                      padding: EdgeInsets.all(5.0),
                      text: 'Login',
                      onTap: () => login(context),
                    ),
                  ),
                ),
              )
            ],
          ),
          Positioned.fill(
            child: (bloc.loginState == LoginState.loading)
                ? Container(
                    color: Colors.black26,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
