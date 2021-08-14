
import 'package:get/get.dart';
import 'package:said_store/api/controllers/userApiContraller.dart';
import 'package:said_store/model/Home.dart';

class HomeGetxController extends GetxController {
  Home? home;
  bool isLoading = true;
  UserApiController dbController = UserApiController();

  static HomeGetxController get to => Get.find();

  @override
  void onInit() {
    initHome();
    super.onInit();
  }


  Future<void> initHome() async {
    isLoading = true;
    home = await dbController.initHome();
    isLoading = false;
    update();
  }

}
