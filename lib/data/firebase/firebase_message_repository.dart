import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chatapp/data/repositories/message_repository.dart';
import 'package:flutter_chatapp/domain/entities/message.dart';
import 'package:flutter_chatapp/domain/entities/result.dart';

class FirebaseMessageRepository implements MessageRepository {
  final FirebaseFirestore _firebaseFireStore;
  FirebaseMessageRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFireStore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<Result<void>> send(
      {required String senderId,
      required String senderEmail,
      required String receiverId,
      required String message}) async {
    Message newMessage = Message(
        senderId: senderId,
        senderEmail: senderEmail,
        receiverId: receiverId,
        message: message,
        timestamp: Timestamp.now());

    List<String> ids = [senderId, receiverId];
    ids.sort();
    String messageId = ids.join("_");

    var result = await _firebaseFireStore
        .collection('rooms')
        .doc(messageId)
        .collection('messages')
        .add(newMessage.toMap());
    if (result.id.isNotEmpty) {
      return const Result.success(null);
    } else {
      return const Result.failed('Error send message');
    }
  }

  @override
  Stream<QuerySnapshot> get(
      {required String senderId, required String receiverId}) async* {
    List<String> ids = [senderId, receiverId];
    ids.sort();
    String messageId = ids.join("_");
    var d = await _firebaseFireStore.collection('rooms').get();
    var res = d.docs.map((e) => e.data()).toList();
    print(res);

    yield* _firebaseFireStore
        .collection('rooms')
        .doc(messageId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
