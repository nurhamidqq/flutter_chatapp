import 'package:flutter/material.dart';
import 'package:flutter_chatapp/presentation/misc/constants.dart';
import 'package:flutter_chatapp/presentation/pages/chat_page/components/bubble_shape.dart';

class SentMessageBubble extends StatelessWidget {
  final String message;

  const SentMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final messageTextGroup = Flexible(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: const BoxDecoration(
              color: Color(0xFF006064),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
            ),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ),
        CustomPaint(painter: BubbleShape(cyan)),
      ],
    ));

    return Row(
      children: <Widget>[
        messageTextGroup,
      ],
    );
  }
}
