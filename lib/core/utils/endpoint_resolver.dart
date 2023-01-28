import 'package:tiutiu/core/constants/firebase_env_path.dart';
import 'package:tiutiu/core/controllers/controllers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class EndpointResolver {
  static CollectionReference<Map<String, dynamic>> getCollectionEndpoint(String endpointName, [List? params]) {
    return FirebaseFirestore.instance.collection(formattedEndpoint(endpointName, params));
  }

  static DocumentReference<Map<String, dynamic>> getDocumentEndpoint(String endpointName, [List? params]) {
    return FirebaseFirestore.instance.doc(formattedEndpoint(endpointName, params));
  }

  static String formattedEndpoint(String endpointName, [List? params]) {
    final endpoint = systemController.endpoints.firstWhere((endpoint) => endpoint.name == endpointName);
    final build = kDebugMode ? EnvironmentBuild.debug.name : EnvironmentBuild.prod.name;
    String endpointPath = endpoint.path;

    endpointPath = endpointPath.replaceAll('%build', 'prod');

    if (params != null && params.isNotEmpty) {
      for (int i = 0; i < params.length; i++) {
        endpointPath = endpointPath.replaceAll('%$i', params.elementAt(i));
      }
    }

    return endpointPath;
  }
}
