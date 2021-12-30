import 'package:hive/hive.dart';
part 'student_model.g.dart';


@HiveType(typeId: 1)
class StudentModel extends HiveObject {
  @HiveField(0)
  String? name;

  @HiveField(1)
  int? age;

  @HiveField(2)
  String? domain;

  @HiveField(3)
  String? pic;

  StudentModel(
    this.name,
    this.age,
    this.domain,
    this.pic,
  );
}
