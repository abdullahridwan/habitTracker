import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tracker/constants.dart';

import '../components/cupertino_section.dart';
import '../components/settings_row.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _isDarkMode = false;
  bool _isSignedOut = false;

  _handleDarkMode(bool darkModeValue) {
    setState(() {
      _isDarkMode = darkModeValue;
    });
  }

  Future<void> _handleSignOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(this.context, "/auth");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Text(
                "Settings",
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headline3!.fontSize,
                ),
              ),
              SizedBox(height: 10),
              CupertinoSection(
                title: "Basics",
                variables: [
                  {
                    "state variable": _isDarkMode,
                    "widget": SettingsRow(
                      color: Colors.blue.shade900,
                      icon: CupertinoIcons.moon_fill,
                      title: "Dark Mode",
                      description: "Turn Dark Mode on and off",
                      endWidget: CupertinoSwitch(
                        value: _isDarkMode,
                        onChanged: _handleDarkMode,
                      ),
                    ),
                  },
                  {
                    "state variable": null,
                    "widget": SettingsRow(
                        color: Colors.red.shade400,
                        icon: CupertinoIcons.exclamationmark_circle_fill,
                        title: "Version",
                        description: "Current App Version",
                        endWidget: Text("0.0.1")),
                  },
                ],
              ),
              CupertinoSection(
                title: "",
                variables: [
                  {
                    "state variable": null,
                    "widget": Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: _handleSignOut,
                        child: Text(
                          "Sign Out",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  },
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
