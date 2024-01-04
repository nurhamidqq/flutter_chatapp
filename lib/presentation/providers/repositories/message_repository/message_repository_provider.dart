import 'package:flutter_chatapp/data/firebase/firebase_message_repository.dart';
import 'package:flutter_chatapp/data/repositories/message_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'message_repository_provider.g.dart';

@riverpod
MessageRepository messageRepository(MessageRepositoryRef ref) =>
    FirebaseMessageRepository();
