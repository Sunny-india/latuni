import 'package:flutter/material.dart';
import 'package:latuni/utilities/category_list.dart';

import '../my_widgets/category_widgets.dart';

/// Ist Category page
class KisanPage extends StatefulWidget {
  const KisanPage({super.key});

  @override
  State<KisanPage> createState() => _KisanPageState();
}

class _KisanPageState extends State<KisanPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        /// Because this page is used on 75% height, 80% width
        /// of the capacity of where it is called, so make it useful that way.
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 3),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                bottom: 0,
                child: SizedBox(
                  height: size.height * .75,
                  width: size.width * .7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CategoryHeaderLabel(headerLabel: 'Kisan Bhai'),
                      SizedBox(
                        height: size.height * .67,
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 9,
                                    mainAxisSpacing: 30),
                            itemCount: kisanBhai
                                .length, // as much as the images available
                            itemBuilder: (context, index) {
                              return SubCategoryModel(
                                mainCategoryName: 'Kisan Bhai',
                                subCategoryName: kisanBhai[index],
                                assetName:
                                    'assets/images/rubber_bands/disco/DISCO_$index.JPG',
                                assetLabel: kisanBhai[index],
                              );
                            }),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: SliderBar(size: size, mainCategName: 'Kisan Bhai'),
              )
            ],
          ),
        ),
      ),
    );
  }
}