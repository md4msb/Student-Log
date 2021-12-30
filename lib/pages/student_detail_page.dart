import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_app/pages/update_page.dart';
import 'package:student_management_app/provider/student_provider.dart';

class StudentDetailPage extends StatelessWidget {
  const StudentDetailPage({Key? key, required this.student}) : super(key: key);

  final dynamic student;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit,
              color: Colors.indigo,
              size: 26,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UpdatePage(student: student)));
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
              size: 26,
            ),
            onPressed: () {
              Provider.of<StudentProvider>(context, listen: false)
                  .deleteStudent(student);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Consumer<StudentProvider>(
          builder: (BuildContext context, value, Widget? child) {
        return Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            Center(
              child: student.pic == 'assets/img/avatar.png'
                  ? Container(
                      height: 150,
                      width: 150,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/img/avatar.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: FileImage(
                            File(student.pic),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
            ),
            Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                dataCard(
                  title: "Name : ",
                  data: student.name,
                ),
                dataCard(
                  title: "Age : ",
                  data: student.age.toString(),
                ),
                dataCard(
                  title: "Domain : ",
                  data: student.domain,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        );
      }),
    );
  }

  Padding dataCard({required title, required data}) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 25),
      child: Container(
        height: 53,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.indigo[100],
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 0.2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  data,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
