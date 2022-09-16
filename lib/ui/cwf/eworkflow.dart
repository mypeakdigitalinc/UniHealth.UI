import 'package:flutter/material.dart';

import '../../utils/locale/app_localizations.dart';
import '../../widgets/main_app_bar_widget.dart';
import '../../widgets/nav_bottom_widget.dart';
import '../../widgets/nav_drawer_widget.dart';

class EWorkflowScreen extends StatefulWidget {
  const EWorkflowScreen({Key? key}) : super(key: key);

  @override
  State<EWorkflowScreen> createState() => _EWorkflowScreenState();
}

class _EWorkflowScreenState extends State<EWorkflowScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const NavDrawerWidget(),
      bottomNavigationBar: const NavBottomWidget(),
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return MainAppBarWidget(
        AppLocalizations.of(context).translate('cwf_header_label'));
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Container(
      decoration: const BoxDecoration(color: Colors.grey),
      child: const Center(
        child: Text('E-Workflow'),
      ),
    );
  }
}
