import 'package:flutter_chatapp/data/repositories/message_repository.dart';
import 'package:flutter_chatapp/domain/entities/result.dart';
import 'package:flutter_chatapp/domain/usecases/send_message/send_message_params.dart';
import 'package:flutter_chatapp/domain/usecases/usecase.dart';

class SendMessage implements UseCase<Result<void>, SendMessageParams> {
  final MessageRepository _messageRepository;
  SendMessage({required MessageRepository messageRepository})
      : _messageRepository = messageRepository;
  @override
  Future<Result<void>> call(SendMessageParams params) {
    return _messageRepository.send(
      senderId: params.senderId,
      senderEmail: params.senderEmail,
      receiverId: params.receiverId,
      message: params.message,
    );
  }
}
