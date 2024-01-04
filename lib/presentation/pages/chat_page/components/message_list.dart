import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatapp/domain/entities/message.dart';
import 'package:flutter_chatapp/presentation/misc/methods.dart';
import 'package:flutter_chatapp/presentation/pages/chat_page/components/received_message_bubble.dart';
import 'package:flutter_chatapp/presentation/pages/chat_page/components/sent_message_bubble.dart';
import 'package:intl/intl.dart';

Widget messageList(Message data, String uid) {
  //Message data = Message.fromJSON(doc.data() as Map<String, dynamic>);

  // Alignment align =
  //     (data['senderId'] == uid) ? Alignment.centerRight : Alignment.centerLeft;
  // MainAxisAlignment mainAlign = (data['senderId'] == uid)
  //     ? MainAxisAlignment.end
  //     : MainAxisAlignment.start;
  CrossAxisAlignment crossAlign = (data.senderId == uid)
      ? CrossAxisAlignment.end
      : CrossAxisAlignment.start;

  Widget bubble = (data.senderId == uid)
      ? SentMessageBubble(message: data.message)
      : ReceivedMessageBubble(message: data.message);

  final Timestamp timestamp = data.timestamp;
  final DateTime dateTime = timestamp.toDate();
  final dateString = DateFormat('KK:mm').format(dateTime);

  return Column(
    crossAxisAlignment: crossAlign,
    children: [
      Text(
        dateString,
        style: const TextStyle(fontSize: 10),
      ),
      verticalSpace(2),
      bubble,
    ],
  );
}
