import 'package:flutter/material.dart';
import 'package:unihealth/utils/routes/routes.dart';
import '../../data/repository.dart';

class NavStore extends ChangeNotifier {
  final Repository _repository;
  NavStore(Repository repository) : _repository = repository {
    loadSettings();
  }
  // repository instance

  String _currentRoute = Routes.home;

  String get currentRoute => _currentRoute;

  void setNavigationItem(BuildContext context, String route) {
    _currentRoute = route;
    notifyListeners();
    Navigator.restorablePushNamed(
      context,
      route,
    );
  }

  /// Load the user's settings from the SettingsService. It may load from a
  /// local database or the internet. The controller only knows it can load the
  /// settings from the service.
  Future<void> loadSettings() async {
    // Important! Inform listeners a change has occurred.
    notifyListeners();
  }
}
