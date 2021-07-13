import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kilifi_county/constants.dart';
import 'package:kilifi_county/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CompleteProfileScreen extends StatefulWidget {
  static const routeName = '/complete-profile';

  @override
  _CompleteProfileScreenState createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String fullName = '';
  String phoneNumber = '';
  String nationalId = '';
  String subCounty = '';

  File _image;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final email = user['email'];
    final password = user['password'];
    final username = user['username'];

    void _trySubmit() async {
      UserCredential user;
      if (_formKey.currentState.validate()) {
        if (_image == null) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Please put a profile picture')));
        } else {
          _formKey.currentState.save();

          user = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password);
          final putImage = await FirebaseStorage.instance
              .ref('users_profile_images/${user.user.uid}')
              .putFile(_image);
          final url = await putImage.ref.getDownloadURL();

          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.user.uid)
              .set({
            'userId': user.user.uid,
            'email': email,
            'username': username,
            'imageUrl': url,
            'fullName': fullName,
            'nationalId': nationalId,
            'phoneNumber': phoneNumber,
            'subCounty': subCounty,
            'joinedIn': Timestamp.now(),
            'isVerified': false,
          }, SetOptions(merge: true));
        }
      }
    }

    void _getImage() async {
      final pickedFile = await ImagePicker().getImage(
          source: ImageSource.gallery,
          imageQuality: 40,
          maxHeight: 400,
          maxWidth: 400);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('No image selected')));
        }
      });
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.05,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(
                  'Complete your profile',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
              ),
              Center(
                child: Container(
                  height: 110,
                  width: 110,
                  child: Card(
                    elevation: 15,
                    shadowColor: kPrimary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    child: GestureDetector(
                      onTap: _getImage,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey,
                        backgroundImage:
                            _image != null ? FileImage(_image) : null,
                        child: _image == null
                            ? Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 50,
                              )
                            : null,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        elevation: 5,
                        shadowColor: kPrimary,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: 'Full Legal Name',
                                border: InputBorder.none),
                            onChanged: (value) {
                              fullName = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your legal name';
                              }
                              if (value.length < 5) {
                                return 'Enter a valid legal name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        shadowColor: kPrimary,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: 'Phone number',
                                border: InputBorder.none),
                            onChanged: (value) {
                              phoneNumber = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a phone number';
                              }
                              if (value.length < 9) {
                                return 'Enter a valid phone number';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        elevation: 5,
                        shadowColor: kPrimary,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: 'National ID',
                                border: InputBorder.none),
                            onChanged: (value) {
                              nationalId = value;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        shadowColor: kPrimary,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: 'Sub County',
                                border: InputBorder.none),
                            onChanged: (value) {
                              subCounty = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your subcounty';
                              }
                              if (value.length < 5) {
                                return 'Enter a valid sub county';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.15,
              ),
              SizedBox(
                width: size.width - 50,
                child: ElevatedButton(
                    onPressed: _trySubmit,
                    child: Text(
                      'Proceed',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              SizedBox(
                height: size.height * 0.03,
              )
            ],
          ),
        ),
      ),
    );
  }
}
