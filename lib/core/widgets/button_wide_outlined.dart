import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiutiu/core/constants/text_styles.dart';
import 'package:tiutiu/core/constants/app_colors.dart';
import 'package:tiutiu/core/constants/strings.dart';
import 'package:flutter/material.dart';

class OutlinedButtonWide extends StatelessWidget {
  OutlinedButtonWide({
    this.isToExpand = false,
    this.rounded = true,
    this.textColor,
    this.onPressed,
    this.color,
    this.icon,
    this.text,
  });

  final Color? textColor;
  final Function? onPressed;
  final bool isToExpand;
  final IconData? icon;
  final String? text;
  final Color? color;
  final bool rounded;

  @override
  Widget build(BuildContext context) {
    final hasIcon = icon != null;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OutlinedButton(
        style: ElevatedButton.styleFrom(
          side: BorderSide(
            color: color ?? AppColors.secondary,
            style: BorderStyle.solid,
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              rounded ? 24.0.h : 8.0.h,
            ),
          ),
        ),
        onPressed: () => onPressed?.call(),
        child: Container(
          alignment: Alignment.center,
          height: 48.0.h,
          child: Row(
            mainAxisAlignment: hasIcon ? MainAxisAlignment.start : MainAxisAlignment.center,
            children: [
              Visibility(
                visible: hasIcon,
                child: Icon(
                  color: textColor ?? AppColors.white,
                  size: 20.0.h,
                  icon,
                ),
              ),
              Spacer(),
              AutoSizeTexts.autoSizeText16(
                color: color ?? AppColors.secondary,
                text ?? AppStrings.getStarted,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w700,
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
