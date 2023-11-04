import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {super.key,
      this.mHeight,
      this.mWidth,
      this.backgroundColor,
      // required this.clickedOrNot,
      required this.title,
      required this.onTapped});

  final Color? backgroundColor;
  //final bool clickedOrNot;
  final Widget title;
  final Function() onTapped;
  final double? mHeight;
  final double? mWidth;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return InkWell(
      onTap: onTapped,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
          alignment: Alignment.center,
          height: mHeight ?? size.height * .05,
          width: mWidth ?? size.width * .4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: backgroundColor ?? Colors.grey.shade100,
            boxShadow: <BoxShadow>[
              BoxShadow(
                offset: -const Offset(2, 2),
                color: Colors.grey.shade50,
                //  spreadRadius: 2,
                //  blurRadius: 4,
                // inset: clickedOrNot,
              ),
              const BoxShadow(
                offset: Offset(2, 1.5),
                color: Color(0xffa7a9af),
                // blurRadius: 4,
                // inset: clickedOrNot,
              ),
            ],
          ),
          child: FittedBox(
            child: title,
          )),
    );
  }
}
