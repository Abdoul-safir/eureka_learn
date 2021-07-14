import 'package:eureka_learn/utils/screen.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class All extends StatelessWidget {
  const All({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverToBoxAdapter(
        child: Container(
            height: Screen.height(context) * 0.25,
            decoration: BoxDecoration(
                //gradient: Palette.linearGradient,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0))),
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(TextSpan(text: "Hi, ", children: [
                          TextSpan(
                              text: "Zarathustra",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              )),
                        ]))
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 4.0),
                  child: TextFormField(
                      autofocus: false,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      maxLength: 1000,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Palette.primary, width: 1),
                              borderRadius: BorderRadius.circular(20.0)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Palette.primary, width: 0.50),
                              borderRadius: BorderRadius.circular(20.0)),
                          prefix: Text("✍️"),
                          filled: true,
                          fillColor: Colors.grey.shade200)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      ActionButton(
                          label: "add file",
                          icon: Text("🖇️"),
                          callback: () => print("exporting...")),
                      const SizedBox(width: 10.0),
                      ActionButton(
                          label: "add photo",
                          icon: Icon(LineIcons.photoVideo),
                          callback: () => print("exporting..."))
                    ],
                  ),
                )
              ],
            )),
      ),
      SliverToBoxAdapter(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("Browsing by categories..."),
      )),
      SliverToBoxAdapter(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            height: 110.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: subjectsBox.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: subjectsBox[index]);
              },
            )),
      )),
      SliverList(
        delegate: SliverChildListDelegate.fixed(
            posts.map((post) => Post(model: post)).toList()),
      )
    ]);
  }
}

var imagesRosot = "assets/icons/png";
List<SubjectBox> subjectsBox = [
  SubjectBox(
      color: Palette.randomColor(),
      subject: "Chemestry",
      imagePath: "$imagesRosot/chemestry.png"),
  SubjectBox(
      color: Palette.randomColor(),
      subject: "Maths",
      imagePath: "$imagesRosot/maths.png"),
  SubjectBox(
      color: Palette.randomColor(),
      subject: "Biology",
      imagePath: "$imagesRosot/biology.png"),
  SubjectBox(
      color: Palette.randomColor(),
      subject: "Geography",
      imagePath: "$imagesRosot/geography.png"),
  SubjectBox(
      color: Palette.randomColor(),
      subject: "Philosophy",
      imagePath: "$imagesRosot/philosophy.png"),
  SubjectBox(
      color: Palette.randomColor(),
      subject: "Physics",
      imagePath: "$imagesRosot/atom.png"),
  SubjectBox(
      color: Palette.randomColor(),
      subject: "Csc",
      imagePath: "$imagesRosot/atom.png"),
];

List<PostModel> posts = [
  PostModel(
      withPicture: true,
      picturePath: "assets/icons/png/biology.png",
      timeAgo: "2 days",
      postOwner: "Zarathustra nion",
      comments: ["Waouh", "Meme situation"],
      likesCount: 41,
      tags: ["Maths", "Trigonometry", "sciences", "exam"]),
  PostModel(
      withPicture: false,
      picturePath: "assets/icons/png/biology.png",
      timeAgo: "30 min ago",
      postOwner: "Bloomeureka",
      comments: ["comme ci comme ca", "Por favor"],
      likesCount: 20,
      tags: ["Java", "Life"]),
  PostModel(
      withPicture: true,
      picturePath: "assets/icons/png/biology.png",
      timeAgo: "2 days",
      postOwner: "Zarathustra nion",
      comments: ["Waouh", "Meme situation"],
      likesCount: 41,
      tags: ["Geo", "Maths"]),
  PostModel(
      withPicture: false,
      picturePath: "assets/icons/png/biology.png",
      timeAgo: "30 min ago",
      postOwner: "Bloomeureka",
      comments: ["comme ci comme ca", "Por favor"],
      likesCount: 20,
      tags: ["Java", "data structures", "arrays", "sorting"]),
  PostModel(
      withPicture: true,
      picturePath: "assets/icons/png/biology.png",
      timeAgo: "2 days",
      postOwner: "Zarathustra nion",
      comments: ["Waouh", "Meme situation"],
      likesCount: 41,
      tags: ["Geo", "Maths"]),
  PostModel(
      withPicture: false,
      picturePath: "assets/icons/png/biology.png",
      timeAgo: "30 min ago",
      postOwner: "Bloomeureka",
      comments: ["comme ci comme ca", "Por favor"],
      likesCount: 20,
      tags: ["Java", "Life"]),
  PostModel(
      withPicture: true,
      picturePath: "assets/icons/png/biology.png",
      timeAgo: "2 days",
      postOwner: "Zarathustra nion",
      comments: ["Waouh", "Meme situation"],
      likesCount: 41,
      tags: ["Geo", "Maths"]),
  PostModel(
      withPicture: false,
      picturePath: "assets/icons/png/biology.png",
      timeAgo: "30 min ago",
      postOwner: "Bloomeureka",
      comments: ["comme ci comme ca", "Por favor"],
      likesCount: 20,
      tags: ["Java", "Life"]),
];
