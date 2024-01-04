import 'package:flutter_chatapp/domain/usecases/get_list_user/get_list_user.dart';
import 'package:flutter_chatapp/presentation/providers/repositories/auth_repository/auth_repository_provider.dart';
import 'package:flutter_chatapp/presentation/providers/repositories/user_repository/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_list_user_provider.g.dart';

@riverpod
GetListUser getListUser(GetListUserRef ref) => GetListUser(
      userRepository: ref.watch(userRepositoryProvider),
      authRepository: ref.watch(authRepositoryProvider),
    );
