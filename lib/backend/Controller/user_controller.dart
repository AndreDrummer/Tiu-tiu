import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/user_model.dart';

class UserController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<User> getUser(String id) async {
    User user;
    await firestore.collection('User').doc(id).snapshots().first.then((value) {
      user = User(
        id: value.data()['id'],
        name: value.data()['name'],
        photoURL: value.data()['photoURL'],
        email: value.data()['email'],
        password: value.data()['password'],
        phoneNumber: value.data()['phoneNumber'],
        landline: value.data()['landline'],
      );
    });

    return user;
  }

  Future<User> getUserByReference(DocumentReference userReference) async {
    User user = User.fromSnapshot(await userReference.get());

    return user;
  }

  Future<void> favorite(
      String userID, DocumentReference petReference, bool add) async {
    final favorite = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userID)
        .collection('Pets')
        .doc('favorites')
        .collection('favorites');

    if (add) {
      favorite.doc().set({'id': petReference});
    } else {
      var petToDelete;

      await favorite.where("id", isEqualTo: petReference).get().then((value) {
        petToDelete = value.docs.first.id;
      });

      favorite.doc(petToDelete).delete();
    }
  }

  Future<void> donatePetToSomeone({
    String userDonateId,
    String userAdoptId,
    DocumentReference petReference,
    DocumentReference userThatDonate,
    int userPosition,
  }) async {
    var user = await userThatDonate.get();
    var pet = await petReference.get();
    
    await firestore
        .collection('Users')
        .doc(userAdoptId)
        .collection('Pets')
        .doc('adopted')
        .collection('Adopteds')
        .doc()
        .set({
      'petRef': petReference,
      'confirmed': false,
      'userThatDonate': user.data()['displayName'],
      'petName': pet.data()['name']
    });

    final interestedRef = await petReference.collection('adoptInteresteds').get();
    List interestedUsers = interestedRef.docs;

    for (int i = 0; i < interestedUsers.length; i++) {
      print("${interestedUsers[i].data()['position']} == $userPosition");
      if (interestedUsers[i].data()['position'] == userPosition) {
        var data = interestedUsers[i].data();
        data['sinalized'] = true;        
        petReference.collection('adoptInteresteds').doc(interestedUsers[i].id).set(data);
        break;
      }
    }            
  }

  Future<void> confirmDonate(DocumentReference petReference,
      DocumentReference userThatAdoptedId) async {
    await petReference.set(
        {'donated': true, 'whoAdoptedReference': userThatAdoptedId},
        SetOptions(merge: true));
    final pathToPet = userThatAdoptedId
        .collection('Pets')
        .doc('adopted')
        .collection('Adopteds');
    final userThatIsAdopting =
        await pathToPet.where("petRef", isEqualTo: petReference).get();
    final updateData = userThatIsAdopting.docs.first.reference;
    updateData.set({'confirmed': true}, SetOptions(merge: true));
  }

  Future<void> denyDonate(DocumentReference petReference,
      DocumentReference userThatAdoptedId) async {
    final interestedRef = await petReference.collection('adoptInteresteds').get();
    List interestedUsers = interestedRef.docs;
    for (int i = 0; i < interestedUsers.length; i++) {
      if (interestedUsers[i].data()['userReference'] == userThatAdoptedId) {
        var data = interestedUsers[i].data();
        data['gaveup'] = true; 
        petReference.collection('adoptInteresteds').doc(interestedUsers[i].id).set(data);
        break;
      }
    }    

    final pathToPet = userThatAdoptedId
        .collection('Pets')
        .doc('adopted')
        .collection('Adopteds');
    final userThatIsAdopting =
        await pathToPet.where("petRef", isEqualTo: petReference).get();
    final ref = userThatIsAdopting.docs.first.reference;
    ref.delete();
  }

  Future<List<User>> getAllUsers() async {
    var users = [];
    await firestore.collection('Users').get().then((value) {
      value.docs.forEach((element) {
        users.add(User.fromSnapshot(element).toJson());
      });
    });
    return users;
  }

  Future<void> insertUser(User user) async {
    await firestore.collection('Users').doc().set(user.toMap()).then((value) {
      print('Usuário Inserido!');
    });
  }

  Future<void> updateUser(User user) async {
    await firestore.collection('Users').doc(user.id).update(user.toMap());
  }

  Future<void> deleteUser(String id) async {
    await firestore.collection('Users').doc(id).delete();
  }
}
