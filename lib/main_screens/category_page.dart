import 'package:flutter/material.dart';
import 'package:latuni/my_widgets/fake_search.dart';

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
              child: rightContainer(size: size),
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
          itemCount: 4,
          itemBuilder: (context, index) {
            return SizedBox(
              height: 100,
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class rightContainer extends StatelessWidget {
  const rightContainer({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
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
