import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:eureka_learn/models/models.dart';
import 'package:eureka_learn/services/base_quiz_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

final quizRepositoryProvider =
    Provider<QuizRepository>((ref) => QuizRepository(ref.read));

class QuizRepository extends BaseQuizRepository {
  final Reader _read;

  QuizRepository(this._read);

  @override
  Future<List<Question>> getQuestions(
      {required Student student,
      int? numQuestions,
      required String subject,
      required String level,
      String? topic}) async {
    try {
      print(
          "mapping url:http://intelliquizz.herokuapp.com/$subject/$level/$numQuestions");
      final Response response = await _read(dioProvider).get(
          "http://intelliquizz.herokuapp.com/$subject/$level/$numQuestions",
          options: Options(
              contentType: "application/json",
              listFormat: ListFormat.csv), onReceiveProgress: (x, y) {
        
      });
      print("Data type: ${jsonDecode(response.data).runtimeType}");
      if (response.statusCode == 200) {
        final data = Map<String, dynamic>.from(jsonDecode(response.data));
        final results = List<Map<String, dynamic>>.from(data["data"] ?? []);
        print("created");
        print("quizz set: $results");
        if (results.isNotEmpty) {
          print("returned data");
          print(results.map((e) => Question.fromMap(e)).toList());
          return results.map((e) => Question.fromMap(e)).toList();
        }
      }
      if (response.statusCode == 500) {
        print("500 error");
      }
      return [];
    } on DioError catch (err) {
      print(err);
      throw Failure(
        message: err.response?.statusMessage ?? 'Something went wrong!',
      );
    } on SocketException catch (err) {
      print(err);
      throw const Failure(message: 'Please check your connection.');
    }
  }
}
