import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiutiu/core/constants/images_assets.dart';
import 'package:tiutiu/core/constants/text_styles.dart';
import 'package:tiutiu/core/constants/app_colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final Color unselectedStepColor = Colors.grey;

class Steper extends StatelessWidget {
  const Steper({
    required this.currentStep,
    required this.stepsName,
    super.key,
  });

  final List<String> stepsName;
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    int n = 0;
    return Card(
      margin: EdgeInsets.all(8.0.h),
      elevation: 8.0.h,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0.h),
      ),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0.h),
          color: AppColors.black,
        ),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                stepsName.length - n,
                (index) => _SteperItem(
                  isCurrentStep: currentStep == index,
                  isCompleted: currentStep > index,
                  stepsQty: stepsName.length,
                  stepName: stepsName[index],
                  stepNumber: index + 1,
                  onStepTapped: () {},
                ),
              ),
            ),
            Positioned(
              left: 24.0.w,
              top: 20.0.h,
              right: 0.0.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  stepsName.length - (n + 1),
                  (index) {
                    return TweenAnimationBuilder(
                      duration: Duration(milliseconds: 1000),
                      tween: ColorTween(
                        end: currentStep > index
                            ? AppColors.primary
                            : currentStep > index
                                ? AppColors.white
                                : unselectedStepColor,
                        begin: currentStep > index
                            ? AppColors.white
                            : unselectedStepColor,
                      ),
                      builder: (context, color, _) {
                        return Container(
                          margin: EdgeInsets.only(right: 24.0.w),
                          padding: EdgeInsets.zero,
                          color: color as Color,
                          width: 32.0.w,
                          height: 1,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        width: Get.width,
        height: 56.0.h,
      ),
    );
  }
}

class _SteperItem extends StatelessWidget {
  const _SteperItem({
    this.isCurrentStep = false,
    required this.isCompleted,
    required this.stepNumber,
    required this.stepName,
    required this.stepsQty,
    this.onStepTapped,
  });

  final Function()? onStepTapped;
  final bool isCurrentStep;
  final bool isCompleted;
  final String stepName;
  final int stepNumber;
  final int stepsQty;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onStepTapped,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 8.0.h),
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: TweenAnimationBuilder(
                duration: Duration(milliseconds: 250),
                tween: ColorTween(
                  end: isCompleted
                      ? AppColors.primary
                      : isCurrentStep
                          ? AppColors.white
                          : unselectedStepColor,
                  begin: isCurrentStep ? AppColors.white : unselectedStepColor,
                ),
                builder: (context, color, _) {
                  return Image.asset(
                    color: color as Color,
                    ImageAssets.newLogo,
                  );
                },
              ),
              height: 24.0.h,
              width: 24.0.h,
            ),
            Container(
              alignment: Alignment.center,
              child: AutoSizeText(
                style: TextStyles.fontSize(
                  color: isCompleted
                      ? AppColors.primary
                      : isCurrentStep
                          ? AppColors.white
                          : unselectedStepColor,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                minFontSize: 8.0,
                maxFontSize: 10.0,
                stepName,
              ),
              width: 56.0.w,
              height: 24.0.h,
            )
          ],
        ),
      ),
    );
  }
}
