import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatapp/domain/entities/result.dart';
import 'package:flutter_chatapp/domain/usecases/get_message/get_message.dart';
import 'package:flutter_chatapp/domain/usecases/get_message/get_message_params.dart';
import 'package:flutter_chatapp/domain/usecases/send_message/send_message.dart';
import 'package:flutter_chatapp/domain/usecases/send_message/send_message_params.dart';
import 'package:flutter_chatapp/presentation/providers/usecases/get_message_provider.dart';
import 'package:flutter_chatapp/presentation/providers/usecases/send_message_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'message_data_provider.g.dart';

@Riverpod(keepAlive: true)
class MessageData extends _$MessageData {
  @override
  Stream<QuerySnapshot?> build(
      {required String senderId, required String receiverId}) async* {
    GetMessage getMessage = ref.read(getMessageProvider);
    final result = getMessage(
        GetMessageParams(senderId: senderId, receiverId: receiverId));
    yield* result;
  }

  Future<void> sendMessage(
      {required String senderEmail, required String message}) async {
    state = const AsyncLoading();
    SendMessage sendMessage = ref.read(sendMessageProvider);
    var result = await sendMessage(SendMessageParams(
        senderId: senderId,
        senderEmail: senderEmail,
        receiverId: receiverId,
        message: message));
    switch (result) {
      case Success(value: _):
        state = const AsyncData(null);
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = AsyncData(state.valueOrNull);
    }
  }
}
