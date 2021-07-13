import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String message;
  final String userId;
  final Timestamp time;
  final String status;

  Message({this.message, this.userId, this.time, this.status});
}
