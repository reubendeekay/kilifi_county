import 'package:flutter/material.dart';
import 'package:kilifi_county/constants.dart';
import 'package:kilifi_county/providers/dark_mode_provider.dart';
import 'package:kilifi_county/screens/profile/widgets/account_details_screen.dart';
import 'package:provider/provider.dart';

class ProfileTile extends StatelessWidget {
  final String title;
  final String description;
  final Function function;
  ProfileTile({this.title, this.description, this.function});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 0, 15, 10),
      width: double.infinity,
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: ListTile(
            leading: Icon(Icons.person),
            title: Text(
              title == null ? 'Profile' : title,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              description == null
                  ? 'Edit details,link accounts...'
                  : description,
              style: TextStyle(fontSize: 12),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 13,
              color: Colors.grey,
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onTap: function != null ? function : null,
            dense: true,
          )),
    );
  }
}

class ProfileSwitchTile extends StatefulWidget {
  @override
  _ProfileSwitchTileState createState() => _ProfileSwitchTileState();
}

class _ProfileSwitchTileState extends State<ProfileSwitchTile> {
  @override
  Widget build(BuildContext context) {
    final dark = Provider.of<DarkThemeProvider>(context);
    return Container(
        margin: EdgeInsets.fromLTRB(15, 0, 15, 10),
        width: double.infinity,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: ListTile(
            leading: Icon(Icons.light_mode_sharp),
            title: Text(
              'Dark mode',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: dark.darkTheme
                ? Text(
                    'Toggle to light mode',
                    style: TextStyle(fontSize: 12),
                  )
                : Text(
                    'Toggle to dark mode',
                    style: TextStyle(fontSize: 12),
                  ),
            trailing: Switch(
                activeColor: kPrimary,
                value: dark.darkTheme,
                onChanged: (value) => dark.darkTheme = value),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            dense: true,
          ),
        ));
  }
}
