import 'package:flutter_chatapp/domain/usecases/send_message/send_message.dart';
import 'package:flutter_chatapp/presentation/providers/repositories/message_repository/message_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'send_message_provider.g.dart';

@riverpod
SendMessage sendMessage(SendMessageRef ref) =>
    SendMessage(messageRepository: ref.watch(messageRepositoryProvider));
