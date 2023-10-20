import 'package:flutter/material.dart';
import 'package:latuni/my_widgets/fake_search.dart';

/// global list totally related to our categories listed on Home

List<CategoryData> categories = [
  CategoryData(label: 'Kisan Bhai'),
  CategoryData(label: 'Dairy'),
  CategoryData(label: 'Kirana Grocery'),
  CategoryData(label: 'Grocery'),
];

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const FakeSearch(),
        elevation: 0,
        backgroundColor: Colors.grey.shade100,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: 0,
              bottom: 0,
              child: leftContainer(size),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: rightContainer(size),
            ),
          ],
        ),
      ),
    );
  }

  Container leftContainer(Size size) {
    return Container(
      width: size.width * .23,
      height: size.height * .78,
      decoration: BoxDecoration(
        color: Colors.blue.shade300,
      ),
      child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  for (var item in categories) {
                    item.isSelected = false;
                  }
                  categories[index].isSelected = true;
                });
              },
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: categories[index].isSelected
                      ? Colors.grey.shade100
                      : Colors.blue.shade300,
                  border: Border(
                    bottom: BorderSide(
                        color: categories[index].isSelected
                            ? Colors.transparent
                            : Colors.red.shade900),
                  ),
                ),
                child: Center(
                  child: Text(
                    categories[index].label.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Container rightContainer(Size size) {
    return Container(
      width: size.width * .77,
      height: size.height * .78,
      decoration: BoxDecoration(
        color: Colors.red.shade100,
      ),
      child: const Center(child: Text('Right Container')),
    );
  }
}

class CategoryData {
  String label;
  bool isSelected;
  CategoryData({required this.label, this.isSelected = false});
}
