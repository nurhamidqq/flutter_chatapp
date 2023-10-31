import 'package:flutter_chatapp/domain/entities/result.dart';

abstract interface class AuthRepository {
  Future<Result<String>> login(
      {required String email, required String password});
  Future<Result<void>> logout();
  String? getLoggedInUserId();
  Future<Result<String>> register(
      {required String email, required String password});
}
