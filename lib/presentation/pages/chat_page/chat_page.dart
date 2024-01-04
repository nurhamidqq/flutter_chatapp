import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatapp/domain/entities/message.dart';
import 'package:flutter_chatapp/domain/entities/user.dart';
import 'package:flutter_chatapp/presentation/misc/constants.dart';
import 'package:flutter_chatapp/presentation/misc/methods.dart';
import 'package:flutter_chatapp/presentation/pages/chat_page/components/message_list.dart';
import 'package:flutter_chatapp/presentation/pages/chat_page/components/typing_indicator.dart';
import 'package:flutter_chatapp/presentation/providers/message_data/message_data_provider.dart';
import 'package:flutter_chatapp/presentation/widgets/my_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage(this.chatDetail, {super.key});
  final (User, User) chatDetail;
  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  late ScrollController _scrollController;
  bool isTyping = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    void scrollToBottom() {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    }

    final (senderUser, receiverUser) = widget.chatDetail;
    var messageCtr = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          receiverUser.name,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/chatbg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: StreamBuilder<QuerySnapshot?>(
          stream: ref
              .read(messageDataProvider
                  .call(senderId: senderUser.uid, receiverId: receiverUser.uid)
                  .notifier)
              .build(senderId: senderUser.uid, receiverId: receiverUser.uid),
          builder: (context, snapshot) {
            if (snapshot.error == null) {
              WidgetsBinding.instance
                  .addPostFrameCallback((_) => scrollToBottom());
            }
            if (snapshot.hasData) {
              var datas = Message.fromList(
                  snapshot.data!.docs.map((e) => e.data()).toList());
              var grouped = groupBy<Message, String>(datas, (message) {
                DateTime time = message.timestamp.toDate();
                return "${time.day}-${time.month}-${time.year}";
              });
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: grouped.keys.length,
                      padding: const EdgeInsets.all(16.0),

                      itemBuilder: (context, index) {
                        String date = grouped.keys.toList()[index];
                        List<Message>? messages = grouped[date];
                        return Column(
                          children: [
                            Text(
                              date,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            verticalSpace(5),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: messages?.length,
                              itemBuilder: (context, index) {
                                return messageList(
                                    messages![index], senderUser.uid);
                              },
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: TypingIndicator(
                                showIndicator: isTyping,
                              ),
                            ),
                          ],
                        );
                      },
                      // children: snapshot.data!.docs
                      //     .map((doc) => messageList(doc, senderUser.uid))
                      //     .toList(),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MyTextField(
                          controller: messageCtr,
                          hintText: 'Enter message',
                          obsecureText: false,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await ref
                              .read(messageDataProvider
                                  .call(
                                      senderId: senderUser.uid,
                                      receiverId: receiverUser.uid)
                                  .notifier)
                              .sendMessage(
                                  senderEmail: senderUser.email,
                                  message: messageCtr.text);
                          messageCtr.clear();
                        },
                        icon: const Icon(
                          Icons.send,
                        ),
                      )
                    ],
                  )
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(
                color: primary,
              ),
            );
          },
        ),
      ),
    );
  }
}
