import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../data/repository.dart';
import '../../models/nav_item.dart';

class NavStore extends ChangeNotifier with Store {
  final Repository _repository;
  NavStore(Repository repository) : _repository = repository {
    loadSettings();
  }
  // repository instance

  NavItem _navigationItem = NavItem.profile;

  NavItem get navigationItem => _navigationItem;

  void setNavigationItem(BuildContext context, NavItem navigationItem) {
    _navigationItem = navigationItem;
    notifyListeners();
    Navigator.restorablePushNamed(
      context,
      navigationItem.name,
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
