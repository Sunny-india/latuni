import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:latuni/agent_screens/agent_login_page.dart';
import 'package:latuni/auth/customer_auth/customer_register_page.dart';
import 'package:latuni/auth/supplier_auth/supplier_register_page.dart';
import 'package:latuni/main_screens/customer_home_page.dart';
import 'package:latuni/main_screens/supplier_home_page.dart';

import '../auth/customer_auth/customer_login_page.dart';
import '../models/customer_model.dart';
import '../my_widgets/my_button.dart';
import '../utilities/clippers.dart';

BoxDecoration buildBoxDecoration() {
  return BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Colors.deepOrange.shade200,
        Colors.deepOrange.shade400,
        Colors.deepOrange.shade500,
        Colors.deepOrange.shade600,
        Colors.deepOrange.shade800,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: const [.1, .4, .6, .8, 1],
    ),
  );
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  static String pageName = '/welcome_page';

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  ///
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');

  ///
  bool isProcessing = false;
  // bool otherTapped = false;

  final Color backgroundColor = Colors.grey.shade300;
  // late List<Map<String, dynamic>> socialMediaList;

  bool myOtherLogs = false;
  late List<BottomSocialWidgets> socialMediaList;
  @override
  void initState() {
    //  FocusScope.of(context).unfocus();
    socialMediaList = [
      BottomSocialWidgets(
          image: 'assets/images/logos/fb.png',
          label: 'Fb',
          onPressed: faceBookLogin),

      BottomSocialWidgets(
          image: 'assets/images/logos/google.png',
          label: 'Google',
          onPressed: googleLogin),
      BottomSocialWidgets(
          image: 'assets/images/logos/person.png',
          label: 'Guest',
          onPressed: guestLogin),

      ///
      // {
      //   'image': 'assets/images/logos/fb.png',
      //   'label': 'Fb',
      //   'onPressed': myOtherLogs ? () {} : faceBookLogin,
      //   'otherLogs': myOtherLogs,
      // },
      // {
      //   'image': 'assets/images/logos/google.png',
      //   'label': 'Google',
      //   'onPressed': myOtherLogs ? () {} : googleLogin,
      //   'otherLogs': myOtherLogs,
      // },
      // {
      //   'image': 'assets/images/logos/person.png',
      //   'label': 'Guest',
      //   'onPressed': myOtherLogs ? () {} : guestLogin,
      //   'otherLogs': myOtherLogs,
      // },
    ];

    super.initState();
  }

  void faceBookLogin() {
    print('FaceBook');
  }

  void googleLogin() {
    print('Google');
  }

  void guestLogin() async {
    try {
      setState(() {
        isProcessing = true;
      });
      await firebaseAuth.signInAnonymously().whenComplete(() async {
        final userCredential = firebaseAuth.currentUser!.uid;
        CustomerModel guestCustomer = CustomerModel(
            cid: userCredential,
            name: '',
            email: '',
            phone: '',
            city: '',
            address: '');

        await customers.doc(userCredential).set(guestCustomer.toFirebase());
      });
      setState(() {
        isProcessing = false;
      });
      print("Signed in with temporary account.");

      //  print(userCredential.user!.uid);
      Navigator.pushReplacementNamed(context, CustomerHomePage.pageName);
    } on FirebaseAuthException catch (e) {
      //  print(e.code.toString());
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          setState(() {
            isProcessing = false;
          });
          break;
        default:
          print("Unknown error.");
          setState(() {
            isProcessing = false;
          });
      }
    }
    print('Anonymous Login done successfully');
    setState(() {
      isProcessing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: size.width * .05,
                right: size.width * .05,
                top: size.height * .05,
                bottom: 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    /// WELCOME text
                    ClipPath(
                      clipper: ParchiBottom(),
                      child: welcomeTextContainer(size),
                    ),
                    const SizedBox(height: 20),

                    /// Suppliers and customers login / signup
                    SupplierCustomerLoginSignUp(size: size),
                    const SizedBox(height: 50),

                    /// agents login signup
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      height: size.height * .1,
                      // width: size.width * .9,
                      decoration: buildBoxDecoration().copyWith(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(21),
                              bottomRight: Radius.circular(21))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('A G E N T S'),
                          const SizedBox(width: 10),
                          MyButton(
                              mWidth: size.width * .2,
                              title: const Text('LOGIN'),
                              onTapped: () {
                                Navigator.pushNamed(
                                    context, AgentLoginPage.pageName);
                              }),
                          const SizedBox(width: 10),
                          MyButton(
                              mWidth: size.width * .2,
                              title: const Text('SIGN UP'),
                              onTapped: () {}),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * .04),

                /// bottom Row for social sign-ins
                /// not working this way
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BottomSocialWidgets(
                        image: 'assets/images/logos/fb.png',
                        label: 'FB',
                        onPressed: faceBookLogin),
                    BottomSocialWidgets(
                        image: 'assets/images/logos/google.png',
                        label: 'Google',
                        onPressed: googleLogin),
                    isProcessing
                        ? const CircularProgressIndicator(
                            color: Colors.red,
                          )
                        : BottomSocialWidgets(
                            image: 'assets/images/logos/person.png',
                            label: 'Guest',
                            onPressed: guestLogin,
                          ),
                  ],
                  // List.generate(
                  //   socialMediaList.length,
                  //   (index) {
                  //     return BottomSocialWidgets(
                  //         onPressed: isProcessing
                  //             ? () {}
                  //             : socialMediaList[index].onPressed,
                  //         image: socialMediaList[index].image,
                  //         label: socialMediaList[index].label);
                  //   },
                  // ),
                ),

                // Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       BottomSocialWidgets(
                //         onPressed: () {
                //           faceBookLogin();
                //         },
                //         image: 'assets/images/logos/fb.png',
                //         label: 'Fb',
                //       ),
                //       BottomSocialWidgets(
                //         onPressed: googleLogin,
                //         image: 'assets/images/logos/google.png',
                //         label: 'Google',
                //       ),
                //       isProcessing
                //           ? const CircularProgressIndicator(
                //               color: Colors.red,
                //             )
                //           : BottomSocialWidgets(
                //               onPressed: guestLogin,
                //               image: 'assets/images/logos/person.png',
                //               label: 'Guest',
                //             ),
                //     ]),

                ///
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
      height: size.height * .22,
      //width: size.width * .9,
      decoration: buildBoxDecoration(),
      child: const Text(
        'W E L C O M E',
        textAlign: TextAlign.center,
        style:
            TextStyle(fontSize: 30, color: Colors.white, fontFamily: 'Playpen'),
      ),
    );
  }
}

class SupplierCustomerLoginSignUp extends StatelessWidget {
  const SupplierCustomerLoginSignUp({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * .35,
      // width: size.width * .9,
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
      decoration: buildBoxDecoration(),
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
                  Navigator.pushReplacementNamed(
                      context, SupplierRegisterPage.pageName);
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
      decoration: buildBoxDecoration(),
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
                      context, CustomerLoginPage.pageName);
                }),
            const SizedBox(
              height: 20,
            ),
            MyButton(
                mWidth: size.width * .35,
                title: const Text('Sign Up'),
                onTapped: () {
                  //todo: Sign Up later
                  Navigator.pushReplacementNamed(
                      context, CustomerRegisterPage.pageName);
                }),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class BottomSocialWidgets extends StatelessWidget {
  BottomSocialWidgets(
      {super.key,
      required this.image,
      required this.label,
      required this.onPressed,
      this.otherLogs = false});
  final String image;
  final String label;
  final Function() onPressed;
  late bool otherLogs;

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
