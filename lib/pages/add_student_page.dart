import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_management_app/provider/student_provider.dart';

// ignore: must_be_immutable
class AddStudent extends StatelessWidget {
  AddStudent({Key? key}) : super(key: key);

  String? name;
  String? domain;
  String pic = 'assets/img/avatar.png';
  String? imagePath;
  int? age;
  bool imgStatus = false;

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white10,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Add Student",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      final ImagePicker _picker = ImagePicker();

                      final XFile? imagePath =
                          await _picker.pickImage(source: ImageSource.gallery);

                      if (imagePath != null) {
                        pic = imagePath.path;
                        imgStatus =
                            Provider.of<StudentProvider>(context, listen: false)
                                .changeImage();
                      }
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Consumer<StudentProvider>(builder:
                            (BuildContext context, value, Widget? child) {
                          return !imgStatus
                              ? Container(
                                  height: 140,
                                  width: 140,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image:
                                          AssetImage('assets/img/avatar.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 140,
                                  width: 140,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: FileImage(
                                        File(pic),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                        }),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.teal[800],
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.add_photo_alternate_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: const TextStyle(
                        fontSize: 16,
                      ),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(30))),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "*Required";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    name = value;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Age',
                      labelStyle: const TextStyle(
                        fontSize: 16,
                      ),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(30))),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "*Required";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      age = int.parse(value);
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Domain',
                      labelStyle: const TextStyle(
                        fontSize: 16,
                      ),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(30))),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "*Required";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    domain = value;
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      if (formkey.currentState!.validate()) {
                        Provider.of<StudentProvider>(context, listen: false)
                            .addStudent(name!, age!, domain!, pic);

                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 140,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4044C9),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Center(
                        child: Text(
                          "Save",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ),
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
