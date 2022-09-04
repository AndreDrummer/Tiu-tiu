import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiutiu/core/constants/text_styles.dart';
import 'package:tiutiu/core/constants/strings.dart';
import 'package:flutter/material.dart';

class BackToStart extends StatelessWidget {
  const BackToStart({super.key, this.onPressed});

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.backToStart.toUpperCase(),
              style: TextStyles.fontSize12(
                fontWeight: FontWeight.w700,
                color: Colors.blue,
              ),
            ),
            Icon(
              Icons.arrow_drop_up_sharp,
              color: Colors.blue,
            )
          ],
        ),
      ),
      onPressed: onPressed,
    );
  }
}
