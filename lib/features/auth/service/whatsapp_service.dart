import 'package:flutter/foundation.dart';
import 'package:tiutiu/core/constants/firebase_env_path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:tiutiu/core/controllers/controllers.dart';

class WhatsAppService {
  WhatsAppService({
    required this.phoneNumber,
    required this.code,
  });
  final String phoneNumber;
  final String code;

  Future<void> sendCodeVerification() async {
    final _dio = Dio();

    final DocumentSnapshot<Map<String, dynamic>> keys = await _getWhatsappKeys();
    final bool allowProd = keys.get(FirebaseEnvPath.allowUseWhatsappProdNumber);

    final String template = keys.get(
      (allowProd || !kDebugMode) ? FirebaseEnvPath.whatsappTemplateProd : FirebaseEnvPath.whatsappTemplateDebug,
    );

    final String numberId = keys.get(
      (allowProd || !kDebugMode) ? FirebaseEnvPath.whatsappNumberIdProd : FirebaseEnvPath.whatsappNumberIdDebug,
    );

    final String token = keys.get(
      (allowProd || !kDebugMode) ? FirebaseEnvPath.whatsappTokenProd : FirebaseEnvPath.whatsappTokenDebug,
    );

    String endpoint = 'https://graph.facebook.com/v15.0/$numberId/messages';

    final body = {
      "messaging_product": "whatsapp",
      "to": "55$phoneNumber",
      "type": "template",
      "template": {
        "name": "$template",
        "language": {"code": "pt_BR"},
        "components": [
          {
            "type": "body",
            "parameters": [
              {
                "type": "text",
                "text": "$code",
              }
            ]
          }
        ]
      }
    };

    try {
      _dio.post(
        endpoint,
        data: body,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
          contentType: 'application/json',
        ),
      );
    } on Exception catch (exception) {
      crashlyticsController.reportAnError(
        message: 'Error sending WhatsApp Message: $exception',
        exception: exception,
      );
      rethrow;
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _getWhatsappKeys() async {
    return await FirebaseFirestore.instance.collection(FirebaseEnvPath.projectName).doc(FirebaseEnvPath.keys).get();
  }
}
