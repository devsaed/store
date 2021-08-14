import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:said_store/api/controllers/userApiContraller.dart';
import 'package:said_store/local_storge/shared_preferences/preferences.dart';
import 'package:said_store/model/Home.dart';
import 'package:said_store/model/user.dart';

class UsersGetxController extends GetxController {
  UserApiController _userApiController = UserApiController();
  late User? user;
  late Home? home;

  static UsersGetxController get to => Get.find();

  @override
  void onInit() {
    initHome();
    if (SharedPreferencesController().loggedIn){
      user = SharedPreferencesController().user;
    }
    super.onInit();
  }

  Future<bool> login({required BuildContext context,required String mobile, required String password}) async {
    User? user = await _userApiController.login(context, mobile: mobile, password: password);
    if (user != null) {
      await SharedPreferencesController().save(user: user);
      this.user = user;
      return true;
    }
    return false;
  }

  Future<bool> resetPassword({required BuildContext context, required String mobile, required String code, required String password}) async {
    bool status = await _userApiController.resetPassword(context, mobile: mobile, code: code, password: password);
    if (status) return true;
    return false;
  }

  Future<bool> logout(BuildContext context) async {
    return await _userApiController.logout(context);
  }
  Future<bool> forgetPassword(BuildContext context, {required String mobile}) async {
    return await _userApiController.forgetPassword(context,mobile: mobile);
  }


  Future<bool> changePassword(BuildContext context, {required String currentPassword,required String newPassword}) async {
    return await _userApiController.changePassword(context, currentPassword: currentPassword, newPassword: newPassword);
  }

  Future<int?> register({required BuildContext context, required String name, required String mobile, required String password, required String gender, required int city}) async {
    int? code = await _userApiController.register(context: context, name: name, mobile: mobile, password: password, gender: gender, city: city);
    if (code != null) return code;
    return null;
  }

  Future<bool> activatedAccount(BuildContext context, {required String code,required String mobile}) async {
    return await _userApiController.activateAccount(context, mobile: mobile, code: code);
  }

  Future<bool> contactUs(BuildContext context, {required String subject,required String msg}) async {
    return await _userApiController.contactUS(context, subject: subject, msg: msg);
  }

  Future<void> initHome() async {
    home =  await _userApiController.initHome();
  }
}
