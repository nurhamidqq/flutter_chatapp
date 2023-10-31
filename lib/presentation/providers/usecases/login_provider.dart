import 'package:flutter_chatapp/domain/usecases/login/login.dart';
import 'package:flutter_chatapp/presentation/providers/repositories/auth_repository/auth_repository_provider.dart';
import 'package:flutter_chatapp/presentation/providers/repositories/user_repository/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_provider.g.dart';

@riverpod
Login login(LoginRef ref) => Login(
      authRepository: ref.watch(authRepositoryProvider),
      userRepository: ref.watch(userRepositoryProvider),
    );
