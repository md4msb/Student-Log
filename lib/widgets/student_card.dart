import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_management_app/pages/student_detail_page.dart';

class StudentCard extends StatelessWidget {
  const StudentCard({Key? key, required this.students}) : super(key: key);

  final List students;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 30,
        left: 10,
        right: 10,
      ),
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: students.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Card(
                color: Colors.indigo[50],
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF4044C9),
                    child: students[index].pic != 'assets/img/avatar.png'
                        ? Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: FileImage(
                                  File(students[index].pic),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Container(
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage('assets/img/avatar.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                  ),
                  title: Text(students[index].name),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return StudentDetailPage(
                        student: students[index],
                      );
                    }));
                  },
                ),
              ),
            );
          }),
    );
  }
}
