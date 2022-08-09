// To parse this JSON data, do
//
//     final backendException = backendExceptionFromJson(jsonString);

import 'dart:convert';

BackendException backendExceptionFromJson(String str) =>
    BackendException.fromJson(json.decode(str));

String backendExceptionToJson(BackendException data) =>
    json.encode(data.toJson());

class BackendException {
  BackendException({
    this.errorCode,
    this.messague,
    this.errorMensaje,
  });

  int? errorCode;
  String? messague;
  String? errorMensaje;

  factory BackendException.fromJson(Map<String, dynamic> json) =>
      BackendException(
        errorCode: json["errorCode"],
        messague: json["messague"],
        errorMensaje: json["errorMensaje"],
      );

  Map<String, dynamic> toJson() => {
        "errorCode": errorCode,
        "messague": messague,
        "errorMensaje": errorMensaje,
      };

  int get age {
    return 1;
  }
}
