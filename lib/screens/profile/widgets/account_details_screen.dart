import 'package:flutter/material.dart';
import 'package:kilifi_county/providers/user_provider.dart';

class AccountDetailsScreen extends StatefulWidget {
  static const routeName = '/account-details';

  @override
  _AccountDetailsScreenState createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  var isEdit = false;

  String username = '';
  String fullName = '';
  String location = '';
  String phoneNumber = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = ModalRoute.of(context).settings.arguments as UserModel;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Details'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isEdit = !isEdit;
                });
              },
              icon: Icon(Icons.edit))
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              profileTile('@${user.username}', 'Username', username),
              profileTile('${user.fullName}', 'Full name', fullName),
              profileTile('${user.email}', 'Email address', email),
              profileTile('${user.phoneNumber}', 'Phone number', phoneNumber),
              profileTile('${user.subCounty}', 'Sub County', location),
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Password'),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        thickness: 1,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Verification request'),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        thickness: 1,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              Center(
                child: SizedBox(
                  width: size.width - 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Complete',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget profileTile(String placeHolder, String title, String variable) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
        SizedBox(
          height: 55,
          child: !isEdit
              ? Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      child: Text(
                        placeHolder,
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Divider(
                        thickness: 1,
                      ),
                    )
                  ],
                )
              : Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        onChanged: (value) {
                          variable = value;
                        },
                        decoration: InputDecoration(
                            hintText: placeHolder,
                            hintStyle: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w300),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
