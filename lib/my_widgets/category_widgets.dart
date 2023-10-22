import 'package:flutter/material.dart';

import '../minor_screens/sub_category_page.dart';

class CategoryHeaderLabel extends StatelessWidget {
  const CategoryHeaderLabel({super.key, required this.headerLabel});
  final String headerLabel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 5),
      child: Text(
        headerLabel,
        style: const TextStyle(fontSize: 24, letterSpacing: 5.4),
      ),
    );
  }
}

class SubCategoryModel extends StatelessWidget {
  const SubCategoryModel(
      {super.key,
      required this.mainCategoryName,
      required this.subCategoryName,
      required this.assetName,
      required this.assetLabel});
  final String mainCategoryName;
  final String subCategoryName;
  final String assetName;
  final String assetLabel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          // We'll send the first name from the category list here
          // so that it might lead to the relevant sub-category name there
          // and will show other details there
          return SubCategoryPage(
            mainCategoryName: mainCategoryName,
            subCategoryName: subCategoryName,
          );
        }));
      },
      child: Column(
        children: [
          SizedBox(
            height: 60,
            width: 100,
            child: Image(
              image: AssetImage(
                assetName,
              ),
              fit: BoxFit.fill,
              filterQuality: FilterQuality.high,
            ),
          ),
          Text(assetLabel), // see the comments over there, if need be
        ],
      ),
    );
  }
}

class SliderBar extends StatelessWidget {
  const SliderBar({super.key, required this.size, required this.mainCategName});

  final Size size;
  final String mainCategName;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * .75,
      width: size.width * .05,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 30),
        decoration: BoxDecoration(
          color: Colors.brown.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: RotatedBox(
          quarterTurns: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('<<'),
              Text(
                mainCategName,
                style: const TextStyle(fontSize: 20),
              ),
              const Text('>>'),
            ],
          ),
        ),
      ),
    );
  }
}
