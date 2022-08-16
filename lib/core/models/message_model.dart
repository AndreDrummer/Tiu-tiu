import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiutiu/features/tiutiu_user/model/tiutiu_user.dart';

class Message {
  Message({
    required this.receiverNotificationToken,
    required this.notificationType,
    required this.receiverId,
    required this.createdAt,
    required this.userId,
    required this.text,
    required this.user,
    this.userReference,
  });

  Message.fromSnapshot(DocumentSnapshot snapshot)
      : text = (snapshot.data() as Map<String, dynamic>)['text'],
        createdAt = (snapshot.data() as Map<String, dynamic>)['createdAt'],
        userId = (snapshot.data() as Map<String, dynamic>)['userId'],
        user = TiutiuUser.fromMap(
            (snapshot.data() as Map<String, dynamic>)['user']),
        receiverId = (snapshot.data() as Map<String, dynamic>)['receiverId'],
        receiverNotificationToken = (snapshot.data()
            as Map<String, dynamic>)['receiverNotificationToken'],
        notificationType =
            (snapshot.data() as Map<String, dynamic>)['notificationType'],
        userReference =
            (snapshot.data() as Map<String, dynamic>)['userReference'];

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'createdAt': createdAt,
      'userId': userId,
      'user': user.toMap(),
      'receiverId': receiverId,
      'receiverNotificationToken': receiverNotificationToken,
      'notificationType': notificationType,
      'userReference': userReference
    };
  }

  DocumentReference? userReference;
  String receiverNotificationToken;
  String notificationType;
  String receiverId;
  dynamic createdAt;
  TiutiuUser user;
  String userId;
  String text;
}
