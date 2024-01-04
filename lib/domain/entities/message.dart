import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String message;
  final Timestamp timestamp;
  Message({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.message,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
    };
  }

  factory Message.fromJSON(Map<String, dynamic> json) => Message(
      senderId: json['senderId'],
      senderEmail: json['senderEmail'],
      receiverId: json['receiverId'],
      message: json['message'],
      timestamp: json['timestamp']);

  static List<Message> fromList(List data) {
    List<Message> res = [];
    for (var element in data) {
      res.add(Message.fromJSON(element));
    }
    return res;
  }

//   Map<String, List<Message>> grouped =
//     groupBy<Message, String>(messages, (message) {
//   final Timestamp timestamp = message.timestamp;
//   DateTime time = timestamp.toDate();
//   return "${time.day}.${time.month}.${time.year}";
// });
}
