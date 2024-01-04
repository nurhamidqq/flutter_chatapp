class SendMessageParams {
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String message;
  SendMessageParams({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.message,
  });
}
