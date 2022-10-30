

class Message {
  final String sender;
  final String messageText;
  Message({required this.sender,required this.messageText});

  mapMessages(){
    return {'sender':sender,'messageText':messageText};
  }


}