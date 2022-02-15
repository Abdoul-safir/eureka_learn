import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:eureka_learn/screens/screens.dart';
import 'package:eureka_learn/utils/utils.dart';
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
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  colorFilter: ColorFilter.mode(
                      Palette.primary.withOpacity(0.85), BlendMode.color),
                  image: AssetImage("assets/icons/jpeg/background.jpg"))),
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(8.0) +
                const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
            child: Flex(
              direction: Axis.vertical,
              children: [
                Text("🤓", style: TextStyle(fontSize: 64.0)),
                Logo(withIcon: false, size: 42.0),
                const SizedBox(height: 5.0),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText("Hack your success now",
                        speed: const Duration(milliseconds: 100),
                        cursor: "⚡",
                        textStyle: Styles.subtitle),
                  ],
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                  repeatForever: true,
                ),
                const SizedBox(height: 30.0),
                GestureDetector(
                  onTap: () => Get.to(() => Login()),
                  child: Button(
                    color: Palette.primary,
                    label: "Login",
                    icon: LineIcons.signature,
                  ),
                ),
                const SizedBox(height: 15.0),
                GestureDetector(
                  onTap: () => Get.to(() => Signup()),
                  child: Button(
                    color: Palette.success,
                    label: "SignUp ",
                    icon: LineIcons.userPlus,
                  ),
                ),
                //const SizedBox(height: 100.0),
                // Text("You can quick login using touch ID 😉"),
                // const SizedBox(height: 10.0),
                // Container(
                //   height: 75.0,
                //   width: 75.0,
                //   decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       border: Border.all(
                //         color: Palette.light,
                //       )),
                //   child: Icon(LineIcons.fingerprint,
                //       size: 64.0, color: Palette.light),
                // )
              ],
            ),
          )),
        )),
      ),
    );
  }
}
