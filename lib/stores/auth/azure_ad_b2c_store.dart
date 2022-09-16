import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unihealth/data/sharedpref/shared_preference_helper.dart';
import 'package:unihealth/utils/routes/routes.dart';
import '../../data/repository.dart';

part 'azure_ad_b2c_store.g.dart';

class AzureAdB2cStore = _AzureAdB2cStore with _$AzureAdB2cStore;

abstract class _AzureAdB2cStore with Store {
  final Repository _repository;
  _AzureAdB2cStore(Repository repository) : _repository = repository {}
  // repository instance

  FlutterAppAuth appAuth = const FlutterAppAuth();
  final String _baseUrl =
      'https://unihealthad.b2clogin.com/unihealthad.onmicrosoft.com';
  final String _policyName = 'B2C_1_UniHealthTestSignUpSignIn';
  final String _clientId = '2a9b537e-65a9-4e87-af66-8bf33b273d85';

  final String _redirectUrl = 'ca.mypeak.unihealth://oauth/redirect';
  final String _discoveryURL =
      'https://unihealthad.b2clogin.com/unihealthad.onmicrosoft.com/B2C_1_UniHealthTestSignUpSignIn/v2.0/.well-known/openid-configuration?p=B2C_1_UniHealthTestSignUpSignIn';
  final String _authorizeUrl =
      'https://unihealthad.b2clogin.com/unihealthad.onmicrosoft.com/B2C_1_UniHealthTestSignUpSignIn/oauth2/v2.0/authorize?p=b2c_1_unihealthtestsignupsignin';
  final String _tokenUrl =
      'https://unihealthad.b2clogin.com/unihealthad.onmicrosoft.com/B2C_1_UniHealthTestSignUpSignIn/oauth2/v2.0/token?p=b2c_1_unihealthtestsignupsignin';
  String _idToken = '';
  // String _refreshToken;
  // String _accessToken;
  // String _accessTokenExpiration;
  // String _firstName = "";
  // String _lastName = "";
  // String _displayName = "";
  // String _email = "";
  //Map<String, dynamic> _jwt;
  final List<String> _scopes = [
    'openid',
    'https://unihealthad.onmicrosoft.com/gwy-api/gwy.read'
  ];

  @action
  Future<void> signIn() async {
    try {
      final AuthorizationTokenResponse? result =
          await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          _clientId,
          _redirectUrl,
          serviceConfiguration: AuthorizationServiceConfiguration(
              authorizationEndpoint: _authorizeUrl, tokenEndpoint: _tokenUrl),
          scopes: _scopes,
        ),
      );
      if (result != null) {
        _processAuthTokenResponse(result);
      }
    } catch (e) {
      print(e);
    }
  }

  void _processAuthTokenResponse(AuthorizationTokenResponse response) {
    _repository.setAuthToken(response.accessToken!);
    // setState(() {
    //   _accessToken = response.accessToken;
    //   _refreshToken = response.refreshToken;
    //   _accessTokenExpiration =
    //       response.accessTokenExpirationDateTime?.toIso8601String();
    //   _idToken = response.idToken;
    //   //get individual claims from jwt token
    //   _jwt = parseJwt(response.idToken);
    //   _firstName = _jwt['given_name'].toString();
    //   _lastName = _jwt['family_name'].toString();
    //   _displayName = _jwt['name'].toString();
    //   _email = _jwt['emails'][0];
    // });
  }

  // Map<String, dynamic> parseJwt(String token) {
  //   final parts = token.split('.');
  //   if (parts.length != 3) {
  //     throw Exception('invalid token');
  //   }

  //   final payload = _decodeBase64(parts[1]);
  //   final payloadMap = json.decode(payload);
  //   if (payloadMap is! Map<String, dynamic>) {
  //     throw Exception('invalid payload');
  //   }

  //   return payloadMap;
  // }

  // String _decodeBase64(String str) {
  //   String output = str.replaceAll('-', '+').replaceAll('_', '/');

  //   switch (output.length % 4) {
  //     case 0:
  //       break;
  //     case 2:
  //       output += '==';
  //       break;
  //     case 3:
  //       output += '=';
  //       break;
  //     default:
  //       throw Exception('Illegal base64url string!"');
  //   }

  //   return utf8.decode(base64Url.decode(output));
  // }
  @action
  Future<void> signOut() async {
    try {
      //for some reason the API works differently on iOS and Android
      Map<String, String> additionalParameters = {
        "id_token_hint": _idToken,
        "post_logout_redirect_uri": _redirectUrl
      };
      if (Platform.isAndroid) {
        //works on Android but is missing p parameter when redirected back to authorize on iOS
        additionalParameters = {
          "id_token_hint": _idToken,
          "post_logout_redirect_uri": _redirectUrl
        };
      } else if (Platform.isIOS) {
        //missing p parameter when redirected back to authorize on iOS so the below difference
        additionalParameters = {
          "id_token_hint": _idToken,
          "post_logout_redirect_uri": _redirectUrl,
          'p': 'B2C_1_UniHealthTestSignUpSignIn'
        };
      }
      await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          _clientId,
          _redirectUrl,
          promptValues: ['login'],
          discoveryUrl: _discoveryURL,
          additionalParameters: additionalParameters,
          scopes: _scopes,
        ),
      );
    } catch (e) {
      print(e);
    }
  }
}
