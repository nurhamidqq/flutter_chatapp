import 'package:flutter_chatapp/data/repositories/auth_repository.dart';
import 'package:flutter_chatapp/data/repositories/user_repository.dart';
import 'package:flutter_chatapp/domain/entities/user.dart';
import 'package:flutter_chatapp/domain/usecases/usecase_stream.dart';

class GetListUser implements UseCaseStream<List<User>?, void> {
  final UserRepository _userRepository;
  final AuthRepository _authRepository;
  GetListUser({
    required UserRepository userRepository,
    required AuthRepository authRepository,
  })  : _userRepository = userRepository,
        _authRepository = authRepository;
  @override
  Stream<List<User>?> call(void _) async* {
    final currentUser = _authRepository.getLoggedInUserId();
    var data = _userRepository.getUsers(uid: currentUser!);
    yield* data;
  }
}
