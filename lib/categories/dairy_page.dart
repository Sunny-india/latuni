import 'package:flutter/material.dart';

import '../my_widgets/category_widgets.dart';
import '../utilities/category_list.dart';

/// Ist Category page
class DairyPage extends StatefulWidget {
  const DairyPage({super.key});

  @override
  State<DairyPage> createState() => _DairyPageState();
}

class _DairyPageState extends State<DairyPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        /// Because this page is used on 80% height, 80% width
        /// of the capacity of where it is called, so make it useful that way.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CategoryHeaderLabel(headerLabel: 'Dairy'),
            Container(
              height: size.height * .75,
              color: Colors.red,
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 30),
                  itemCount: dairy.length,
                  itemBuilder: (context, index) {
                    return SubCategoryModel(
                      mainCategoryName: 'Kisan Bhai',
                      subCategoryName: dairy[index],
                      assetName:
                          'assets/images/rubber_bands/disco/DISCO_$index.JPG',
                      assetLabel: dairy[index],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
