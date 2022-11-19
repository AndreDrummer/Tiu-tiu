import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiutiu/core/pets/model/pet_model.dart';
import 'package:tiutiu/core/utils/other_functions.dart';
import 'package:tiutiu/core/constants/strings.dart';
import 'package:flutter/material.dart';

enum PetCaracteristicsEnum {
  content,
  title,
  icon,
}

class PetCaracteristics {
  PetCaracteristics({
    required this.content,
    required this.title,
    required this.icon,
  });

  String content;
  IconData icon;
  String title;

  static List<PetCaracteristics> petCaracteristics(Pet pet) {
    return <PetCaracteristics>[
          PetCaracteristics(
            icon: OtherFunctions.getIconFromPetType(pet.type),
            title: AppStrings.type,
            content: pet.type,
          ),
          PetCaracteristics(
            icon: pet.gender == PostDetailsStrings.female ? Icons.female : Icons.male,
            title: PostDetailsStrings.sex,
            content: pet.gender,
          ),
          PetCaracteristics(
            icon: Icons.linear_scale,
            title: PostDetailsStrings.breed,
            content: pet.breed,
          ),
          PetCaracteristics(
            icon: Icons.color_lens,
            title: PostDetailsStrings.color,
            content: pet.color,
          ),
          PetCaracteristics(
            icon: Icons.close_fullscreen,
            title: PostDetailsStrings.size,
            content: pet.size,
          ),
          PetCaracteristics(
            title: PostDetailsStrings.health,
            icon: FontAwesomeIcons.heartPulse,
            content:
                pet.health == PetHealthString.chronicDisease ? '${pet.health}:\n${pet.chronicDiseaseInfo}' : pet.health,
          ),
          PetCaracteristics(
            content: '${pet.ageYear}a ${pet.ageMonth}m',
            icon: FontAwesomeIcons.cakeCandles,
            title: PostDetailsStrings.age,
          ),
        ] +
        List.generate(
          pet.otherCaracteristics.length,
          (index) => PetCaracteristics(
            title: PostDetailsStrings.caracteristics,
            content: pet.otherCaracteristics[index],
            icon: Icons.auto_awesome,
          ),
        );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      PetCaracteristicsEnum.icon.name: icon.codePoint,
      PetCaracteristicsEnum.content.name: content,
      PetCaracteristicsEnum.title.name: title,
    };
  }
}
