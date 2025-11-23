import 'package:dio/dio.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/ exceptions.dart';
import '../../../../core/network/dio_client.dart';
import '../../data/models/login_model.dart';


class AuthRemoteDataSource {
  final Dio dio;
  AuthRemoteDataSource(this.dio);

  Future<LoginModel> login(String email, String password) async {
    try {
      final response = await dio.post(
        AppConstants.login,
        data: {"email": email, "password": password},
      );

      if (response.statusCode == 200) {
        return LoginModel.fromJson(response.data['data']);
      } else {
        throw ServerException(message: response.data['message']);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw NetworkException();
      }
      throw ServerException(message: e.response?.data['message'] ?? 'Error');
    }
  }
}
