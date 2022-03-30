class MessageModel {
  String? sender;
  String? receiver;
  bool? isSeen;
  String? message;
  String? time;
  String? type;



  MessageModel({
    required this.sender,
    required this.receiver,
    required this.isSeen,
    required this.message,
    required this.time,
    required this.type,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    sender = json['sender'];
    receiver = json['receiver'];
    isSeen = json['isSeen'];
    message = json['message'];
    time = json['time'];
    type = json['type'];
  }

  Map<String, dynamic> toMap() {
    return {
      'sender': sender,
      'receiver': receiver,
      'isSeen': isSeen,
      'message': message,
      'time': time,
      'type': type
    };
  }
}
