import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_app/provider/student_provider.dart';
import 'package:student_management_app/widgets/student_card.dart';

// ignore: must_be_immutable
class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
        title: TextField(
          autofocus: true,
          maxLines: 1,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15),
            ),
            hintText: 'Search',
            filled: true,
            fillColor: Colors.black26,
            hintStyle: const TextStyle(
              color: Colors.white,
            ),
          ),
          onChanged: (value) {
            Provider.of<StudentProvider>(context,listen: false).searchText = value;
            // print(Provider.of<StudentProvider>(context,listen: false).searchText);
          },
        ),
      ),
      body: Consumer<StudentProvider>(
        builder: (BuildContext context, value, Widget? child) {
          List students = value.getSudents();

          if (value.searchText.isNotEmpty) {
            List searchResult = students
                .where((element) => element.name.toLowerCase().contains(
                      value.searchText.toLowerCase(),
                    ))
                .toList();
            if (searchResult.isNotEmpty) {
              return
              //  Center(
              //   child: Text(
              //     value.searchText,
              //     style: TextStyle(color: Colors.black),
              //   ),
              // );
              StudentCard(students: searchResult);
            } else {
              return const Center(
                child: Text(
                  "No students found",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
