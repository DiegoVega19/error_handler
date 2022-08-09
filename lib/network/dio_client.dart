import 'package:dio/dio.dart';
import 'package:error_handler/models/backend_codes.dart';
import 'package:error_handler/network/dio_exception.dart';
import 'package:flutter/foundation.dart';

import '../models/user.dart';
import 'endpoints.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/loggin_interceptor.dart';

class DioClient {
  DioClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: 'https://gorest.co.in/public/v2',
            connectTimeout: 5000,
            receiveTimeout: 3000,
            responseType: ResponseType.json,
          ),
        )..interceptors.addAll([
            AuthorizationInterceptor(),
            LoggerInterceptor(),
          ]);

  late final Dio _dio;

  Future<User?> getUser({required int id}) async {
    try {
      final response = await _dio.get('${Endpoints.users}/$id');
      return User.fromJson(response.data);
    } on DioError catch (err) {
      final errors = DioException.fromDioError(err);
      throw BackendException(
          errorCode: errors.errorMessage.errorCode,
          messague: errors.errorMessage.messague);
    } catch (e) {
      if (kDebugMode) print(e);
      throw e.toString();
    }
  }

  Future<User?> createUser({required User user}) async {
    try {
      final response = await _dio.post('/users', data: user.toJson());
      return User.fromJson(response.data);
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      throw e.toString();
    }
  }

  // Deletes a user having the provided `id`.
  // The access-token has been passed using [AuthorizationInterceptor].
  Future<void> deleteUser({required int id}) async {
    try {
      await _dio.delete('/users/$id');
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      if (kDebugMode) print(e);
      throw e.toString();
    }
  }
}
