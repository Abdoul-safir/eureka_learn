import 'package:animate_do/animate_do.dart';
import 'package:eureka_learn/controllers/controllers.dart';
import 'package:eureka_learn/models/models.dart';

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
    final student = useProvider(studentControllerProvider.notifier);
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
            accountEmail: Text(student.student.school ?? ""),
            accountName: Text(student.getName())),
        for (var item in items) item,
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
      icon: Icon(LineIcons.algolia, color: Palette.primary),
      label: "Settings",
      destination: Settings()),
  DrawerItem(
      icon: Icon(LineIcons.fileDownload, color: Palette.primary),
      label: "Saved",
      destination: FlutterLogo()),
  DrawerItem(
      icon: Icon(LineIcons.identificationBadge, color: Palette.primary),
      label: "Authentication",
      destination: Welcome()),
  DrawerItem(
    icon: Icon(LineIcons.questionCircle, color: Palette.primary),
    label: "Quizz test",
    destination: FlutterLogo(),
  ), //QuizzPage(quizz: quizz)),
  DrawerItem(
      icon: Icon(LineIcons.themeco, color: Palette.primary),
      label: "Profile",
      destination: Profile(user: Student.initial())),
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
        title: Text(label, style: Styles.subtitle),
        trailing: Icon(LineIcons.angleRight));
  }
}
