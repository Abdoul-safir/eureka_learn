import 'package:animate_do/animate_do.dart';
import 'package:eureka_learn/screens/login.dart';
import 'package:eureka_learn/utils/palette.dart';
import 'package:eureka_learn/utils/screen.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      child: SafeArea(
        child: Scaffold(
            body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(gradient: Palette.linearGradient),
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(8.0) +
                const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("🤓", style: TextStyle(fontSize: 64.0)),
                Logo(withIcon: false, size: 42.0),
                const SizedBox(height: 5.0),
                Text("Hack your success now and future proof yourself"),
                const SizedBox(height: 30.0),
                GestureDetector(
                  onTap: () => Get.to(() => Login()),
                  child: Button(
                    color: Palette.light,
                    label: "Login 🛡",
                  ),
                ),
                const SizedBox(height: 15.0),
                GestureDetector(
                  onTap: () => Get.to(() => Login()),
                  child: Button(
                    color: Palette.light,
                    label: "SignUp 🛡",
                  ),
                ),
                const SizedBox(height: 100.0),
                Text("You can quick login using touch ID 😉"),
                const SizedBox(height: 10.0),
                Container(
                  height: 75.0,
                  width: 75.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Palette.light,
                      )),
                  child: Icon(LineIcons.fingerprint,
                      size: 64.0, color: Palette.light),
                )
              ],
            ),
          )),
        )),
      ),
    );
  }
}
