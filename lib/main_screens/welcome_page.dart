import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final Color backgroundColor = Colors.grey.shade100;

  bool doItClicked = false;
  bool signUpClicked = false;
  void doItTapped() {
    setState(() {
      doItClicked = !doItClicked;
      signUpClicked = false;
    });
  }

  void signUpTapped() {
    setState(() {
      signUpClicked = !signUpClicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Container(
          // alignment: Alignment.center,
          constraints: const BoxConstraints.expand(),
          // color: Colors.red,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyButton(
                    onTapped: doItTapped,
                    clickedOrNot: doItClicked,
                    title: 'DO IT',
                    backgroundColor: backgroundColor),
                const SizedBox(
                  height: 40,
                ),
                MyButton(
                    backgroundColor: backgroundColor,
                    clickedOrNot: signUpClicked,
                    title: 'S I G N U P',
                    onTapped: signUpTapped),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton(
      {super.key,
      required this.backgroundColor,
      required this.clickedOrNot,
      required this.title,
      required this.onTapped});

  final Color backgroundColor;
  final bool clickedOrNot;
  final String title;
  final Function() onTapped;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return InkWell(
      onTap: onTapped,
      child: Container(
        alignment: Alignment.center,
        height: size.height * .05,
        width: size.width * .4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: backgroundColor,
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: -const Offset(5, 5),
              color: Colors.grey.shade50,
              //  spreadRadius: 2,
              blurRadius: 4,
              inset: clickedOrNot,
            ),
            BoxShadow(
              offset: const Offset(5, 5),
              color: const Color(0xffa7a9af),
              blurRadius: 4,
              inset: clickedOrNot,
            ),
          ],
        ),
        child: FittedBox(
            child: Text(
          title,
          style: const TextStyle(fontSize: 40),
        )),
      ),
    );
  }
}
