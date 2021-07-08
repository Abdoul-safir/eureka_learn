import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        height: double.infinity,
        width: double.infinity,
        // decoration: BoxDecoration(gradient: Palette.linearGradient),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0) +
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
            child: Column(
              children: [
                Text("🤓", style: TextStyle(fontSize: 64.0)),
                Logo(
                  withIcon: false,
                ),
                const SizedBox(height: 30.0),
                Input(
                    icon: LineIcons.userAlt,
                    context: context,
                    type: TextInputType.text,
                    controller: TextEditingController(),
                    label: "username",
                    hint: "Enter your username",
                    isPassword: false,
                    isPhone: false),
                Input(
                    icon: LineIcons.lock,
                    context: context,
                    type: TextInputType.text,
                    controller: TextEditingController(),
                    label: "password",
                    hint: "Enter your password",
                    isPassword: true,
                    isPhone: false),
                const SizedBox(height: 10.0),
                Text("Forgot your password ?",
                    style: TextStyle(color: Palette.error)),
                const SizedBox(height: 20.0),
                Button(
                  label: "Login",
                  color: Palette.primary,
                ),
                const SizedBox(height: 20.0),
                Divider(
                  height: 1.0,
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Button(
                      label: "With Google 🔗",
                      color: Palette.error.withOpacity(0.7),
                    ),
                    Button(
                      label: "With Phone 📲",
                      color: Palette.success,
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Text("Don't have account? Sign Up there...",
                    style: TextStyle(
                        color: Palette.primary, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
