import 'package:dio/dio.dart';

import '../models/backend_codes.dart';

class DioException implements Exception {
  late BackendException errorMessage;

  DioException.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        errorMessage = BackendException(
            errorCode: 001, messague: 'Request to the server was cancelled.');
        break;
      case DioErrorType.connectTimeout:
        errorMessage =
            BackendException(errorCode: 001, messague: 'Connection timed out.');
        break;
      case DioErrorType.receiveTimeout:
        errorMessage = BackendException(
            errorCode: 001, messague: 'Receiving timeout occurred.');
        break;
      case DioErrorType.sendTimeout:
        errorMessage =
            BackendException(errorCode: 001, messague: 'Request send timeout.');
        break;
      case DioErrorType.response:
        errorMessage =
            _handleStatusCode(dioError.response?.statusCode, dioError);
        break;
      case DioErrorType.other:
        if (dioError.message.contains('SocketException')) {
          errorMessage =
              BackendException(errorCode: 001, messague: 'No Internet.');
          break;
        }
        errorMessage = BackendException(
            errorCode: 001, messague: 'Unexpected error occurred.');
        break;
      default:
        errorMessage =
            BackendException(errorCode: 001, messague: 'Something went wrong');
        break;
    }
  }

  BackendException _handleStatusCode(int? statusCode, DioError error) {
    switch (statusCode) {
      case 400:
        return BackendException(errorCode: 400, messague: 'Bad request.');
      case 401:
        return BackendException(
            errorCode: 400, messague: 'Authentication failed.');
      case 403:
        return BackendException(
            errorCode: 400,
            messague:
                'The authenticated user is not allowed to access the specified API endpoint.');
      case 404:
        return BackendException(
            errorCode: 400,
            messague: 'The requested resource does not exist',
            errorMensaje: error.response!.data['message']);
      case 405:
        return BackendException(
            errorCode: 400,
            messague:
                'Method not allowed. Please check the Allow header for the allowed HTTP methods.');
      case 415:
        return BackendException(
            errorCode: 400,
            messague:
                'Unsupported media type. The requested content type or version number is invalid.');
      case 422:
        return BackendException(
            errorCode: 400, messague: 'Data validation failed.');
      case 429:
        return BackendException(errorCode: 400, messague: 'Too many requests.');
      case 500:
        return BackendException(
            errorCode: 400, messague: 'Internal server error');
      default:
        return BackendException(
            errorCode: 400, messague: 'Oops something wen wrong!');
    }
  }

  // @override
  // String toString() =>
  //     '${errorMessage.errorCode} - ${errorMessage.messague} -${errorMessage.errorMensaje}';
}
