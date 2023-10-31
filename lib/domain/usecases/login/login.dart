import 'package:flutter_chatapp/data/repositories/auth_repository.dart';
import 'package:flutter_chatapp/data/repositories/user_repository.dart';
import 'package:flutter_chatapp/domain/entities/result.dart';
import 'package:flutter_chatapp/domain/entities/user.dart';
import 'package:flutter_chatapp/domain/usecases/usecase.dart';

part 'login_params.dart';

class Login implements UseCase<Result<User>, LoginParams> {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  Login({required this.authRepository, required this.userRepository});

  @override
  Future<Result<User>> call(LoginParams params) async {
    final result = await authRepository.login(
        email: params.email, password: params.password);
    if (result is Success) {
      var user = await userRepository.getUser(uid: result.resultValue!);
      return switch (user) {
        Success(value: final user) => Result.success(user),
        Failed(:final message) => Result.failed(message)
      };
    }
    return Result.failed(result.errorMessage ?? '');
  }
}
