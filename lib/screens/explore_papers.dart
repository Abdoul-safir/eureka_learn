import 'package:card_swiper/card_swiper.dart';
import 'package:eureka_learn/models/models.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icons.dart';

final showFilterProvider = StateProvider<bool>((ref) => false);
final showSearchProvider = StateProvider<bool>((ref) => false);

class ExplorePapers extends HookWidget {
  final String subject;
  final String classe;
  final List<PaperModel> papers;
  const ExplorePapers(
      {Key? key,
      required this.subject,
      required this.papers,
      required this.classe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showFilter = useProvider(showFilterProvider);
    final activeTypesMenu = useProvider(activeMenuProvider);
    final showSearch = useProvider(showSearchProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("$subject papers", style: Styles.subtitle),
        bottom: PreferredSize(
          preferredSize: Size(Screen.width(context), 30.0),
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: Container(
              height: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                border: Border.all(color: Colors.grey, width: 1.50),
                color: Colors.grey.withOpacity(0.3),
              ),
              child: TextFormField(
                onTap: () => showSearch.state = !showSearch.state,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        icon: Icon(LineIcons.filter),
                        onPressed: () {
                          showFilter.state = !showFilter.state;
                        }),
                    prefixIcon: Icon(LineIcons.search),
                    border: InputBorder.none,
                    hintText: "Which paper are you lokking for ?"),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: showSearch.state
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Logo(
                      withIcon: true,
                    ))
                  ],
                )
              : Column(
                  children: [
                    PapersMenu(),
                    IndexedStack(
                      index: activeTypesMenu.state,
                      children: [
                        Papers(feed: "Sequence", feedPapers: papers),
                        Papers(feed: "Exams", feedPapers: papers),
                        Papers(feed: "Quizz", feedPapers: papers),
                        Papers(feed: "Mock", feedPapers: papers),
                      ],
                    )
                  ],
                )),
    );
  }
}

class Papers extends StatelessWidget {
  final String feed;
  final List<PaperModel> feedPapers;
  const Papers({Key? key, required this.feed, required this.feedPapers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.only(left: 14.0, right: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 20.0),
            child: Text("Papers you may like", style: Styles.subtitle),
          ),
          ...feedPapers.map((paper) => Paper(model: paper))
        ],
      ),
    ));
  }
}
