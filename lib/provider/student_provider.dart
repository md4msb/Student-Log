import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:student_management_app/database/boxes.dart';
import 'package:student_management_app/database/student_model.dart';

class StudentProvider with ChangeNotifier {
  Box<StudentModel> box = Boxes.getInstance();

   String searchText = "";

  

  search(String text) {
    List students = getSudents();
    List searchResult = students
        .where((element) => element.name.toLowerCase().contains(
              text.toLowerCase(),
            ))
        .toList();

    return searchResult;
  }

  addStudent(String name, int age, String domain, pic) async {
    box.add(
      StudentModel(name, age, domain, pic),
    );
    notifyListeners();
  }

  List getSudents() {
    List students = box.values.toList();
    return students;
  }

  deleteStudent(StudentModel student) {
    student.delete();
    notifyListeners();
  }

  updateStudent(StudentModel student) {
    student.save();
    notifyListeners();
  }

  bool changeImage() {
    notifyListeners();
    return true;
  }
}
