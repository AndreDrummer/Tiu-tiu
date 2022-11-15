import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiutiu/features/chat/model/message.dart';
import 'package:tiutiu/features/system/controllers.dart';
import 'package:tiutiu/core/constants/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiutiu/core/constants/strings.dart';
import 'package:tiutiu/core/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final Color destakColor = AppColors.secondary;
  final _controller = TextEditingController();
  final Color whiteColor = AppColors.white;
  String _enteredMessage = '';

  Future<void> _sendMessage() async {
    await chatController.sendNewMessage(
      Message(
        receiver: chatController.userChatingWith,
        sender: tiutiuUserController.tiutiuUser,
        createdAt: FieldValue.serverTimestamp(),
        text: _enteredMessage,
        id: Uuid().v4(),
      ),
    );

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          bottom:
              Dimensions.getDimensBasedOnDeviceHeight(minDeviceHeightDouble: 0.0.h, greaterDeviceHeightDouble: 8.0.h)),
      padding: const EdgeInsets.all(6.0),
      child: Row(
        children: [
          Expanded(
            child: Card(
              elevation: 16.0,
              color: whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24)),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 16.0.w),
                child: TextField(
                  controller: _controller,
                  onSubmitted: (value) async => await _sendMessage(),
                  textCapitalization: TextCapitalization.sentences,
                  style: TextStyle(color: Colors.black54),
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
                    disabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: ChatStrings.writeYourMessage,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _enteredMessage = value;
                    });
                  },
                ),
              ),
            ),
          ),
          GestureDetector(
            child: SizedBox(
              height: 56.0,
              width: 56.0,
              child: Card(
                elevation: 16.0,
                color: destakColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(1000)),
                ),
                child: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  margin: EdgeInsets.only(left: 8.0.w),
                  child: Padding(
                    child: Icon(Icons.send_rounded, color: whiteColor),
                    padding: EdgeInsets.only(right: 4.0.w),
                  ),
                ),
              ),
            ),
            onTap: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          )
        ],
      ),
    );
  }
}
