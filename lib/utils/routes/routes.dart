import 'package:flutter/material.dart';
import 'package:unihealth/ui/aboutus/aboutus.dart';
import 'package:unihealth/ui/constactus/contactus.dart';
import 'package:unihealth/ui/cwf/eworkflow.dart';
import 'package:unihealth/ui/emr/erecords.dart';
import 'package:unihealth/ui/logout/logout.dart';
import 'package:unihealth/ui/opr/eregistration.dart';
import 'package:unihealth/ui/profile/profile.dart';
import 'package:unihealth/ui/settings/settings.dart';

import '../../ui/home/home.dart';
import '../../ui/login/login.dart';
import '../../ui/splash/splash.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String logout = '/logout';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String aboutus = '/aboutus';
  static const String settings = '/settings';
  static const String constactus = '/constactus';

  static const String erecords = '/erecords';
  static const String eregistration = '/eregistration';
  static const String eworkflow = '/eworkflow';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => const SplashScreen(),
    login: (BuildContext context) => LoginScreen(),
    logout: (BuildContext context) => const LogoutScreen(),
    home: (BuildContext context) => const HomeScreen(),
    profile: (BuildContext context) => const ProfileScreen(),
    aboutus: (BuildContext context) => const AboutUsScreen(),
    settings: (BuildContext context) => const SettingsScreen(),
    constactus: (BuildContext context) => const ContactUsScreen(),
    erecords: (BuildContext context) => const ERecordsScreen(),
    eregistration: (BuildContext context) => const ERegistration(),
    eworkflow: (BuildContext context) => const EWorkflowScreen(),
  };
}
