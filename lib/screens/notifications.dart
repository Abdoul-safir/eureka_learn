import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Notifications")),
        body: ListView.builder(
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: ListTile(
                title: Text("Lorem ipsum notiff"),
                subtitle: Text("Many minutes ago"),
                leading: Icon(LineIcons.history),
                trailing: Text("3 min ago"),
              ),
            );
          },
        ));
  }
}
