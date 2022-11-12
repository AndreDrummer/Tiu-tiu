import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:tiutiu/core/constants/firebase_env_path.dart';
import 'package:tiutiu/features/chat/model/contact.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiutiu/features/chat/model/message.dart';

class ChatService extends GetxController {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Message>> messages(String userId, String contactId) {
    return _pathToMessages(userId, contactId)
        .orderBy(MessageEnum.createdAt.name, descending: false)
        .snapshots()
        .asyncMap((snapshot) {
      return snapshot.docs.map((favorite) => Message.fromSnapshot(favorite)).toList();
    });
  }

  Stream<List<Contact>> contacts(String userId) {
    return _pathToContacts(userId)
        .orderBy(ContactEnum.lastMessageTime.name, descending: true)
        .snapshots()
        .asyncMap((snapshot) {
      return snapshot.docs.map((favorite) => Contact.fromSnapshot(favorite)).toList();
    });
  }

  void sendMessage(Message message, Contact contact) {
    /// Because that Firebase does not support queries like OR, we need to duplicate the data there
    /// in order to guarantee performance. So that is why we need to record the same data in a path
    /// under the user sender messages collection and another under the user receiver messages collection.

    _pathToMessages(message.senderId!, contact.id!).doc(message.id).set(message.toJson());
    _pathToContact(message.senderId!, contact.id!).set(contact.toJson());

    _pathToMessages(message.receiverId!, contact.id!).doc(message.id).set(message.toJson());
    _pathToContact(message.receiverId!, contact.id!).set(contact.toJson());
  }

  CollectionReference<Map<String, dynamic>> _pathToContacts(String userId) {
    return _firestore
        .collection(FirebaseEnvPath.projectName)
        .doc(FirebaseEnvPath.env)
        .collection(FirebaseEnvPath.environment)
        .doc(FirebaseEnvPath.contacts)
        .collection(userId);
  }

  DocumentReference<Map<String, dynamic>> _pathToContact(String userId, String contactId) {
    return _firestore
        .collection(FirebaseEnvPath.projectName)
        .doc(FirebaseEnvPath.env)
        .collection(FirebaseEnvPath.environment)
        .doc(FirebaseEnvPath.contacts)
        .collection(userId)
        .doc(contactId);
  }

  CollectionReference<Map<String, dynamic>> _pathToMessages(String userId, String contactId) {
    return _firestore
        .collection(FirebaseEnvPath.projectName)
        .doc(FirebaseEnvPath.env)
        .collection(FirebaseEnvPath.environment)
        .doc(FirebaseEnvPath.contacts)
        .collection(userId)
        .doc(contactId)
        .collection(FirebaseEnvPath.messages);
  }
}
