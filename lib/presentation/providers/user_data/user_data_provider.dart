import 'package:flutter/material.dart';
import 'package:flutter_chatapp/domain/entities/result.dart';
import 'package:flutter_chatapp/domain/entities/user.dart';
import 'package:flutter_chatapp/domain/usecases/get_list_user/get_list_user.dart';
import 'package:flutter_chatapp/domain/usecases/get_logged_in_user/get_logged_in_user.dart';
import 'package:flutter_chatapp/domain/usecases/login/login.dart';
import 'package:flutter_chatapp/domain/usecases/register/register.dart';
import 'package:flutter_chatapp/domain/usecases/register/register_params.dart';
import 'package:flutter_chatapp/presentation/providers/usecases/get_list_user_provider.dart';
import 'package:flutter_chatapp/presentation/providers/usecases/get_logged_in_user_provider.dart';
import 'package:flutter_chatapp/presentation/providers/usecases/login_provider.dart';
import 'package:flutter_chatapp/presentation/providers/usecases/logout_provider.dart';
import 'package:flutter_chatapp/presentation/providers/usecases/register_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_data_provider.g.dart';

@Riverpod(keepAlive: true)
class UserData extends _$UserData {
  @override
  Future<User?> build() async {
    GetLoggedInUser getLoggedInUser = ref.read(getLoggedInUserProvider);
    var userResult = await getLoggedInUser(null);
    switch (userResult) {
      case Success(value: final user):
        //_get chat
        return user;
      case Failed(message: _):
        return null;
    }
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();
    Login login = ref.read(loginProvider);
    var result = await login(LoginParams(email: email, password: password));
    switch (result) {
      case Success(value: final user):
        //_get chat
        state = AsyncData(user);
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = const AsyncData(null);
    }
  }

  Future<void> register(
      {required String email,
      required String password,
      required String name,
      String? imageUrl}) async {
    state = const AsyncLoading();
    Register register = ref.read(registerProvider);

    var result = await register(
        RegisterParams(name: name, email: email, password: password));
    switch (result) {
      case Success(value: final user):
        //_get chat
        state = AsyncData(user);
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = const AsyncData(null);
    }
  }

  Future<void> logout() async {
    var logout = ref.read(logoutProvider);
    var result = await logout(null);
    switch (result) {
      case Success(value: _):
        state = const AsyncData(null);
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = AsyncData(state.valueOrNull);
    }
  }

  Stream<List<User>?> getListUser() async* {
    GetListUser getListUser = ref.read(getListUserProvider);
    var result = getListUser(null);
    yield* result;
  }

  Future<String?> getLoggedInUser() async {
    GetLoggedInUser getLoggedInUser = ref.read(getLoggedInUserProvider);
    var userResult = await getLoggedInUser(null);
    switch (userResult) {
      case Success(value: final user):
        return user.name;
      case Failed(message: _):
        return null;
    }
  }
}
