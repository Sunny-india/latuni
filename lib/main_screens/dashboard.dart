import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:latuni/my_widgets/appbar_widgets.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});
  final List<Map<String, dynamic>> listOfIconLabel = [
    {'icon': Icons.store, 'label': 'My Store'},
    {'icon': Icons.shop_2_outlined, 'label': 'Orders'},
    {'icon': Icons.edit, 'label': 'Edit Profile'},
    {'icon': Icons.settings, 'label': 'Manage Products'},
    {'icon': Icons.attach_money, 'label': 'Balance'},
    {'icon': Icons.show_chart, 'label': 'Statics'},
  ];

  Color backgroundColor = Colors.grey.shade100;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      //backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        //centerTitle: true,
        title: const Padding(
          padding: EdgeInsets.only(left: 28.0),
          child: AppbarTitle(title: 'Dashboard'),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 12)
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 40),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 44, crossAxisSpacing: 24),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Container(
                  height: size.height * .15,
                  width: size.width * .15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: backgroundColor,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        offset: -const Offset(5, 5),
                        color: Colors.grey.shade50,
                        //  spreadRadius: 2,
                        blurRadius: 4,
                        inset: true,
                      ),
                      const BoxShadow(
                        offset: Offset(5, 5),
                        color: Color(0xffa7a9af),
                        blurRadius: 4,
                        inset: true,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        listOfIconLabel[index]['icon'],
                        size: 50,
                      ),
                      Text(listOfIconLabel[index]['label']),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}

class LabelIcon extends StatelessWidget {
  const LabelIcon(
      {super.key,
      required this.myIcon,
      required this.myLabel,
      required this.myFunction});
  final IconData myIcon;
  final String myLabel;
  final Function() myFunction;
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
