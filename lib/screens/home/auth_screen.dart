import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kilifi_county/constants.dart';

import 'package:kilifi_county/screens/home/complete_profile_screen.dart';
import 'package:kilifi_county/screens/home/password_reset_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String username = '';
  String password = '';
  var isLogin = true;
  bool isObsecure = true;

  @override
  Widget build(BuildContext context) {
    void _trySubmit() async {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();

        if (isLogin) {
          try {
            await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: email, password: password);
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(toBeginningOfSentenceCase(e.code),
                  style: TextStyle(color: Colors.white)),
              backgroundColor: kPrimary,
            ));
          }
        } else {
          Navigator.of(context).pushReplacementNamed(
              CompleteProfileScreen.routeName,
              arguments: {
                'email': email,
                'username': username,
                'password': password
              });
        }
      }
    }

    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.1,
            ),
            Align(
              alignment: Alignment(0, 1),
              child: Container(
                width: 70,
                height: 80,
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.fastLinearToSlowEaseIn,
              margin: EdgeInsets.only(top: 20),
              child: Text(
                isLogin ? 'Welcome back!' : 'Welcome',
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.fastLinearToSlowEaseIn,
              margin: EdgeInsets.only(top: 5),
              child: Text(
                isLogin ? 'Login to your account' : 'Create your account',
                style: TextStyle(fontSize: 13),
              ),
            ),

            //AUTH SCREEN FORM
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              curve: Curves.fastLinearToSlowEaseIn,
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    if (!isLogin)
                      Card(
                          shadowColor: kPrimary,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'username',
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: kPrimary,
                                  )),
                              onChanged: (value) {
                                username = value;
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your username';
                                }
                                return null;
                              },
                            ),
                          )),
                    SizedBox(
                      height: 5,
                    ),
                    Card(
                        shadowColor: kPrimary,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'email address',
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: kPrimary,
                                )),
                            onChanged: (value) {
                              email = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your email address';
                              }
                              if (!value.contains('@')) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    Card(
                        shadowColor: kPrimary,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'password',
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isObsecure = !isObsecure;
                                      });
                                    },
                                    child: isObsecure
                                        ? Icon(
                                            Icons.remove_red_eye,
                                            size: 22,
                                            color: Colors.grey,
                                          )
                                        : Icon(
                                            FontAwesomeIcons.eyeSlash,
                                            color: Colors.grey,
                                            size: 20,
                                          )),
                                prefixIcon: Icon(
                                  Icons.lock_rounded,
                                  color: kPrimary,
                                )),
                            obscureText: isObsecure,
                            onChanged: (value) {
                              password = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 6) {
                                return 'Password should be atleast 6 characters';
                              }
                              return null;
                            },
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context)
                              .pushNamed(PasswordResetScreen.routeName),
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),

            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: _trySubmit,
                child: Text(
                  isLogin ? 'Login' : 'Sign up',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    height: 0.5,
                    color: Colors.grey,
                  )),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                          isLogin ? 'Or sign in up with' : 'Or sign up with')),
                  Expanded(
                      child: Container(
                    height: 0.5,
                    color: Colors.grey,
                  )),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                socialIcon(
                  'assets/images/google.png',
                ),
                Container(
                    height: 50,
                    width: 80,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13)),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        child: Image.asset(
                          'assets/images/fb.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    )),
                socialIcon(
                  'assets/images/twitter.png',
                ),
              ],
            ),
            SizedBox(height: size.height * 0.08),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isLogin
                      ? 'Dont have an account? '
                      : 'Already have an account? ',
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                  child: Text(isLogin ? 'Register here' : 'Login here',
                      style: TextStyle(
                          color: kPrimary, fontWeight: FontWeight.w600)),
                )
              ],
            ),
          ],
        ),
      ),
    ));
  }
}

Widget socialIcon(String location) {
  return Container(
      height: 50,
      width: 80,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Image.asset(
            location,
            fit: BoxFit.fill,
          ),
        ),
      ));
}
