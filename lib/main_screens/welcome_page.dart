import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:latuni/main_screens/customer_home_page.dart';
import 'package:latuni/main_screens/supplier_home_page.dart';

import '../my_widgets/my_button.dart';
import '../utilities/clippers.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});
  static String pageName = '/welcome_page';
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final Color backgroundColor = Colors.grey.shade300;
  late List<Map<String, dynamic>> socialMediaList;
  @override
  void initState() {
    socialMediaList = [
      {
        'image': 'assets/images/logos/fb.png',
        'label': 'FaceBook',
        'onPressed': faceBookLogin
      },
      {
        'image': 'assets/images/logos/google.png',
        'label': 'Google',
        'onPressed': googleLogin
      },
      {
        'image': 'assets/images/logos/person.png',
        'label': 'Anon',
        'onPressed': anonymousLogin
      },
    ];

    super.initState();
  }

  void faceBookLogin() {
    print('FaceBook');
  }

  void googleLogin() {
    print('Google');
  }

  void anonymousLogin() {
    print('Anonymous Login');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 20,
                  left: size.width * .04,
                  right: size.width * .04,
                ),
                child: Column(
                  children: [
                    /// WELCOME text
                    ClipPath(
                      clipper: ParchiBottom(),
                      child: welcomeTextContainer(size),
                    ),
                    const SizedBox(height: 20),

                    /// Suppliers login/signup
                    // Container(
                    //   padding: const EdgeInsets.symmetric(horizontal: 6),
                    //   height: size.height * .1,
                    //   width: size.width * .9,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(21),
                    //       color: Colors.orange),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     children: [
                    //       const Text('S U P P L I E R S'),
                    //       const SizedBox(width: 10),
                    //       MyButton(
                    //           mWidth: size.width * .2,
                    //           title: const Text('LOGIN'),
                    //           onTapped: () {}),
                    //       const SizedBox(width: 10),
                    //       MyButton(
                    //           mWidth: size.width * .2,
                    //           title: const Text('SIGN UP'),
                    //           onTapped: () {}),
                    //     ],
                    //   ),
                    // ),
                    //
                    // const SizedBox(height: 20),
                    //
                    // /// customers login/signup
                    //
                    // Container(
                    //   padding: const EdgeInsets.symmetric(horizontal: 6),
                    //   height: size.height * .1,
                    //   width: size.width * .9,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(21),
                    //       color: Colors.orange),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     children: [
                    //       const RotatedBox(
                    //           quarterTurns: 2,
                    //           child: Text('C U S T O M E R S')),
                    //       const SizedBox(width: 10),
                    //       MyButton(
                    //           mWidth: size.width * .2,
                    //           title: const Text('LOGIN'),
                    //           onTapped: () {}),
                    //       const SizedBox(width: 10),
                    //       MyButton(
                    //           mWidth: size.width * .2,
                    //           title: const Text('SIGN UP'),
                    //           onTapped: () {}),
                    //     ],
                    //   ),
                    // ),

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
              SizedBox(
                height: size.height * .04,
              ),

              /// bottom Row for social sign-ins
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(socialMediaList.length, (index) {
                      return BottomSocialWidgets(
                          onPressed: socialMediaList[index]['onPressed'],
                          image: socialMediaList[index]['image'],
                          label: socialMediaList[index]['label']);
                    })),
              ),
            ],
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

class LeftSupplierContainer extends StatelessWidget {
  const LeftSupplierContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      decoration: const BoxDecoration(
        color: Colors.deepPurple,
      ),
      child: FittedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 12),
            const RotatedBox(
              quarterTurns: 3,
              child: Text(
                'S U P P L I E R S',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            MyButton(
                mWidth: size.width * .35,
                title: const Text('Login'),
                onTapped: () {
                  //todo:for supplier login
                  Navigator.pushReplacementNamed(
                      context, SupplierHomePage.pageName);
                }),
            const SizedBox(height: 20),
            MyButton(
                mWidth: size.width * .35,
                title: const Text('Sign Up'),
                onTapped: () {
                  //todo: Sign Up later
                }),
            const SizedBox(height: 10),
          ],
        ),
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
        color: Colors.deepPurple,
      ),
      child: FittedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 10),
            const RotatedBox(
              quarterTurns: 3,
              child: Text(
                'C U S T O M E R S',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            MyButton(
                mWidth: size.width * .35,
                title: const Text('Login'),
                onTapped: () {
                  //todo:for customers login later
                  Navigator.pushReplacementNamed(
                      context, CustomerHomePage.pageName);
                }),
            const SizedBox(
              height: 20,
            ),
            MyButton(
                mWidth: size.width * .35,
                title: const Text('Sign Up'),
                onTapped: () {
                  //todo: Sign Up later
                }),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class BottomSocialWidgets extends StatelessWidget {
  const BottomSocialWidgets(
      {super.key,
      required this.image,
      required this.label,
      required this.onPressed});
  final String image;
  final String label;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        width: 70,
        height: 90,
        //  decoration: const BoxDecoration(color: Colors.deepPurple),
        child: FittedBox(
          child: Column(
            children: [
              Image.asset(
                image,
                height: 60,
              ),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}
