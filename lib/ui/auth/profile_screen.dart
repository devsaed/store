import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:said_store/getx/cities_getx_controller.dart';
import 'package:said_store/getx/user_getx_controller.dart';
import 'package:said_store/local_storge/shared_preferences/preferences.dart';
import 'package:said_store/model/city.dart';
import 'package:said_store/ui/city/cities_screen.dart';
import 'package:said_store/ui/widgets/app_elevated_button.dart';
import 'package:said_store/ui/widgets/app_text_field.dart';
import 'package:said_store/ui/widgets/app_text_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:said_store/utils/app_colors.dart';
import 'package:said_store/utils/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          padding: EdgeInsets.all(32.h),
          child: Column(
            children: [
              SizedBox(height: 30.h),
              SvgPicture.asset(
                'assets/svg/logo_blue.svg',
                height: 83.h,
                width: 61.w,
              ),
              SizedBox(height: 80.h),
              AppTextField(
                controller: nameController,
                label: 'Name',
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () async {
                  City selectedCity = await Get.to(CitiesScreen());
                  setState(() {
                    city = selectedCity;
                  });
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 28.w),
                    alignment: AlignmentDirectional.centerStart,
                    height: 50.h,
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
                          borderRadius: BorderRadius.circular(50.h),
                          border: Border.all(color: Colors.grey),),
                    child: getCityName()),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      checkColor: Colors.white,
                      activeColor: AppColors.PRIMARY_COLOR,
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
                    width: 40.w,
                    thickness: 5.h,
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      checkColor: Colors.white,
                      activeColor: AppColors.PRIMARY_COLOR,
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
              SizedBox(height: 42.h),
              AppElevatedButton(text: 'Update', onPressed: () async {
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
      update();
    }
  }

  bool checkData() {
    if (nameController.text.isNotEmpty) {
      return true;
    }
    else{
      Helper.showSnackBar(context, text: 'complete fields', error: true);
      return false;
    }
  }

  Future<void> update() async {
    bool status = await UsersGetxController.to.updateProfile(context: context, name: nameController.text, gender: isMale?'M':'F', city: city == null ? SharedPreferencesController().user!.cityId : city!.id);
    if(status){
      await SharedPreferencesController().setCityId(city == null ? SharedPreferencesController().user!.cityId: city!.id);
      await SharedPreferencesController().setName(nameController.text);
      await SharedPreferencesController().setGender(isMale?'M':'F');
    }
  }

}
