/// this page is first called from kisan_bhai category page

import 'package:flutter/material.dart';

class SubCategoryPage extends StatelessWidget {
  const SubCategoryPage(
      {super.key,
      required this.mainCategoryName,
      required this.subCategoryName});
  final String mainCategoryName;
  final String subCategoryName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100, // the same as that of Scaffold
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        title: Text(
          subCategoryName,
          style: TextStyle(color: Colors.red.shade900),
        ),
      ),
      body: Center(
        child: Text(
          mainCategoryName,
          style: const TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
