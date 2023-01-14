import 'package:tiutiu/features/talk_with_us/widgets/body_card.dart';
import 'package:tiutiu/core/widgets/underline_input_dropdown.dart';
import 'package:tiutiu/features/talk_with_us/model/feedback.dart';
import 'package:tiutiu/core/widgets/no_connection_text_info.dart';
import 'package:tiutiu/core/widgets/default_basic_app_bar.dart';
import 'package:tiutiu/core/extensions/string_extension.dart';
import 'package:tiutiu/features/posts/widgets/text_area.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiutiu/core/controllers/controllers.dart';
import 'package:tiutiu/core/constants/assets_path.dart';
import 'package:tiutiu/core/views/load_dark_screen.dart';
import 'package:tiutiu/core/constants/text_styles.dart';
import 'package:tiutiu/core/constants/app_colors.dart';
import 'package:tiutiu/core/widgets/button_wide.dart';
import 'package:tiutiu/core/utils/asset_handle.dart';
import 'package:tiutiu/core/constants/strings.dart';
import 'package:tiutiu/core/widgets/add_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TalkWithUs extends StatefulWidget {
  TalkWithUs({super.key});

  @override
  State<TalkWithUs> createState() => _TalkWithUsState();
}

class _TalkWithUsState extends State<TalkWithUs> {
  final screenAnimationDuration = Duration(milliseconds: 500);
  bool showAddImagesWidget = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: systemController.getDeviceInfo(),
      builder: (context, snapshot) {
        return WillPopScope(
          onWillPop: () async {
            feedbackController.insertImages = false;

            return true;
          },
          child: Scaffold(
            appBar: DefaultBasicAppBar(text: MyProfileOptionsTile.talkWithUs),
            resizeToAvoidBottomInset: false,
            body: Obx(
              () {
                bool isPartnership = feedbackController.feedback.contactSubject == FeedbackStrings.wannaAnnounceOnApp ||
                    feedbackController.feedback.contactSubject == FeedbackStrings.partnership;

                return Container(
                  height: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetHandle.imageProvider(ImageAssets.bones2), fit: BoxFit.cover),
                  ),
                  child: Stack(
                    children: [
                      BodyCard(
                        bodyHeight: feedbackController.insertImages
                            ? Get.height
                            : isPartnership
                                ? Get.width * 1.1
                                : Get.width * 1.05,
                        child: ListView(
                          children: [
                            _selectYourSubject(),
                            _partnershipWarning(visible: isPartnership),
                            _describeYourMessage(),
                            _addImagesCheckbox(),
                            _screenshots(),
                            _submitButton(),
                          ],
                        ),
                      ),
                      LoadDarkScreen(
                        message: feedbackController.loadingText,
                        visible: feedbackController.isLoading,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _partnershipWarning({required bool visible}) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: EdgeInsets.only(bottom: 8.0.h),
        child: AutoSizeTexts.autoSizeText14(
          FeedbackStrings.partnershipWarning,
          textAlign: TextAlign.center,
          color: AppColors.secondary,
        ),
      ),
    );
  }

  Widget _selectYourSubject() {
    final talkWithUsSubjects = [
      FeedbackStrings.wannaAnnounceOnApp,
      FeedbackStrings.anotherUserIssue,
      FeedbackStrings.dificultsUse,
      FeedbackStrings.partnership,
      FeedbackStrings.dennounce,
      DeleteAccountStrings.bugs,
      '-',
    ];

    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0.h),
        child: UnderlineInputDropdown(
          labelText: FeedbackStrings.subject,
          isInErrorState:
              !feedbackController.feedback.contactSubject.isNotEmptyNeighterNull() && !feedbackController.isFormValid,
          items: talkWithUsSubjects,
          onChanged: (value) {
            feedbackController.updateFeedback(FeedbackEnum.contactSubject, value);
          },
          initialValue: feedbackController.feedback.contactSubject,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _describeYourMessage() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0.w),
      child: Obx(
        () => TextArea(
          initialValue: feedbackController.feedback.contactMessage,
          onChanged: (message) {
            feedbackController.updateFeedback(FeedbackEnum.contactMessage, message.trim());
          },
          isInErrorState:
              !feedbackController.feedback.contactMessage.isNotEmptyNeighterNull() && !feedbackController.isFormValid,
          labelText: FeedbackStrings.writeYourMessage,
          maxLines: 5,
        ),
      ),
    );
  }

  Widget _addImagesCheckbox() {
    return Obx(
      () => GestureDetector(
        onTap: () {
          feedbackController.insertImages = !feedbackController.insertImages;
        },
        child: AnimatedContainer(
          duration: screenAnimationDuration,
          child: Row(
            children: [
              SizedBox(width: 2.0.w),
              Checkbox(
                value: feedbackController.insertImages,
                onChanged: (_) {
                  feedbackController.insertImages = !feedbackController.insertImages;
                },
              ),
              AutoSizeTexts.autoSizeText16(
                FeedbackStrings.addImages,
                fontWeight: FontWeight.w500,
                color: AppColors.secondary,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _screenshots() {
    final addedImagesQty = feedbackController.feedback.screenshots.length;
    final hasErrorOnImages = feedbackController.insertImages &&
        feedbackController.feedback.screenshots.isEmpty &&
        !feedbackController.isFormValid;
    final images = feedbackController.feedback.screenshots;

    return AnimatedOpacity(
      opacity: feedbackController.insertImages ? 1 : 0,
      onEnd: () {
        setState(() {
          showAddImagesWidget = !showAddImagesWidget;
        });
      },
      duration: screenAnimationDuration,
      child: Visibility(
        visible: showAddImagesWidget,
        child: SizedBox(
          height: 280.0.h,
          child: AddImage(
            onRemovePictureOnIndex: feedbackController.removePictureOnIndex,
            onAddPictureOnIndex: feedbackController.addPictureOnIndex,
            maxImagesQty: feedbackController.maxScreenshots,
            addedImagesQty: addedImagesQty,
            hasError: hasErrorOnImages,
            images: images,
          ),
        ),
      ),
    );
  }

  Widget _submitButton() {
    return Obx(
      () => Padding(
        padding: EdgeInsets.only(top: 16.0.h),
        child: Visibility(
          visible: systemController.properties.internetConnected,
          child: ButtonWide(
            onPressed: feedbackController.submitForm,
            isLoading: feedbackController.isLoading,
            text: AppStrings.send,
          ),
          replacement: NoConnectionTextInfo(),
        ),
      ),
    );
  }
}
