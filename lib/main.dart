import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:said_store/local_storge/db/db_provider.dart';
import 'package:said_store/utils/app_colors.dart';

import 'fb_notifications/fb_notifications.dart';
import 'local_storge/shared_preferences/preferences.dart';
import 'ui/app/launch_screen.dart';
import 'locale/app_locale.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesController().initSharedPreference();
  await DBProvider().initDatabase();
  await Firebase.initializeApp();
  await FbNotifications.initNotifications();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () => GetMaterialApp(
        translations: AppLocale(), // your translations
        locale: Locale(SharedPreferencesController().languageCode),
        home: LaunchScreen(),
        theme: ThemeData(
          primaryColor: AppColors.PRIMARY_COLOR,
          appBarTheme: AppBarTheme(
            color: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: AppColors.PRIMARY_TEXT_COLOR),
          ),
        ),
      ),
    );
  }
}
