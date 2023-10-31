import 'package:flutter_chatapp/data/repositories/auth_repository.dart';
import 'package:flutter_chatapp/domain/entities/result.dart';
import 'package:flutter_chatapp/domain/usecases/usecase.dart';

class Logout implements UseCase<Result<void>, void> {
  final AuthRepository _authentication;

  Logout({required AuthRepository authentication})
      : _authentication = authentication;

  @override
  Future<Result<void>> call(void params) {
    return _authentication.logout();
  }
}
