// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nav_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NavStore on _NavStore, Store {
  final _$_currentRouteAtom = Atom(name: '_NavStore._currentRoute');

  @override
  String get _currentRoute {
    _$_currentRouteAtom.reportRead();
    return super._currentRoute;
  }

  @override
  set _currentRoute(String value) {
    _$_currentRouteAtom.reportWrite(value, super._currentRoute, () {
      super._currentRoute = value;
    });
  }

  final _$_NavStoreActionController = ActionController(name: '_NavStore');

  @override
  void setNavigationItem(BuildContext context, String route) {
    final _$actionInfo = _$_NavStoreActionController.startAction(
        name: '_NavStore.setNavigationItem');
    try {
      return super.setNavigationItem(context, route);
    } finally {
      _$_NavStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
