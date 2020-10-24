import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tiutiu/backend/Model/pet_model.dart';

class PetsProvider with ChangeNotifier {
  final _petKind = BehaviorSubject<String>();
  final _petType = BehaviorSubject<String>();
  final _breedSelected = BehaviorSubject<String>();
  final _sizeSelected = BehaviorSubject<String>();
  final _ageSelected = BehaviorSubject<String>();
  final _sexSelected = BehaviorSubject<String>();
  final _healthSelected = BehaviorSubject<String>();
  bool _isFiltering = false;

  // Listenning to The Data
  Stream<String> get petKind => _petKind.stream;
  Stream<String> get petType => _petType.stream;
  Stream<String> get breedSelected => _breedSelected.stream;
  Stream<String> get sizeSelected => _sizeSelected.stream;
  Stream<String> get ageSelected => _ageSelected.stream;
  Stream<String> get sexSelected => _sexSelected.stream;
  Stream<String> get healthSelected => _healthSelected.stream;

  // Changing the data
  void Function(String) get changePetKind => _petKind.sink.add;
  void Function(String) get changePetType => _petType.sink.add;
  void Function(String) get changeBreedSelected => _breedSelected.sink.add;
  void Function(String) get changeSizeSelected => _sizeSelected.sink.add;
  void Function(String) get changeAgeSelected => _ageSelected.sink.add;
  void Function(String) get changeSexSelected => _sexSelected.sink.add;
  void Function(String) get changeHealthSelected => _healthSelected.sink.add;

  // Getting data
  String get getPetKind => _petKind.value;
  String get getPetType => _petType.value;
  String get getBreedSelected => _breedSelected.value;
  String get getSizeSelected => _sizeSelected.value;
  String get getAgeSelected => _ageSelected.value;
  String get getSexSelected => _sexSelected.value;
  String get getHealthSelected => _healthSelected.value;

  void changeIsFiltering(bool status) {
    _isFiltering = status;
  }

  List<Pet> getPetListFromSnapshots(List<DocumentSnapshot> docs) {
    List<Pet> pets = [];    
    for (int i = 0; i < docs.length; i++) {
      pets.add(Pet.fromSnapshot(docs[i]));
    }
    return pets;
  }

  Stream<QuerySnapshot> loadDisappearedPETS() {
    return _isFiltering && getPetKind == 'Disappeared'
        ? loadFilteredPETS()
        : FirebaseFirestore.instance.collection('Disappeared').snapshots();
  }

  Stream<QuerySnapshot> loadDonatedPETS() {
    return _isFiltering && getPetKind == 'Donate'
        ? loadFilteredPETS()
        : FirebaseFirestore.instance.collection('Donate').snapshots();
  }

  List<String> _filters() {
    return [
      getPetType,
      getBreedSelected,
      getSizeSelected,
      getAgeSelected,
      getSexSelected,
      getHealthSelected
    ];
  }

  List<String> _filtersType() {
    return ["type", "breed", "size", "ano", "sex", "health"];
  }

  Stream<QuerySnapshot> loadFilteredPETS() {
    Query query = FirebaseFirestore.instance
        .collection(getPetKind)
        .where(getPetKind == 'Donate' ? 'donated' : 'found', isEqualTo: false);

    print(
        'Filtro: \n Tipo: $getPetType\nKind: $getPetKind\nRaça: $getBreedSelected\nTamanho: $getSizeSelected\nAno: $getAgeSelected\nSexo: $getSexSelected\nSaúde: $getHealthSelected');

    for (int i = 0; i < _filters().length; i++) {
      if (_filters()[i].isNotEmpty && _filters()[i] != null) {
        query = query.where(_filtersType()[i], isEqualTo: _filters()[i]);
      }
    }

    return query.snapshots();
  }
}
