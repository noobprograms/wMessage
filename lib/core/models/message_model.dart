import 'package:cloud_firestore/cloud_firestore.dart';

enum Type { text, image, location, any }

class Message {
  Message(
    this.senderId,
    this.receiverId,
    this.timestamp,
    this.message,
    this.type,
    this.assetLink,
  );
  final String senderId;
  final String receiverId;
  final Timestamp timestamp;
  String message;
  String assetLink;
  final Type type;

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'timestamp': timestamp,
      'message': message,
      'type': type.name,
      'asset': assetLink,
    };
  }
}
