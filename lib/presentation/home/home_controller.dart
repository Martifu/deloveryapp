import 'package:deliveryapp/domain/model/user.dart';
import 'package:deliveryapp/domain/repository/api_repository.dart';
import 'package:deliveryapp/domain/repository/local_storage_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;

  HomeController({this.localRepositoryInterface, this.apiRepositoryInterface});

  Rx<User> user = User.empty().obs;
  RxInt currentIndex = 0.obs;
  RxBool darkTheme = false.obs;

  @override
  void onReady() {
    loadUser();
    super.onReady();
  }

  @override
  void onInit() {
    loadCurrentTheme();
    super.onInit();
  }

  void loadCurrentTheme() {
    localRepositoryInterface.isDarkMode().then(
      (value) {
        darkTheme(value);
      },
    );
  }

  bool updateTheme(bool isDark) {
    localRepositoryInterface.saveDarkMode(isDark);
    darkTheme(isDark);
    return isDark;
  }

  void loadUser() {
    localRepositoryInterface.getUser().then(
      (value) {
        user(value);
      },
    );
  }

  void updateSelectedndex(int index) {
    currentIndex(index);
  }

  Future<void> logOut() async {
    final token = await localRepositoryInterface.getToken();
    await apiRepositoryInterface.logout(token);
    await localRepositoryInterface.clearAllData();
  }
}
