import 'package:deliveryapp/data/datasource/api_repository_impl.dart';
import 'package:deliveryapp/data/datasource/local_repository_impl.dart';
import 'package:deliveryapp/domain/repository/api_repository.dart';
import 'package:deliveryapp/domain/repository/local_storage_repository.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalRepositoryInterface>(() => LocalRepositoryImpl());
    Get.lazyPut<ApiRepositoryInterface>(() => ApiRepositoryImpl());
  }
}
