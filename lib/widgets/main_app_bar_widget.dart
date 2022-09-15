import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unihealth/stores/nav/nav_store.dart';
import 'package:unihealth/utils/routes/routes.dart';

import '../utils/locale/app_localizations.dart';

class MainAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  MainAppBarWidget(this.title, {Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  String? title;
  @override
  State<MainAppBarWidget> createState() => _MainAppBarWidgetState();

  @override
  final Size preferredSize;
}

class _MainAppBarWidgetState extends State<MainAppBarWidget> {
  @override
  void initState() {
    super.initState();
    if (widget.title == '') {
      widget.title =
          AppLocalizations.of(context).translate('home_header_label');
    }
  }

  @override
  Widget build(BuildContext context) => AppBar(
        centerTitle: true,
        title: Text(widget.title ?? ''),
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            final provider = Provider.of<NavStore>(context, listen: false);
            provider.setNavigationItem(context, Routes.home);
          },
        ),
      );
}
