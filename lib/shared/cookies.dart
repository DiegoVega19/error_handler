import 'dart:convert';
import 'package:error_handler/models/backend_codes.dart';

class Cookies {
  static Future<String> fetchUserOrder() => Future.delayed(
        const Duration(seconds: 2),
        () =>
            'cdc9a8ca8aa17b6bed3aa3611a835105bbb4632514d7ca8cf55dbbc5966a7cae',
      );

  static BackendException decodeBackendResponse(Object? errorResponse) {
    String response = json.encode(errorResponse);
    final dataDecoded = json.decode(response);
    return BackendException.fromJson(dataDecoded);
  }
}
