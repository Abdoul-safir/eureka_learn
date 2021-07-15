import 'package:animate_do/animate_do.dart';
import 'package:eureka_learn/providers/auth_providers.dart';
import 'package:eureka_learn/screens/screens.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icons.dart';

class AppDrawer extends HookWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _auth = useProvider(authProvider);
    return Drawer(
        child: FlipInY(
            child: Container(
                child: ListView(
      children: [
        UserAccountsDrawerHeader(
          otherAccountsPictures: [
            Logo(withIcon: true),
          ],
          decoration: BoxDecoration(gradient: Palette.linearGradient),
          margin: null,
          accountEmail: Text("eureka.learn@admin.cm"),
          accountName: Text("Alpha admin"),
        ),
        for (var item in items..shuffle()) item,
        ListTile(
            onTap: () => _auth.logoutUser(),
            title: Text("Logout"),
            leading: Icon(LineIcons.signature),
            trailing: Icon(LineIcons.angleRight)),
      ],
    ))));
  }
}

List<dynamic> items = [
  DrawerItem(
      icon: Icon(LineIcons.signature),
      label: "Logout",
      destination: Settings()),
  DrawerItem(
      icon: Icon(LineIcons.save), label: "Saved", destination: FlutterLogo()),
  DrawerItem(
      icon: Icon(LineIcons.identificationBadge),
      label: "Authentication",
      destination: Welcome()),
  DrawerItem(
      icon: Icon(LineIcons.themeco),
      label: "Profile",
      destination: FlutterLogo()),
  DrawerItem(
      icon: Icon(LineIcons.medal),
      label: "Challenges",
      destination: FlutterLogo()),
  DrawerItem(
      icon: Icon(LineIcons.star), label: "Rate us", destination: FlutterLogo()),
];

class DrawerItem extends StatelessWidget {
  final Widget? icon;
  final String label;
  final Widget? destination;
  const DrawerItem({Key? key, this.icon, required this.label, this.destination})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () => Get.to(() => destination ?? FlutterLogo()),
        leading: icon,
        title: Text(label),
        trailing: Icon(LineIcons.angleRight));
  }
}
