import 'package:eureka_learn/models/models.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StudentController extends StateNotifier<Student> {
  // ignore: unused_field
  final Reader _read;
  StudentController(this._read, Student student) : super(student);
  Student get student => state;
  //set student(Student _student) => student = _student;
  set data(Student _student) => state = _student;

  void printUser() {
    print(state);
  }

  String getName() {
    return state.names;
  }
}
