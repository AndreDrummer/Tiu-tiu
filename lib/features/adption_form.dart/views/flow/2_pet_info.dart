import 'package:tiutiu/core/widgets/underline_input_dropdown.dart';
import 'package:tiutiu/features/posts/widgets/text_area.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiutiu/core/controllers/controllers.dart';
import 'package:tiutiu/core/constants/text_styles.dart';
import 'package:tiutiu/core/constants/strings.dart';
import 'package:tiutiu/core/data/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PetInfo extends StatefulWidget {
  const PetInfo({super.key});

  @override
  State<PetInfo> createState() => _PetInfoState();
}

class _PetInfoState extends State<PetInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 8.0.h),
            children: [
              SizedBox(height: 16.0.h),
              petType(),
              SizedBox(height: 8.0.h),
              _petBreed(),
              SizedBox(height: 16.0.w),
              _petExperience(),
              _reason(),
            ],
          );
        },
      ),
    );
  }

  UnderlineInputDropdown petType() {
    return UnderlineInputDropdown(
      initialValue: adoptionFormController.adoptionForm.interestedType,
      onChanged: (type) {
        adoptionFormController.setAdoptionForm(
          adoptionFormController.adoptionForm.copyWith(interestedType: type),
        );
        adoptionFormController.setAdoptionForm(
          adoptionFormController.adoptionForm.copyWith(interestedBreed: '-'),
        );
      },
      labelText: 'Qual tipo de animal está interessado?',
      fontSize: 14,
      items: adoptionFormController.petsType,
    );
  }

  UnderlineInputDropdown _petBreed() {
    return UnderlineInputDropdown(
      initialValue: adoptionFormController.adoptionForm.interestedBreed,
      onChanged: (breed) {
        adoptionFormController.setAdoptionForm(
          adoptionFormController.adoptionForm.copyWith(interestedBreed: breed),
        );
      },
      items: DummyData.breeds[adoptionFormController.adoptionForm.interestedType]!,
      labelText: PostDetailsStrings.selectBreed,
      fontSize: 12.0,
    );
  }

  Column _petExperience() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.h),
          child: AutoSizeTexts.autoSizeText16(
            'Você tem experiência com esse tipo de animal?',
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          children: [
            SizedBox(width: 8.0.w),
            Expanded(
              child: CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                title: AutoSizeTexts.autoSizeText12(AppStrings.yes),
                onChanged: (_) {
                  adoptionFormController.setAdoptionForm(
                    adoptionFormController.adoptionForm.copyWith(alreadyHadAnimalsLikeThat: true),
                  );
                },
                value: adoptionFormController.adoptionForm.alreadyHadAnimalsLikeThat,
              ),
            ),
            Expanded(
              child: CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                title: AutoSizeTexts.autoSizeText12(AppStrings.no),
                onChanged: (_) {
                  adoptionFormController.setAdoptionForm(
                    adoptionFormController.adoptionForm.copyWith(alreadyHadAnimalsLikeThat: false),
                  );
                },
                value: !adoptionFormController.adoptionForm.alreadyHadAnimalsLikeThat,
              ),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }

  Padding _reason() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.h, vertical: 4.0.h),
      child: Column(
        children: [
          AutoSizeTexts.autoSizeText16(
            'Por que você quer adotar esse animal em particular?',
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 8.0.h),
          TextArea(
            labelText: 'Por que você quer adotar esse animal em particular?',
            hintText: 'Por que você quer adotar esse animal em particular?',
            initialValue: adoptionFormController.adoptionForm.reason,
            onChanged: (value) {
              adoptionFormController.setAdoptionForm(
                adoptionFormController.adoptionForm.copyWith(reason: value),
              );
            },
          ),
        ],
      ),
    );
  }
}
