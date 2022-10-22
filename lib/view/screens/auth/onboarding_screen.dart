
import 'package:atharna/view/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../controller/on_boarding_provider.dart';
import '../../../model/sizer.dart';
import '../../resources/color_manager.dart';
import '../../resources/consts_manager.dart';
import '../../resources/style_manager.dart';
import '../../resources/values_manager.dart';

class OnBoardingScreen extends StatelessWidget {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OnBoardingProvider>(
        create: (_) => OnBoardingProvider(),
        child: Consumer<OnBoardingProvider>(builder: (ctx, onBoarding, child) {
          return Scaffold(
              body: Container(
                  padding: EdgeInsets.only(bottom: AppSize.s80),
                  child: PageView.builder(
                    itemCount: onBoarding.onBoardingList.length,
                    onPageChanged: (index) {
                      onBoarding.isLastIndex(index);
                      print("hh${onBoarding.isLastPage}");
                    },
                    controller: controller,
                    itemBuilder: (_, index) {
                      return Column(
                        children: [
                          if(index == 0)
                          SizedBox(height: AppSize.s50,),
                          FadeInUp(
                              child: Container(
                                width: double.infinity,
                                height: Sizer.getW(context) * 0.8,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(onBoarding.onBoardingList[index].image)
                                  )
                                ),
                              ),
                                  ),
                          SizedBox(
                            height: AppSize.s20,
                          ),
                          Text(
                            onBoarding.onBoardingList[index].text,
                            textAlign: TextAlign.center,
                            style: getRegularStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color,
                                fontSize: Sizer.getW(context) / 14),
                          )
                        ],
                      );
                    },
                  )),
              bottomSheet: onBoarding.isLastPage
                  ? TextButton(
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          primary: ColorManager.white,
                          backgroundColor: Theme.of(context).primaryColor,
                          minimumSize: Size.fromHeight(AppSize.s80)),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (ctx) => LoginScreen()));
                      },
                      child: Text(
                        "Get Started",
                        style: getRegularStyle(
                            color: ColorManager.white,
                            fontSize: Sizer.getW(context) / 22
                        ),
                      ))
                  : Container(
                      height: AppSize.s80,
                      padding: EdgeInsets.symmetric(horizontal: AppPadding.p8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () => controller.jumpToPage(2),
                              child: Text('Skip',style: getLightStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: Sizer.getW(context) / 24
                              ),)),
                          Center(
                            child: SmoothPageIndicator(
                              effect: SwapEffect(
                                  activeDotColor:
                                      Theme.of(context).primaryColor,
                                  dotWidth: AppSize.s12,
                                  dotHeight: AppSize.s12,
                                  type: SwapType.yRotation),
                              controller: controller,
                              count: 2,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                controller.nextPage(
                                    duration: Duration(
                                        milliseconds:
                                            AppConstants.onBoardingDelay),
                                    curve: Curves.easeInOut);
                              },
                              child: Text("Next",style: getLightStyle(
                                  color: Theme.of(context).primaryColor,
                                fontSize: Sizer.getW(context) / 24
                              ),
                              ))
                        ],
                      ),
                    ));
        }));
  }
}