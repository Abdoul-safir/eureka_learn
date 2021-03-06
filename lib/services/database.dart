import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eureka_learn/models/models.dart';
import 'package:eureka_learn/providers/providers.dart';
import 'package:eureka_learn/utils/utils.dart';
import 'package:eureka_learn/widgets/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:translator/translator.dart';

class Database {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  final Reader _read;
  Database(this._read);

  //=====*****USER AUTHENTICATION*****=====//
  Future<bool> createUser(
      {required String id, required Student student}) async {
    try {
      _firestore
          .collection('students')
          .doc(id)
          .set(Student.toDocumentSnapshot(student))
          .then((_) async {
        getUser(id);
      });

      return true;
    } on FirebaseException catch (err) {
      Toast.toast(
          color: Palette.error,
          title: "Fetching error",
          message: err.message ?? "",
          icon: LineIcons.times);
      return false;
    }
  }

  Future<bool> getUser(String uid) async {
    try {
      await _firestore
          .collection('students')
          .doc(uid)
          .get(GetOptions(source: Source.serverAndCache))
          .then((doc) async {
        Student _student = Student.fromDocumentSnapshot(doc.data());
        _read(studentControllerProvider.notifier).data = _student;
      });
      return true;
    } on FirebaseException catch (err) {
      Toast.toast(
          color: Palette.error,
          title: "Fetching error",
          message: err.message ?? "",
          icon: LineIcons.times);
      return false;
    }
  }

  //=====*****END USER AUTH*****=====//

//=======****POSTS****================//

  bool post(PostModel post) {
    try {
      _firestore
          .collection('posts')
          .doc()
          .set(PostModel.toDocumentSnapshot(post))
          .then((posted) {
        Toast.toast(
            color: Palette.success,
            title: "No error",
            message: "No error",
            icon: LineIcons.checkCircle);
      });

      return true;
    } on FirebaseException catch (err) {
      Toast.toast(
          color: Palette.error,
          title: "Fetching error",
          message: err.message ?? "",
          icon: LineIcons.times);
      return false;
    }
  }

  //======*****END POST*****======//

  // String uploadMedia(File media, String path) {
  //   storage.ref().child(path).putFile(media).then((response){
  //     response.
  //   });
  // }

  Future<List<PaperModel>> getUserPapers(Student user) async {
    List<PaperModel> papers = <PaperModel>[];
    try {
      await _firestore
          .collection("papers")
          .where("level", isEqualTo: user.level)
          .where("subject", whereIn: user.subjects)
          .get()
          .then((snapshot) {
        snapshot.docs.forEach((doc) {
          PaperModel paper = PaperModel.fromDocumentSnapshot(doc.data());
          papers.add(paper);
        });
      });
    } on FirebaseException catch (err) {
      Toast.toast(
          color: Palette.error,
          title: "Fetching error",
          message: err.message ?? "",
          icon: LineIcons.times);
      rethrow;
    }
    return papers;
  }

  Future<void> getUserFeeds() async {
    List<PostModel> timeline = <PostModel>[];
    try {
      await _firestore.collection('posts').get().then((snapshot) {
        snapshot.docs.forEach((doc) {
          PostModel post = PostModel.fromDocumentSnapshot(doc.data());
          timeline.add(post);
        });
      });

      _read(postsControllerProvider.notifier).data = timeline;
    } on FirebaseException catch (err) {
      Toast.toast(
          color: Palette.error,
          title: "Fetching error",
          message: err.message ?? "",
          icon: LineIcons.times);
    }
  }

  Stream getUserBooks(Student user) {
    try {
      Stream papers = _firestore
          .collection("books")
          .where("subject", whereIn: user.subjects)
          .where("tags", arrayContainsAny: user.subjects)
          .where("tags", arrayContainsAny: user.achievements)
          .snapshots();
      return papers;
    } on FirebaseException catch (err) {
      Toast.toast(
          color: Palette.error,
          title: "Fetching error",
          message: err.message ?? "",
          icon: LineIcons.times);
      rethrow;
    }
  }

  Future<String> uploadImage(File image) async {
    try {
      String fileName = image.uri.pathSegments.last;
      Reference storageRef =
          FirebaseStorage.instance.ref().child('posts_images/$fileName');
      await storageRef.putFile(image);
      return await storageRef.getDownloadURL();
      // ignore: unused_catch_clause
    } on FirebaseException catch (err) {
      Toast.toast(
          icon: LineIcons.times,
          color: Palette.error,
          title: "Image upload",
          message: "Something went wrong while uploading file... ");
      rethrow;
    }
  }

/**=============GET USER FEEDS BY STREAM=============== */
  Stream getUserFeedsStream() {
    try {
      return _firestore
          .collection('posts')
          .orderBy('timeAgo', descending: true)
          .snapshots();
    } on FirebaseException catch (err) {
      Toast.toast(
          color: Palette.error,
          title: "Fetching error",
          message: err.message ?? "",
          icon: LineIcons.times);
      rethrow;
    }
  }

  Future<void> pushQuestions({required List<Map<String, dynamic>> data}) async {
    try {
      for (int i = 0; i < 10; i++)
        await _firestore.collection('questions').doc().set(data[i]);
    } on FirebaseException catch (err) {
      Toast.toast(
          color: Palette.error,
          title: "Fetching error",
          message: err.message ?? "",
          icon: LineIcons.times);
      rethrow;
    }
  }

  Future<List<Question>> getQuestions(
      {required int numberOfQuestions,
      required String subject,
      required String difficulty,
      required String type}) async {
    List<Question> _questions = [];
    try {
      await _firestore
          .collection("questions")
          .where("subject", isEqualTo: subject)
          .limit(numberOfQuestions)
          .get()
          .then((questions) {
        questions.docs.forEach(
            (question) => _questions.add(Question.fromMap(question.data())));
      });
      return _questions;
    } on FirebaseException {
      rethrow;
    }
  }

  Future<void> addQuizz(
      {required String userID, required QuizzModel quizz}) async {
    try {
      _firestore.collection("students").doc(userID).update({
        "quizzes": FieldValue.arrayUnion([quizz.toMap()])
      });
    } on FirebaseException catch (err) {
      Toast.toast(
          color: Palette.error,
          title: "Firestore error",
          message: err.message ?? "",
          icon: LineIcons.times);
      rethrow;
    }
  }

  Stream<List<PostModel>> getFeedsBy(String id) {
    final stream = _firestore
        .collection("posts")
        .where("ownerId", isEqualTo: id)
        .snapshots();
    return stream.map((snapshot) => snapshot.docs
        .map((doc) => PostModel.fromDocumentSnapshot(doc.data()))
        .toList());
  }

  Future<void> commentPost(PostModel post, String comment) async {
    try {
      await _firestore
          .collection("posts")
          .where("ownerId", isEqualTo: post.ownerId)
          .where("timeAgo", isEqualTo: post.timeAgo)
          .get()
          .then((snapshot) async {
        snapshot.docs.forEach((doc) async {
          String documentID = doc.id;
          await _firestore.collection("posts").doc(documentID).update({
            "comments": FieldValue.arrayUnion([comment])
          });
        });
      });
    } on FirebaseException catch (err) {
      throw err;
    }
  }
}
