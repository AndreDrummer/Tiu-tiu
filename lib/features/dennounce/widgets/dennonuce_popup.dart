import 'package:tiutiu/features/posts/widgets/text_area.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiutiu/core/controllers/controllers.dart';
import 'package:tiutiu/core/widgets/one_line_text.dart';
import 'package:tiutiu/core/constants/text_styles.dart';
import 'package:tiutiu/core/constants/app_colors.dart';
import 'package:tiutiu/core/constants/strings.dart';
import 'package:tiutiu/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DennouncePopup extends StatelessWidget {
  const DennouncePopup({
    required this.denounceDescription,
    required this.dennounceMotives,
    required this.onMotiveUpdate,
    this.motiveIsOther = true,
    this.isLoading = false,
    this.onMotiveDescribed,
    required this.onSubmit,
    required this.cancel,
    this.show = false,
    super.key,
  });

  final void Function(String)? onMotiveDescribed;
  final Function(int?) onMotiveUpdate;
  final List<String> dennounceMotives;
  final String denounceDescription;
  final Function() onSubmit;
  final bool motiveIsOther;
  final Function() cancel;
  final bool isLoading;
  final bool show;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Visibility(
        visible: show,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          margin: EdgeInsets.zero,
          padding: EdgeInsets.only(
            bottom: Dimensions.getDimensBasedOnDeviceHeight(
              smaller: motiveIsOther ? Get.width / 3.3 : Get.width / 3,
              bigger: motiveIsOther ? Get.width / 3.2 : Get.width / 2,
              medium: motiveIsOther ? Get.width / 3.3 : Get.width / 3,
            ),
            top: Dimensions.getDimensBasedOnDeviceHeight(
              bigger: motiveIsOther ? _topPadding(postDennounceController.hasError) : Get.width / 1.225,
              smaller: motiveIsOther ? Get.width * .75 : Get.width,
              medium: motiveIsOther ? Get.width * .75 : Get.width,
            ),
            right: Dimensions.getDimensBasedOnDeviceHeight(
              smaller: 56.0.w,
              bigger: 56.0.w,
              medium: 56.0.w,
            ),
            left: Dimensions.getDimensBasedOnDeviceHeight(
              smaller: 56.0.w,
              bigger: 56.0.w,
              medium: 56.0.w,
            ),
          ),
          height: Get.height,
          width: Get.width,
          color: AppColors.black.withOpacity(.5),
          child: Card(
            elevation: 16.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0.h),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0.h),
                color: AppColors.white,
              ),
              height: motiveIsOther ? Get.width * 1.15 : Get.width / 1.17,
              margin: EdgeInsets.zero,
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                children: [
                  _title(),
                  _content(),
                  _bottom(),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Column _title() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: OneLineText(text: 'Qual motivo da sua denúncia?', fontSize: 18),
        ),
        Divider(),
      ],
    );
  }

  Column _content() {
    return Column(
      children: [
        SizedBox(
          height: Get.height / 4.2,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: dennounceMotives.length,
            itemBuilder: (context, index) {
              final motive = dennounceMotives[index];

              return Obx(
                () => RadioListTile(
                  groupValue: postDennounceController.postDennounceGroupValue,
                  title: AutoSizeTexts.autoSizeText14(motive),
                  value: dennounceMotives.indexOf(motive),
                  activeColor: AppColors.secondary,
                  onChanged: onMotiveUpdate,
                ),
              );
            },
          ),
        ),
        Visibility(
          visible: motiveIsOther,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0.w),
            child: TextArea(
              isInErrorState: postDennounceController.hasError,
              initialValue: denounceDescription,
              labelText: 'Especifique o motivo',
              onChanged: onMotiveDescribed,
            ),
          ),
        ),
      ],
    );
  }

  Column _bottom() {
    return Column(
      children: [
        Divider(),
        Padding(
          padding: EdgeInsets.only(right: 8.0.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(child: AutoSizeTexts.autoSizeText14(AppStrings.cancel), onPressed: cancel),
              Visibility(
                replacement: _circularProgressIndicator(),
                child: TextButton(
                  child: AutoSizeTexts.autoSizeText14(PostDennounceStrings.dennounce),
                  onPressed: onSubmit,
                ),
                visible: !isLoading,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _circularProgressIndicator() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: CircularProgressIndicator(strokeWidth: 2),
      height: 16.0.h,
      width: 16.0.h,
    );
  }

  double _topPadding(bool hasError) => hasError ? Get.width * .65 : Get.width * .725;
}
