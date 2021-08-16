import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:said_store/getx/cities_getx_controller.dart';
import 'package:said_store/local_storge/shared_preferences/preferences.dart';
import 'package:said_store/model/city.dart';
import 'package:said_store/ui/city/cities_screen.dart';
import 'package:said_store/ui/widgets/app_elevated_button.dart';
import 'package:said_store/ui/widgets/app_text_field.dart';
import 'package:said_store/ui/widgets/app_text_widget.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController nameController;
  City? city;
  bool isMale = SharedPreferencesController().user!.gender == 'M'? true: false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: SharedPreferencesController().user!.name);
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.white),
        title: AppTextWidget(content: 'Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            children: [
              SizedBox(height: 30),
              SvgPicture.asset(
                'assets/svg/logo_blue.svg',
                height: 83,
                width: 61.21,
              ),
              SizedBox(height: 80),
              AppTextField(
                controller: nameController,
                label: 'Name',
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  City selectedCity = await Get.to(CitiesScreen());
                  setState(() {
                    city = selectedCity;
                  });
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 28),
                    alignment: AlignmentDirectional.centerStart,
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xFF999999).withAlpha(25),
                                offset: Offset(0, 5),
                                blurRadius: 10,
                                spreadRadius: 0)
                          ],
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.grey)),
                    child: getCityName()),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      value: isMale,
                      onChanged: (var selected) {
                        setState(() {
                          isMale = true;
                        });
                      },
                      title: Text('Male'),
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.red,
                    width: 50,
                    thickness: 5,
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      value: !isMale,
                      onChanged: (var selected) {
                        setState(() {
                          isMale = false;
                        });
                      },
                      title: Text('Female'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 42),
              AppElevatedButton(text: 'Login', onPressed: () async {
                await performRegister();
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget getCityName() {
    if (city == null) {
      return AppTextWidget(
        content: CitiesGetxController.to.getCityNameById(id: SharedPreferencesController().user!.cityId),
        color: Colors.grey,
      );
    } else {
      if (SharedPreferencesController().languageCode == 'ar') {
        return AppTextWidget(
          content: city!.nameAr,
          color: Colors.black,
        );
      } else {
        return AppTextWidget(
          content: city!.nameEn,
          color: Colors.black,
        );
      }
    }
  }

  Future<void> performRegister() async {
    if (checkData()) {
      // await register();
    }
  }

  bool checkData() {
    if (nameController.text.isNotEmpty &&
        city != null) {
      return true;
    }
    return false;
  }
  //
  // Future<void> register() async {
  //   int? code = await UsersGetxController.to.register(context: context, name: nameController.text, mobile: phoneController.text, password: passwordController.text, gender: isMale?'M':'F', city: city!.id);
  //   if (code!=null) {
  //     Helper.showSnackBar(
  //         context,
  //         text: code.toString(),
  //         error: true);
  //     Get.off(ActivationScreen(mobile: phoneController.text));
  //   }
  //
  // }

}
