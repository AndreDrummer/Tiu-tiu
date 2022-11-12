import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiutiu/core/constants/text_styles.dart';
import 'package:tiutiu/core/constants/app_colors.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:tiutiu/core/utils/formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble({
    required this.lastMessageWasMine,
    required this.belongToMe,
    required this.message,
    required this.time,
    super.key,
  });

  final bool lastMessageWasMine;
  final bool belongToMe;
  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return ChatBubble(
      margin: EdgeInsets.only(top: lastMessageWasMine ? 12.0.h : 4.0.h, left: 5.0.w, right: 5.0.w),
      backGroundColor: belongToMe ? Colors.lightGreen : Colors.deepPurple,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(child: AutoSizeTexts.autoSizeText14(message, color: AppColors.white), width: Get.width / 1.6),
          Container(
            child: AutoSizeTexts.autoSizeText10(Formatters.getFormattedTime(time), color: AppColors.white),
            margin: EdgeInsets.only(top: 32.0.h),
            alignment: Alignment(1, 1),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
      clipper: ChatBubbleClipper1(
        type: belongToMe ? BubbleType.receiverBubble : BubbleType.sendBubble,
        nipWidth: 5.0.w,
        radius: 12.0.h,
      ),
      alignment: belongToMe ? Alignment.centerLeft : Alignment.centerRight,
    );
  }
}
