import 'package:tiutiu/core/constants/firebase_env_path.dart';
import 'package:tiutiu/core/constants/endpoints_name.dart';
import 'package:tiutiu/core/utils/endpoint_resolver.dart';
import 'package:tiutiu/core/system/model/endpoint.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class SystemService {
  Stream<List<Endpoint>> appEndpoints() {
    try {
      return _pathToEndpoints().snapshots().asyncMap((querySnapshots) {
        return querySnapshots.docs.map((snapshot) => Endpoint.fromSnapshot(snapshot)).toList();
      });
    } on FirebaseException catch (exception) {
      debugPrint('TiuTiuApp: Error occured when streaming app endpoints: ${exception.message}');
      rethrow;
    }
  }

  Future<List<Endpoint>> getEndpoints() async {
    try {
      final endpointsCollection = await _pathToEndpoints().get();

      return endpointsCollection.docs.map((snapshot) => Endpoint.fromSnapshot(snapshot)).toList();
    } on FirebaseException catch (exception) {
      debugPrint('TiuTiuApp: Error occured when trying get app endpoints: ${exception.message}');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getAdMobIds() async {
    try {
      final documentReferenceMap = await _pathToAdMobIDs().get();

      return (documentReferenceMap.data() as Map<String, dynamic>);
    } on FirebaseException catch (exception) {
      debugPrint('TiuTiuApp: Error occured when trying get app endpoints: ${exception.message}');
      rethrow;
    }
  }
}

CollectionReference<Map<String, dynamic>> _pathToEndpoints() {
  return FirebaseFirestore.instance
      .collection(FirebaseEnvPath.projectName)
      .doc(FirebaseEnvPath.env)
      .collection(FirebaseEnvPath.environment)
      .doc(FirebaseEnvPath.endpoints)
      .collection(FirebaseEnvPath.endpoints);
}

DocumentReference<Map<String, dynamic>> _pathToAdMobIDs() {
  return EndpointResolver.getDocumentEndpoint(EndpointNames.pathToAdMobIDs.name);
}
