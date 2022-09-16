import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:unihealth/utils/routes/routes.dart';
import '../../data/repository.dart';

part 'nav_store.g.dart';

class NavStore = _NavStore with _$NavStore;

abstract class _NavStore with Store {
  final Repository _repository;
  _NavStore(Repository repository) : _repository = repository {
    loadSettings();
  }
  // repository instance
  @observable
  String _currentRoute = Routes.home;

  String get currentRoute => _currentRoute;

  @action
  void setNavigationItem(BuildContext context, String route) {
    _currentRoute = route;
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
  }
}
