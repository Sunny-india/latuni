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

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          //  mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// login text
            ClipPath(
              clipper: ParchiBottom(),
              child: Container(
                alignment: Alignment.center,
                height: 200,
                width: size.width * .9,
                color: Colors.orange,
                child: const Text(
                  'W E L C O M E',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),

            /// email tff
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'email',
              ),
              controller: emailController,
            ),
            SizedBox(height: size.height * .05),

            /// phone tff
            TextFormField(),
            SizedBox(height: size.height * .05),

            /// password tff
            TextFormField(),
            SizedBox(height: size.height * .05),
            // MyButton(
            //     onTapped: doItTapped,
            //     clickedOrNot: doItClicked,
            //     title: const Row(
            //       children: [
            //         Text('D O  I T',
            //             style: TextStyle(
            //                 fontSize: 12,
            //                 fontWeight: FontWeight.bold,
            //                 fontFamily: 'Playpen',
            //                 fontStyle: FontStyle.italic)),
            //       ],
            //     ),
            //     backgroundColor: backgroundColor),
            // const SizedBox(height: 40),
            // MyButton(
            //     backgroundColor: backgroundColor,
            //     clickedOrNot: signUpClicked,
            //     title: const Text('S I G N U P',
            //         style: TextStyle(
            //             fontSize: 40,
            //             fontWeight: FontWeight.bold,
            //             fontFamily: 'Playpen',
            //             fontStyle: FontStyle.italic)),
            //     onTapped: signUpTapped),
          ],
        ),
      ),
    );
  }
}

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
                offset: -const Offset(5, 5),
                color: Colors.grey.shade50,
                //  spreadRadius: 2,
                blurRadius: 4,
                // inset: clickedOrNot,
              ),
              const BoxShadow(
                offset: Offset(5, 5),
                color: Color(0xffa7a9af),
                blurRadius: 4,
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

class ParchiBottom extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    path.moveTo(size.width * .1, 0);
    path.quadraticBezierTo(0, 0, 0, size.height * .2);
    path.lineTo(0, size.height);
    //zigzag starts here
    path.lineTo(size.width * .01, size.height * .95);
    path.lineTo(size.width * .02, size.height);
    path.lineTo(size.width * .03, size.height * .95);
    path.lineTo(size.width * .04, size.height);
    path.lineTo(size.width * .05, size.height * .95);
    path.lineTo(size.width * .06, size.height);
    path.lineTo(size.width * .07, size.height * .95);
    path.lineTo(size.width * .08, size.height);
    path.lineTo(size.width * .09, size.height * .95);
    path.lineTo(size.width * .1, size.height);
    path.lineTo(size.width * .11, size.height * .95);
    path.lineTo(size.width * .12, size.height);
    path.lineTo(size.width * .13, size.height * .95);
    path.lineTo(size.width * .14, size.height);
    path.lineTo(size.width * .15, size.height * .95);
    path.lineTo(size.width * .16, size.height);
    path.lineTo(size.width * .17, size.height * .95);
    path.lineTo(size.width * .18, size.height);
    path.lineTo(size.width * .19, size.height * .95);
    path.lineTo(size.width * .2, size.height);
    path.lineTo(size.width * .21, size.height * .95);
    path.lineTo(size.width * .22, size.height);
    path.lineTo(size.width * .23, size.height * .95);
    path.lineTo(size.width * .24, size.height);
    path.lineTo(size.width * .25, size.height * .95);
    path.lineTo(size.width * .26, size.height);
    path.lineTo(size.width * .27, size.height * .95);
    path.lineTo(size.width * .28, size.height);
    path.lineTo(size.width * .29, size.height * .95);
    path.lineTo(size.width * .3, size.height);
    path.lineTo(size.width * .31, size.height * .95);
    path.lineTo(size.width * .32, size.height);
    path.lineTo(size.width * .33, size.height * .95);
    path.lineTo(size.width * .34, size.height);
    path.lineTo(size.width * .35, size.height * .95);
    path.lineTo(size.width * .36, size.height);
    path.lineTo(size.width * .37, size.height * .95);
    path.lineTo(size.width * .38, size.height);
    path.lineTo(size.width * .39, size.height * .95);
    path.lineTo(size.width * .4, size.height);
    path.lineTo(size.width * .41, size.height * .95);
    path.lineTo(size.width * .42, size.height);
    path.lineTo(size.width * .43, size.height * .95);
    path.lineTo(size.width * .44, size.height);
    path.lineTo(size.width * .45, size.height * .95);
    path.lineTo(size.width * .46, size.height);
    path.lineTo(size.width * .47, size.height * .95);
    path.lineTo(size.width * .48, size.height);
    path.lineTo(size.width * .49, size.height * .95);
    path.lineTo(size.width * .5, size.height);
    path.lineTo(size.width * .51, size.height * .95);
    path.lineTo(size.width * .52, size.height);
    path.lineTo(size.width * .53, size.height * .95);
    path.lineTo(size.width * .54, size.height);
    path.lineTo(size.width * .55, size.height * .95);
    path.lineTo(size.width * .56, size.height);
    path.lineTo(size.width * .57, size.height * .95);
    path.lineTo(size.width * .58, size.height);
    path.lineTo(size.width * .59, size.height * .95);
    path.lineTo(size.width * .6, size.height);
    path.lineTo(size.width * .61, size.height * .95);
    path.lineTo(size.width * .62, size.height);
    path.lineTo(size.width * .63, size.height * .95);
    path.lineTo(size.width * .64, size.height);
    path.lineTo(size.width * .65, size.height * .95);
    path.lineTo(size.width * .66, size.height);
    path.lineTo(size.width * .67, size.height * .95);
    path.lineTo(size.width * .68, size.height);
    path.lineTo(size.width * .69, size.height * .95);
    path.lineTo(size.width * .7, size.height);
    path.lineTo(size.width * .71, size.height * .95);
    path.lineTo(size.width * .72, size.height);
    path.lineTo(size.width * .73, size.height * .95);
    path.lineTo(size.width * .74, size.height);
    path.lineTo(size.width * .75, size.height * .95);
    path.lineTo(size.width * .76, size.height);
    path.lineTo(size.width * .77, size.height * .95);
    path.lineTo(size.width * .78, size.height);
    path.lineTo(size.width * .79, size.height * .95);
    path.lineTo(size.width * .8, size.height);
    path.lineTo(size.width * .81, size.height * .95);
    path.lineTo(size.width * .82, size.height);
    path.lineTo(size.width * .83, size.height * .95);
    path.lineTo(size.width * .84, size.height);
    path.lineTo(size.width * .85, size.height * .95);
    path.lineTo(size.width * .86, size.height);
    path.lineTo(size.width * .87, size.height * .95);
    path.lineTo(size.width * .88, size.height);
    path.lineTo(size.width * .89, size.height * .95);
    path.lineTo(size.width * .9, size.height);
    path.lineTo(size.width * .91, size.height * .95);
    path.lineTo(size.width * .92, size.height);
    path.lineTo(size.width * .93, size.height * .95);
    path.lineTo(size.width * .94, size.height);
    path.lineTo(size.width * .95, size.height * .95);
    path.lineTo(size.width * .96, size.height);
    path.lineTo(size.width * .97, size.height * .95);
    path.lineTo(size.width * .98, size.height);
    path.lineTo(size.width * .99, size.height * .95);
    path.lineTo(size.width, size.height);
    //zigzag ends here
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height * .80);
    path.quadraticBezierTo(size.width, 0, size.width * .8, 0);

    path.lineTo(size.width * .1, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
