import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chatapp/data/repositories/message_repository.dart';
import 'package:flutter_chatapp/domain/usecases/get_message/get_message_params.dart';
import 'package:flutter_chatapp/domain/usecases/usecase_stream.dart';

class GetMessage implements UseCaseStream<QuerySnapshot, GetMessageParams> {
  final MessageRepository _messageRepository;
  GetMessage({
    required MessageRepository messageRepository,
  }) : _messageRepository = messageRepository;

  @override
  Stream<QuerySnapshot> call(GetMessageParams params) async* {
    yield* _messageRepository.get(
        senderId: params.senderId, receiverId: params.receiverId);
  }
}
