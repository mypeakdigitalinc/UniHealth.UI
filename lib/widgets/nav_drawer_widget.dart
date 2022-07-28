import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/nav_item.dart';
import '../models/user.dart';
import '../utils/locale/app_localizations.dart';

class NavDrawerWidget extends StatelessWidget {
  const NavDrawerWidget({Key? key}) : super(key: key);
  static const padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) => Drawer(
        child: Container(
          color: const Color.fromRGBO(50, 55, 205, 1),
          child: ListView(
            children: <Widget>[
              buildHeader(
                context,
                urlImage: urlImage,
                name: name,
                email: email,
              ),
              Container(
                padding: padding,
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    buildMenuItem(
                      context,
                      item: NavItem.profile,
                      text: AppLocalizations.of(context).translate('profile'),
                      icon: Icons.manage_accounts,
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      context,
                      item: NavItem.favourites,
                      text: AppLocalizations.of(context).translate('favorites'),
                      icon: Icons.favorite_border,
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      context,
                      item: NavItem.notifications,
                      text: AppLocalizations.of(context)
                          .translate('notifications'),
                      icon: Icons.notifications_outlined,
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      context,
                      item: NavItem.settings,
                      text: AppLocalizations.of(context).translate('settings'),
                      icon: Icons.update,
                    ),
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 24),
                    buildMenuItem(
                      context,
                      item: NavItem.aboutus,
                      text: AppLocalizations.of(context).translate('aboutus'),
                      icon: Icons.info,
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      context,
                      item: NavItem.contactus,
                      text: AppLocalizations.of(context).translate('contactus'),
                      icon: Icons.contact_support,
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      context,
                      item: NavItem.logout,
                      text: AppLocalizations.of(context).translate('logout'),
                      icon: Icons.logout,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildMenuItem(
    BuildContext context, {
    required NavItem item,
    required String text,
    required IconData icon,
  }) {
    //final provider = Provider.of<NavStore>(context);
    //final currentItem = provider.navigationItem;
    final isSelected = false;
    //item == currentItem;

    final color = isSelected ? Colors.orangeAccent : Colors.white;

    return Material(
      color: Colors.transparent,
      child: ListTile(
        selected: isSelected,
        selectedTileColor: Colors.white24,
        leading: Icon(icon, color: color),
        title: Text(text, style: TextStyle(color: color, fontSize: 16)),
        onTap: () => selectItem(context, item),
      ),
    );
  }

  void selectItem(BuildContext context, NavItem item) {
    Future.delayed(const Duration(milliseconds: 0), () {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(item.name, (Route<dynamic> route) => false);
    });
  }

  Widget buildHeader(
    BuildContext context, {
    required String urlImage,
    required String name,
    required String email,
  }) =>
      Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => selectItem(context, NavItem.header),
          child: Container(
            padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
            child: Row(
              children: [
                CircleAvatar(
                    radius: 30, backgroundImage: NetworkImage(urlImage)),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      email,
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ],
                ),
                const Spacer(),
                const CircleAvatar(
                  radius: 24,
                  backgroundColor: Color.fromRGBO(30, 60, 168, 1),
                  child: Icon(Icons.add_comment_outlined, color: Colors.white),
                )
              ],
            ),
          ),
        ),
      );
}
