import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../stores/nav/nav_store.dart';

class NavBottomWidget extends StatefulWidget {
  const NavBottomWidget({Key? key}) : super(key: key);

  @override
  State<NavBottomWidget> createState() => _NavBottomWidgetState();
}

class _NavBottomWidgetState extends State<NavBottomWidget> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NavStore>(context);
    final currentItem = provider.navigationItem;
    if (currentItem == NavigationItem.map) {
      setState(() => currentIndex = 0);
    } else if (currentItem == NavigationItem.list) {
      setState(() => currentIndex = 1);
    }
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: (index) {
        // if (index == 0) {
        //   provider.setNavigationItem(context, NavigationItem.map);
        // } else {
        //   provider.setNavigationItem(context, NavigationItem.list);
        // }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.map), label: 'EMR'),
        BottomNavigationBarItem(icon: Icon(Icons.near_me), label: 'OPR'),
        BottomNavigationBarItem(icon: Icon(Icons.near_me), label: 'CWF'),
      ],
    );
  }
}
