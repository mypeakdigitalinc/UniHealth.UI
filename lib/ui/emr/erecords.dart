import 'package:flutter/material.dart';

import '../../widgets/nav_drawer_widget.dart';

class ERecordsScreen extends StatefulWidget {
  const ERecordsScreen({Key? key}) : super(key: key);

  @override
  State<ERecordsScreen> createState() => _ERecordsScreenState();
}

class _ERecordsScreenState extends State<ERecordsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const NavDrawerWidget(),
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text('E-Records'),
      //actions: _buildActions(context),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Container(
      decoration: const BoxDecoration(color: Colors.grey),
      child: const Center(
        child: Text('E-Records'),
      ),
    );
  }
}
