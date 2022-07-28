import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:unihealth/widgets/nav_drawer_widget.dart';

import '../../data/sharedpref/constants/preferences.dart';
import '../../stores/language/language_store.dart';
import '../../stores/theme/theme_store.dart';
import '../../utils/locale/app_localizations.dart';
import '../../utils/routes/routes.dart';
import '../../widgets/custom_progress_indicator_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //stores:---------------------------------------------------------------------
  //late PostStore _postStore;
  late ThemeStore _themeStore;
  late LanguageStore _languageStore;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores
    _languageStore = Provider.of<LanguageStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    //_postStore = Provider.of<PostStore>(context);

    // check to see if already called api
    // if (!_postStore.loading) {
    //   _postStore.getPosts();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const NavDrawerWidget(),
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  // app bar methods:-----------------------------------------------------------
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(AppLocalizations.of(context).translate('home_header_label')),
      //actions: _buildActions(context),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return <Widget>[
      _buildLanguageButton(),
      _buildThemeButton(),
      _buildLogoutButton(),
    ];
  }

  Widget _buildThemeButton() {
    return Observer(
      builder: (context) {
        return IconButton(
          onPressed: () {
            _themeStore.changeBrightnessToDark(!_themeStore.darkMode);
          },
          icon: Icon(
            _themeStore.darkMode ? Icons.brightness_5 : Icons.brightness_3,
          ),
        );
      },
    );
  }

  Widget _buildLogoutButton() {
    return IconButton(
      onPressed: () {
        SharedPreferences.getInstance().then((preference) {
          preference.setBool(Preferences.is_logged_in, false);
          Navigator.of(context).pushReplacementNamed(Routes.login);
        });
      },
      icon: Icon(
        Icons.power_settings_new,
      ),
    );
  }

  Widget _buildLanguageButton() {
    return IconButton(
      onPressed: () {
        //_buildLanguageDialog();
      },
      icon: Icon(
        Icons.language,
      ),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        _handleErrorMessage(),
        _buildMainContent(),
      ],
    );
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return CustomProgressIndicatorWidget();
        // return _postStore.loading
        //     ? CustomProgressIndicatorWidget()
        //     : Material(child: _buildListView());
      },
    );
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        // if (_postStore.errorStore.errorMessage.isNotEmpty) {
        //   return _showErrorMessage(_postStore.errorStore.errorMessage);
        // }
        return SizedBox.shrink();
      },
    );
  }

  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title: AppLocalizations.of(context).translate('home_error'),
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });

    return SizedBox.shrink();
  }

  // _buildLanguageDialog() {
  //   _showDialog<String>(
  //     context: context,
  //     child: MaterialDialog(
  //       borderRadius: 5.0,
  //       enableFullWidth: true,
  //       title: Text(
  //         AppLocalizations.of(context).translate('home_tv_choose_language'),
  //         style: TextStyle(
  //           color: Colors.white,
  //           fontSize: 16.0,
  //         ),
  //       ),
  //       headerColor: Theme.of(context).primaryColor,
  //       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
  //       closeButtonColor: Colors.white,
  //       enableCloseButton: true,
  //       enableBackButton: false,
  //       onCloseButtonClicked: () {
  //         Navigator.of(context).pop();
  //       },
  //       children: _languageStore.supportedLanguages
  //           .map(
  //             (object) => ListTile(
  //               dense: true,
  //               contentPadding: EdgeInsets.all(0.0),
  //               title: Text(
  //                 object.language!,
  //                 style: TextStyle(
  //                   color: _languageStore.locale == object.locale
  //                       ? Theme.of(context).primaryColor
  //                       : _themeStore.darkMode
  //                           ? Colors.white
  //                           : Colors.black,
  //                 ),
  //               ),
  //               onTap: () {
  //                 Navigator.of(context).pop();
  //                 // change user language based on selected locale
  //                 _languageStore.changeLanguage(object.locale!);
  //               },
  //             ),
  //           )
  //           .toList(),
  //     ),
  //   );
  // }

  _showDialog<T>({required BuildContext context, required Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T? value) {
      // The value passed to Navigator.pop() or null.
    });
  }
}
