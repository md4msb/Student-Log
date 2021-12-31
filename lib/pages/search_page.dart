import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_app/provider/student_provider.dart';
import 'package:student_management_app/widgets/student_card.dart';

// ignore: must_be_immutable
class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  String searchText = "";
  List searchResult = [];

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
            searchText = value;
            searchResult = Provider.of<StudentProvider>(context, listen: false)
                .search(searchText);
            Provider.of<StudentProvider>(context, listen: false).changeImage();
          },
        ),
      ),
      body: Consumer<StudentProvider>(
        builder: (BuildContext context, value, Widget? child) {
          if (searchText.isNotEmpty) {
            if (searchResult.isNotEmpty) {
              return StudentCard(students: searchResult);
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
