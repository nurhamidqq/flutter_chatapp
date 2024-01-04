import 'package:flutter_chatapp/domain/entities/result.dart';
import 'package:flutter_chatapp/domain/entities/user.dart';

abstract interface class UserRepository {
  Future<Result<User>> getUser({required String uid});
  Future<Result<User>> createUser({
    required String uid,
    required String email,
    required String name,
  });
  Stream<List<User>?> getUsers({required String uid});
}
