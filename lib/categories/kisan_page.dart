import 'package:flutter/material.dart';
import 'package:latuni/utilities/category_list.dart';

import '../minor_screens/sub_category_page.dart';

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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: size.height * .04, bottom: 5),
              child: const Text(
                'Kisan Bhai',
                style: const TextStyle(fontSize: 24, letterSpacing: 5.4),
              ),
            ),
            SizedBox(
              height: size.height * .67,
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 9,
                      mainAxisSpacing: 30),
                  itemCount:
                      kisanBhai.length, // as much as the images available
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          // We'll send the first name from the category list here
                          // so that it might lead to the relant sub-category name there
                          // and will show other details there
                          return SubCategoryPage(
                            mainCategoryName: 'Kisan Bhai',
                            subCategoryName: kisanBhai[index],
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
                                'assets/images/rubber_bands/disco/DISCO_$index.JPG',
                              ),
                              fit: BoxFit.fill,
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                          Text(kisanBhai[
                              index]), // see the comments over there, if need be
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
