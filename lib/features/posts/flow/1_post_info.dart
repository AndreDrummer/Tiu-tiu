import 'package:tiutiu/features/posts/validators/form_validators.dart';
import 'package:tiutiu/core/widgets/underline_input_dropdown.dart';
import 'package:tiutiu/core/extensions/string_extension.dart';
import 'package:tiutiu/features/posts/widgets/text_area.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiutiu/core/controllers/controllers.dart';
import 'package:tiutiu/core/widgets/underline_text.dart';
import 'package:tiutiu/features/posts/model/post.dart';
import 'package:tiutiu/core/pets/model/pet_model.dart';
import 'package:tiutiu/core/constants/strings.dart';
import 'package:tiutiu/core/utils/validators.dart';
import 'package:tiutiu/core/data/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView(
        padding: EdgeInsets.only(top: 8.0.h),
        children: [
          _petName(),
          _gender(),
          _petSize(),
          SizedBox(height: 24.0.h),
          _health(),
        ],
      ),
    );
  }

  Padding _petName() {
    return Padding(
      padding: EdgeInsets.fromLTRB(3.0.w, 0.0.h, 3.0.w, 16.0.h),
      child: Form(
        key: nameKeyForm,
        child: Obx(
          () => UnderlineInputText(
            initialValue: postsController.post.name,
            validator: Validators.verifyEmpty,
            maxLength: 20,
            onChanged: (name) {
              nameKeyForm.currentState!.validate();
              postsController.updatePost(PostEnum.name.name, name.trim());
            },
            labelText: PostFlowStrings.petName,
            fontSizeLabelText: 12.0,
          ),
        ),
      ),
    );
  }

  UnderlineInputDropdown _gender() {
    final petType = (postsController.post as Pet).type;
    late List<String> items;

    switch (petType) {
      case PetTypeStrings.dog:
      case PetTypeStrings.cat:
        items = DummyData.gender.sublist(0, 3);
        break;

      default:
        items = DummyData.gender;
    }

    return UnderlineInputDropdown(
      isInErrorState: !(postsController.post as Pet).gender.isNotEmptyNeighterNull() && !postsController.formIsValid,
      initialValue: (postsController.post as Pet).gender.toString(),
      onChanged: (gender) {
        if (gender == PostDetailsStrings.male) {
          postsController.updatePost(PetEnum.health.name, '-');
        }

        postsController.updatePost(PetEnum.gender.name, gender);
      },
      labelText: PostDetailsStrings.sex,
      items: items,
      fontSize: 10,
    );
  }

  Padding _petSize() {
    return Padding(
      padding: EdgeInsets.only(top: 32.0.h),
      child: UnderlineInputDropdown(
        isInErrorState: !(postsController.post as Pet).size.isNotEmptyNeighterNull() && !postsController.formIsValid,
        initialValue: (postsController.post as Pet).size.toString(),
        onChanged: (size) {
          postsController.updatePost(PetEnum.size.name, size);
        },
        labelText: PostFlowStrings.size,
        items: DummyData.size,
        fontSize: 10,
      ),
    );
  }

  Widget _health() {
    final petIsMale = (postsController.post as Pet).gender == PostDetailsStrings.male;
    List<String> healthState = DummyData.health;

    if (petIsMale) {
      healthState.remove(PetHealthString.preganant);
    } else if (!healthState.contains(PetHealthString.preganant)) {
      healthState.add(PetHealthString.preganant);
    }

    return AnimatedContainer(
      height: postsController.existChronicDisease ? 152.0.h : 80.0.h,
      margin: EdgeInsets.only(bottom: 8.0.h),
      duration: Duration(milliseconds: 500),
      child: ListView(
        children: [
          UnderlineInputDropdown(
            isInErrorState:
                !(postsController.post as Pet).health.isNotEmptyNeighterNull() && !postsController.formIsValid,
            initialValue: (postsController.post as Pet).health.toString(),
            onChanged: (health) {
              postsController.updatePost(PetEnum.health.name, health);
            },
            labelText: PostDetailsStrings.health,
            items: healthState,
            fontSize: 10,
          ),
          _chronicDiseaseInfo(),
        ],
      ),
    );
  }

  Visibility _chronicDiseaseInfo() {
    return Visibility(
      visible: postsController.existChronicDisease,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0.h),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: diaseaseForm,
                child: TextArea(
                  isInErrorState: !(postsController.post as Pet).chronicDiseaseInfo.isNotEmptyNeighterNull() &&
                      !postsController.formIsValid,
                  maxLines: 1,
                  onChanged: (chronicDiseaseInfo) {
                    postsController.updatePost(
                      PetEnum.chronicDiseaseInfo.name,
                      chronicDiseaseInfo,
                    );
                  },
                  initialValue: (postsController.post as Pet).chronicDiseaseInfo,
                  validator: postsController.existChronicDisease ? Validators.verifyEmpty : null,
                  labelText: PostFlowStrings.describeDiseaseType,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
