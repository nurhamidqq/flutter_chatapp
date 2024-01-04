import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_chatapp/presentation/misc/constants.dart';
import 'package:flutter_chatapp/presentation/pages/chat_page/components/bubble_shape.dart';

class ReceivedMessageBubble extends StatelessWidget {
  final String message;

  const ReceivedMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final messageTextGroup = Flexible(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(math.pi),
          child: CustomPaint(
            painter: BubbleShape(softGrey),
          ),
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: const BoxDecoration(
              color: softGrey,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(18),
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
            ),
            child: Text(
              message,
              style: const TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
        ),
      ],
    ));

    return Row(
      children: <Widget>[
        messageTextGroup,
      ],
    );
  }
}
