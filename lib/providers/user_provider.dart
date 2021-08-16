import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserModel {
  final String fullName;
  final String username;
  final String imageUrl;
  final String email;
  final String userId;
  final String phoneNumber;
  final String subCounty;
  final String nationalId;
  final bool isAdmin;
  final String office;
  final Timestamp joinedAt;
  final bool isVerified;

  UserModel(
      {this.email,
      this.fullName,
      this.imageUrl,
      this.isAdmin,
      this.joinedAt,
      this.office,
      this.userId,
      this.username,
      this.isVerified,
      this.nationalId,
      this.phoneNumber,
      this.subCounty});
}

class UsersProvider with ChangeNotifier {
  UserModel user;

  void getUser(UserModel userModel) {
    user = userModel;
    // notifyListeners();
  }
}

// UserModel(
//           email: data['email'],
//           fullName: data['fullName'],
//           imageUrl: data['imageUrl'],
//           nationalId: data['nationalId'],
//           phoneNumber: data['phoneNumber'],
//           subCounty: data['subCounty'],
//           userId: data['userId'],
//           username: data['username']);
