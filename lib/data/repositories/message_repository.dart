import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chatapp/domain/entities/result.dart';

abstract interface class MessageRepository {
  Future<Result<void>> send(
      {required String senderId,
      required String senderEmail,
      required String receiverId,
      required String message});
  Stream<QuerySnapshot> get(
      {required String senderId, required String receiverId});
}
