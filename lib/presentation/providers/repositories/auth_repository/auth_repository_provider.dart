import 'package:flutter_chatapp/data/firebase/firebase_authentication.dart';
import 'package:flutter_chatapp/data/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository_provider.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) =>
    FirebaseAuthentication();
