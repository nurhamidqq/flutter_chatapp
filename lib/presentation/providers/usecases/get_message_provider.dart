import 'package:flutter_chatapp/domain/usecases/get_message/get_message.dart';
import 'package:flutter_chatapp/presentation/providers/repositories/message_repository/message_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_message_provider.g.dart';

@riverpod
GetMessage getMessage(GetMessageRef ref) =>
    GetMessage(messageRepository: ref.watch(messageRepositoryProvider));
