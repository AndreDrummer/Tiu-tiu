import 'package:tiutiu/core/extensions/string_extension.dart';
import 'package:tiutiu/core/pets/model/pet_model.dart';
import 'package:tiutiu/features/posts/model/post.dart';
import 'package:flutter/widgets.dart';

final GlobalKey<FormState> diaseaseForm = GlobalKey<FormState>();
final GlobalKey<FormState> nameKeyForm = GlobalKey<FormState>();

class PostFormValidator {
  PostFormValidator(Post pet) : post = pet;

  final Post post;

  bool isStep1Valid(existChronicDiseaseInfo) {
    bool isValid = nameKeyForm.currentState!.validate() &&
        (post as Pet).health.isNotEmptyNeighterNull() &&
        (post as Pet).gender.isNotEmptyNeighterNull() &&
        (post as Pet).size.isNotEmptyNeighterNull();

    if (existChronicDiseaseInfo) {
      isValid = isValid && diaseaseForm.currentState!.validate();
    }

    return isValid;
  }

  bool isStep2Valid() {
    bool isValid = (post as Pet).breed.isNotEmptyNeighterNull() &&
        (post as Pet).color.isNotEmptyNeighterNull() &&
        post.description.isNotEmptyNeighterNull();

    return isValid;
  }

  bool isStep3Valid() => true;

  bool isStep4Valid(bool addressIsWithCompliment) {
    bool isValid = post.state.isNotEmptyNeighterNull() && post.city.isNotEmptyNeighterNull();

    if (addressIsWithCompliment && !(post as Pet).disappeared) {
      isValid = isValid && post.describedAddress.isNotEmptyNeighterNull();
    } else if (addressIsWithCompliment && (post as Pet).disappeared) {
      isValid = isValid && (post as Pet).lastSeenDetails.isNotEmptyNeighterNull();
    }

    return isValid;
  }

  bool isStep5Valid() {
    bool isValid = post.photos.isNotEmpty;
    return isValid;
  }
}
