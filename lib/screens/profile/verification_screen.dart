import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kilifi_county/providers/user_provider.dart';

class VerificationScreen extends StatefulWidget {
  static const routeName = 'get-verified';

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  Uint8List file;
  String fileName;

  String fullName = '';

  String notability = '';

  String link1 = '';

  String link2 = '';

  String link3 = '';

  Future<void> pickFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );

    if (result != null) {
      file = result.files.first.bytes;
      fileName = result.files.first.name;
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('No file has been chosen'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = ModalRoute.of(context).settings.arguments as UserModel;

    void trySubmit() async {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        final send = await FirebaseStorage.instance
            .ref('uploads/verification/${user.userId}/$fileName')
            .putData(file);
        final url = send.ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('admin')
            .doc('verification_requests')
            .collection('users')
            .doc(user.userId)
            .set({
          'email': user.email,
          'imageUrl': user.imageUrl,
          'nationalID': user.nationalId,
          'userId': user.userId,
          'fullName': fullName,
          'username': user.username,
          'notability': notability,
          'document': url,
          'links': [link1, link2, link3]
        }, SetOptions(merge: true));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Request Verification'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          width: size.width - 80,
                          child: Text(
                            'Verified accounts have blue checkmarks next to their names to show that they have been confirmed they are the real presence of the public figures',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                        )),
                        SizedBox(height: 10),
                        title('Step 1: Confirm authenticity',
                            'Add an official document for yourself preferrably a National ID Card'),
                        Container(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                                controller: TextEditingController()
                                  ..text = 'deekay',
                                readOnly: true,
                                enabled: false,
                                decoration: InputDecoration(
                                    labelText: 'Username',
                                    labelStyle: TextStyle(fontSize: 13))),
                            TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    fullName = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: 'Full name',
                                )),
                            Container(
                                margin: EdgeInsets.symmetric(vertical: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      fileName != null
                                          ? fileName
                                          : 'National ID/Passport(image)',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    if (file != null)
                                      Center(
                                        child: Container(child: Text(fileName)),
                                      ),
                                    Center(
                                      child: TextButton(
                                          onPressed: () async => pickFile(),
                                          child: Text(
                                            'Choose File',
                                          )),
                                    )
                                  ],
                                )),
                          ],
                        )),
                        title('Step 2: Confirm notability',
                            'Describe in brief at most 20 words how you are public figure and how it represents public interest'),
                        SizedBox(height: 10),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              maxLines: null,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please give a short description';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  notability = value;
                                });
                              },
                              maxLength: 150,
                              buildCounter: (BuildContext context,
                                      {int currentLength,
                                      int maxLength,
                                      bool isFocused}) =>
                                  null,
                              maxLengthEnforcement:
                                  MaxLengthEnforcement.enforced,
                              decoration: InputDecoration(
                                  hintText: 'Short description',
                                  hintStyle: TextStyle(fontSize: 12),
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        title('Links(Optional)',
                            'Add artices, social media account and other links that show that your account is in the public interest'),
                        Container(
                            child: TextFormField(
                          decoration: InputDecoration(hintText: 'Link 1'),
                          onChanged: (value) {
                            setState(() {
                              link1 = value;
                            });
                          },
                        )),
                        Container(
                            child: TextFormField(
                          decoration: InputDecoration(hintText: 'Link 2'),
                          onChanged: (value) {
                            setState(() {
                              link2 = value;
                            });
                          },
                        )),
                        Container(
                            child: TextFormField(
                          decoration: InputDecoration(hintText: 'Link 3'),
                          onChanged: (value) {
                            setState(() {
                              link3 = value;
                            });
                          },
                        )),
                        SizedBox(height: 30)
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                  width: size.width - 100,
                  child: ElevatedButton(
                      onPressed: trySubmit,
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      )))
            ],
          ),
        ),
      ),
    );
  }

  Widget title(String title, String description) {
    return Container(
        margin: EdgeInsets.only(right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(fontSize: 13, color: Colors.grey),
            )
          ],
        ));
  }
}
