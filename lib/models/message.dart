

class Message {
  final String sender;
  final String messageText;
  final DateTime dateMessage;
  final bool isMe;
  Message({required this.dateMessage,required this.isMe,required this.sender,required this.messageText});

  mapMessages(){
    return {'sender':sender,'messageText':messageText,'dateMessage':dateMessage};
  }


}