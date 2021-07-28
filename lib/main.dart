import 'package:animate_do/animate_do.dart';
import 'package:eureka_learn/providers/auth_providers.dart';
import 'package:eureka_learn/providers/providers.dart';
import 'package:eureka_learn/screens/login.dart';
import 'package:eureka_learn/screens/screens.dart';
import 'package:eureka_learn/utils/palette.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:line_icons/line_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(ProviderScope(child: EurekaLearn()));
}

class EurekaLearn extends HookWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = useProvider(darkModeProvider);
    return GetMaterialApp(
      title: "EurekaLearn",
      theme: ThemeData(
          primaryColorBrightness: Brightness.light,
          primaryColorDark: Colors.black,
          primarySwatch: Colors.blue,
          primaryColor: Colors.blue,
          textTheme:
              GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme),
          iconTheme: IconThemeData(size: 22.0, opacity: 1),
          appBarTheme: AppBarTheme(
              centerTitle: true,
              color: Palette.light,
              elevation: 0.0,
              systemOverlayStyle:
                  SystemUiOverlayStyle(statusBarColor: Colors.blue),
              actionsIconTheme: IconThemeData(color: Palette.primary),
              textTheme: GoogleFonts.josefinSansTextTheme(),
              iconTheme: IconThemeData(color: Palette.primary, size: 16.0)),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Palette.light,
            elevation: 3.0,
            selectedItemColor: Palette.primary,
            unselectedItemColor: Palette.dark.withOpacity(0.33),
            showUnselectedLabels: true,
            selectedIconTheme:
                IconThemeData(color: Palette.primary, size: 22.0),
            unselectedIconTheme: IconThemeData(color: Colors.grey, size: 18.0),
            selectedLabelStyle:
                TextStyle(color: Palette.primary, fontWeight: FontWeight.bold),
            unselectedLabelStyle:
                TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
          )),
      darkTheme: ThemeData(
          primarySwatch: Colors.grey,
          primaryColor: Colors.black,
          brightness: Brightness.dark,
          backgroundColor: const Color(0xFF1C1C27),
          accentColor: Colors.white,
          dividerColor: Colors.black12,
          textTheme:
              GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme)),
      themeMode: theme.state ? ThemeMode.dark : ThemeMode.light,
      home: Root(),
    );
  }
}

GlobalKey _scaffoldKey = GlobalKey();
final navigationIndexProvider = StateProvider<int>((ref) => 0);
List<LabelModel> subjects = [
  LabelModel(title: "All", iconPath: "🔥", active: false),
  LabelModel(title: "Chemestry", iconPath: "🌡️", active: false),
  LabelModel(title: "Geography", iconPath: "🌍", active: false),
  LabelModel(title: "Biology", iconPath: "🔬", active: false),
  LabelModel(title: "Maths", iconPath: "📈", active: false),
  LabelModel(title: "Csc", iconPath: "💻", active: false),
  LabelModel(title: "Physics", iconPath: "🚀", active: false),
  LabelModel(title: "Philosophy", iconPath: "📚", active: false),
];

List<Widget> _screens = [All(), Library(), Quizz(), Logo(withIcon: true)];

class Home extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final navigationIndex = useProvider(navigationIndexProvider);

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            leading: IconButton(
                icon: Icon(LineIcons.tasks),
                onPressed: () => Scaffold.of(context).openDrawer),
            title: Logo(
              withIcon: true,
            ),
            actions: [
              IconButton(
                  icon: Icon(LineIcons.search),
                  onPressed: () => showSearch(
                        context: context,
                        delegate: Search(),
                      )),
              IconButton(
                  icon: Icon(LineIcons.bell),
                  onPressed: () => Get.to(() => Notifications())),
            ]),
        drawer: AppDrawer(),
        body: IndexedStack(
            key: ValueKey<int>(navigationIndex.state),
            index: navigationIndex.state,
            children:
                _screens.map((screen) => SlideInLeft(child: screen)).toList()),
        floatingActionButton: FloatingActionButton(
          child: Icon(LineIcons.podcast),
          onPressed: () => null,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 3.0,
          child: Container(
            height: 52.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                NavItem(icon: LineIcons.globe, position: 0, label: "Home"),
                NavItem(icon: LineIcons.gift, position: 1, label: "Library"),
                NavItem(icon: LineIcons.school, position: 2, label: "Quizz"),
                NavItem(
                    icon: LineIcons.userFriends, position: 3, label: "Exchnage")
              ],
            ),
          ),
        ));
  }
}

class Root extends ConsumerWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final user = watch(authStateProvider);

    return user.when(
        loading: () => Scaffold(body: CircularProgressIndicator()),
        error: (_, __) => Text("Something went wrong"),
        data: (authenticatedUser) =>
            authenticatedUser != null ? Home() : Login());
  }
}

class NavItem extends HookWidget {
  final IconData icon;
  final int position;
  final String label;
  const NavItem({
    Key? key,
    required this.icon,
    required this.position,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final index = useProvider(navigationIndexProvider);
    return GestureDetector(
      onTap: () => index.state = position,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            children: [
              position == index.state
                  ? Container(
                      height: 4.0,
                      width: 4.0,
                      decoration: BoxDecoration(
                          color: Palette.primary, shape: BoxShape.circle))
                  : SizedBox.shrink(),
              Icon(icon,
                  color: position == index.state
                      ? Palette.primary
                      : Palette.primary.withOpacity(0.5)),
              Text(label,
                  style: TextStyle(
                      color: position == index.state
                          ? Palette.primary
                          : Palette.primary.withOpacity(0.5),
                      fontWeight: position == index.state
                          ? FontWeight.bold
                          : FontWeight.normal))
            ],
          ),
        ),
      ),
    );
  }
}
