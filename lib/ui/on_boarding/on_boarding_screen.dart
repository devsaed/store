import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:said_store/ui/auth/login_screen.dart';
import 'package:said_store/ui/on_boarding/on_boarding_indicator.dart';
import 'package:said_store/ui/on_boarding/on_boarging_widget.dart';
import 'package:said_store/ui/widgets/app_elevated_button.dart';
import 'package:said_store/ui/widgets/app_text_button.dart';
import 'package:said_store/utils/app_colors.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
            children: [
              OnBoardingWidget(
                title: 'Great deals',
                subTitle: 'D’ont miss out our flash sale  and daily speclais with great discounts',
                image: 'shop',
              ),
              OnBoardingWidget(
                title: 'High Quality',
                subTitle: 'You can only find high-quality and affordable clothing for your litle baby',
                image: 'shop2',
              ),
              OnBoardingWidget(
                title: 'Invite freinds',
                subTitle: 'You can invite your best freinds and share with them your first order',
                image: 'shop3',
              ),
            ],
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Visibility(
              visible: currentIndex != 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 45.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppTextButton(
                        text: 'Skip',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                        textColor: AppColors.PRIMARY_TEXT_COLOR,
                        onPressed: skip),
                    Row(
                      children: [
                        OnBoardingIndicator(
                          isSelected: currentIndex == 0,
                        ),
                        OnBoardingIndicator(
                          isSelected: currentIndex == 1,
                        ),
                        OnBoardingIndicator(
                          isSelected: currentIndex == 2,
                        ),
                      ],
                    ),
                    AppTextButton(
                      text: 'Next',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                      textColor: AppColors.PRIMARY_COLOR,
                      onPressed: goToNextPage,
                    ),
                  ],
                ),
              ),
              replacement: Padding(
                padding: EdgeInsets.symmetric(horizontal: 117.w, vertical: 45.h),
                child: AppElevatedButton(
                  onPressed: () => Get.off(LoginScreen()),
                  text: 'Get started',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void skip() {
    pageController.animateToPage(
      2,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void goToNextPage() {
    if (currentIndex == 2) {
      Get.off(LoginScreen());
    } else {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }
}
