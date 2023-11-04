import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

import '../my_widgets/my_button.dart';
import '../utilities/clippers.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final Color backgroundColor = Colors.grey.shade300;

  // bool doItClicked = false;
  // bool signUpClicked = false;
  // void doItTapped() {
  //   setState(() {
  //     doItClicked = !doItClicked;
  //     signUpClicked = false;
  //   });
  // }
  //
  // void signUpTapped() {
  //   setState(() {
  //     signUpClicked = !signUpClicked;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: size.width * .04,
            right: size.width * .04,
          ),
          child: SingleChildScrollView(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: size.height * .08,
                ),

                /// WELCOME text
                ClipPath(
                  clipper: ParchiBottom(),
                  child: welcomeTextContainer(size),
                ),
                const SizedBox(height: 20),

                /// Suppliers login/signup
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  height: size.height * .1,
                  width: size.width * .9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(21),
                      color: Colors.orange),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('S U P P L I E R S'),
                      const SizedBox(width: 10),
                      MyButton(
                          mWidth: size.width * .2,
                          title: const Text('LOGIN'),
                          onTapped: () {}),
                      const SizedBox(width: 10),
                      MyButton(
                          mWidth: size.width * .2,
                          title: const Text('SIGN UP'),
                          onTapped: () {}),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// customers login/signup

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  height: size.height * .1,
                  width: size.width * .9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(21),
                      color: Colors.orange),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const RotatedBox(
                          quarterTurns: 2, child: Text('C U S T O M E R S')),
                      const SizedBox(width: 10),
                      MyButton(
                          mWidth: size.width * .2,
                          title: const Text('LOGIN'),
                          onTapped: () {}),
                      const SizedBox(width: 10),
                      MyButton(
                          mWidth: size.width * .2,
                          title: const Text('SIGN UP'),
                          onTapped: () {}),
                    ],
                  ),
                ),

                /// alternate design
                const SizedBox(height: 10),
                SizedBox(
                  height: size.height * .35,
                  width: size.width * .9,
                  child: Row(
                    children: [
                      Expanded(
                        child: ClipPath(
                          clipper: RightClipper(),
                          child: const LeftSupplierContainer(),
                        ),
                      ),
                      Expanded(
                        child: ClipPath(
                          clipper: LeftClipper(),
                          child: const RightCustomerContainer(),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
        // bottom: true,
      ),
    );
  }

  Container welcomeTextContainer(Size size) {
    return Container(
      alignment: Alignment.center,
      height: 200,
      width: size.width * .9,
      decoration: BoxDecoration(
        color: Colors.orange.shade600,
      ),
      child: const Text(
        'W E L C O M E',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 30),
      ),
    );
  }
}

class RightCustomerContainer extends StatelessWidget {
  const RightCustomerContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      decoration: const BoxDecoration(
        color: Colors.tealAccent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 10),
          const RotatedBox(
            quarterTurns: 3,
            child: Text(
              'C U S T O M E R S',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          MyButton(
              mWidth: size.width * .35,
              title: const Text('Login'),
              onTapped: () {
                //todo: login later
              }),
          const SizedBox(
            height: 10,
          ),
          MyButton(
              mWidth: size.width * .35,
              title: const Text('Sign Up'),
              onTapped: () {
                //todo: Sign Up later
              }),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class LeftSupplierContainer extends StatelessWidget {
  const LeftSupplierContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      decoration: const BoxDecoration(
        color: Colors.red,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 12),
          const RotatedBox(
            quarterTurns: 3,
            child: Text(
              'S U P P L I E R S',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          MyButton(
              mWidth: size.width * .35,
              title: const Text('Login'),
              onTapped: () {
                //todo: login later
              }),
          const SizedBox(
            height: 10,
          ),
          MyButton(
              mWidth: size.width * .35,
              title: const Text('Sign Up'),
              onTapped: () {
                //todo: Sign Up later
              }),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
