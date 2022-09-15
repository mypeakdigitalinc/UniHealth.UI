import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unihealth/utils/routes/routes.dart';

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
    final currentRoute = provider.currentRoute;
    if (currentRoute == Routes.erecords) {
      setState(() => currentIndex = 0);
    } else if (currentRoute == Routes.eregistration) {
      setState(() => currentIndex = 1);
    } else if (currentRoute == Routes.eworkflow) {
      setState(() => currentIndex = 2);
    }
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            provider.setNavigationItem(context, Routes.erecords);
            break;
          case 1:
            provider.setNavigationItem(context, Routes.eregistration);
            break;
          case 2:
            provider.setNavigationItem(context, Routes.eworkflow);
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.medical_information), label: 'EMR'),
        BottomNavigationBarItem(
            icon: Icon(Icons.medical_services), label: 'OPR'),
        BottomNavigationBarItem(
            icon: Icon(Icons.personal_injury), label: 'CWF'),
      ],
    );
  }
}
