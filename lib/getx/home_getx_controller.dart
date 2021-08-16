
import 'package:get/get.dart';
import 'package:said_store/api/controllers/userApiContraller.dart';
import 'package:said_store/model/home.dart';

class HomeGetxController extends GetxController {
  Home? home;
  RxBool isLoading = false.obs;
  UserApiController dbController = UserApiController();

  static HomeGetxController get to => Get.find();

  @override
  void onInit() {
    initHome();
    super.onInit();
  }


  Future<void> initHome() async {
    isLoading.value = true;
    home = await dbController.initHome();
    isLoading.value = false;
    update();
  }

}
