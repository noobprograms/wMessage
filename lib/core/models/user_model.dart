import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  String name;
  String email;
  String profileImageUrl;
  String phoneNumber;
  String tokenValue;

  User(
      {required this.uid,
      required this.name,
      required this.email,
      required this.phoneNumber,
      this.profileImageUrl = '',
      required this.tokenValue});
  void updateUser(
    String uid,
    name,
    email,
    profileImageUrl,
  ) {
    this.name = name;
    this.uid = uid;
    this.email = email;
    this.profileImageUrl = profileImageUrl;
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'phoneNumber': phoneNumber,
      'tokenValue': tokenValue
    };
  }
}
