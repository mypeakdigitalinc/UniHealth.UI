import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/sharedpref/constants/preferences.dart';
import '../../utils/routes/routes.dart';

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({Key? key}) : super(key: key);

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  @override
  Widget build(BuildContext context) {
    SharedPreferences.getInstance().then((preference) {
      preference.setBool(Preferences.is_logged_in, false);
      Navigator.of(context).pushReplacementNamed(Routes.login);
    });
    return Container();
  }
}
