import 'package:hive/hive.dart';
import 'package:student_management_app/database/student_model.dart';

class Boxes {
  static Box<StudentModel> getInstance() => 
    Hive.box<StudentModel>('students');
}
  
