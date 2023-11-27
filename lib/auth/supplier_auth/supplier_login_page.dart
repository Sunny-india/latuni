import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:latuni/auth/supplier_auth/supplier_register_page.dart';
import 'package:latuni/my_widgets/my_button.dart';
import 'package:latuni/my_widgets/my_snackbar.dart';

import '../agent_auth/agent_login_page.dart';
import '../../main_screens/supplier_home_page.dart';
import '../../my_widgets/auth_widgets.dart';

class SupplierLoginPage extends StatefulWidget {
  const SupplierLoginPage({super.key});
  static String pageName = '/supplier_login_page';
  @override
  State<SupplierLoginPage> createState() => _SupplierLoginPageState();
}

class _SupplierLoginPageState extends State<SupplierLoginPage> {
  /// GlobalKey things
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// all TFF things
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  ///

  /// FocusNode things
  FocusNode focusEmail = FocusNode();
  FocusNode focusPassword = FocusNode();

  ///

  /// All boolean things
  bool isPasswordHidden = true;
  bool isProcessing = false;

  /// All Firebase things
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ///
  void takeMeToSupplierHomePage() {
    Navigator.pushReplacementNamed(context, SupplierHomePage.pageName);
  }

  ///
  void logIn() async {
    setState(() {
      FocusScope.of(context).unfocus();
    });

    if (_formKey.currentState!.validate()) {
      setState(() {
        isProcessing = true;
      });
      try {
        await _auth.signInWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString());

        if (_auth.currentUser != null) {
          MyMessageHandler.showMySnackBar(
              scaffoldKey: _scaffoldKey, message: 'Login Successfully');

          takeMeToSupplierHomePage();
          setState(() {
            _formKey.currentState!.reset();
            isProcessing = false;
          });
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
          setState(() {
            isProcessing = false;
          });
          MyMessageHandler.showMySnackBar(
              scaffoldKey: _scaffoldKey,
              message: 'Either email or password does not match');
        } else if (e.code == 'user-disabled') {
          setState(() {
            isProcessing = false;
          });
          MyMessageHandler.showMySnackBar(
              scaffoldKey: _scaffoldKey,
              message: 'Account Suspended. Please contact administration');
        } else if (e.code == 'user-not-found') {
          setState(() {
            isProcessing = false;
          });
          MyMessageHandler.showMySnackBar(
              scaffoldKey: _scaffoldKey, message: 'User Not Found');
        }
      }
    } else {
      setState(() {
        isProcessing = false;
      });
      MyMessageHandler.showMySnackBar(
          scaffoldKey: _scaffoldKey, message: 'Please fill-in all the fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return WillPopScope(
      onWillPop: () async {
        MyMessageHandler.showMySnackBar(
            scaffoldKey: _scaffoldKey, message: 'No Return');
        return false;
      },
      child: ScaffoldMessenger(
        key: _scaffoldKey,
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              reverse: true,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * .07, vertical: size.height * .015),
                alignment: Alignment.center,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),

                      ///logo
                      SizedBox(
                        height: size.height * .15,
                        child: Image.asset(
                          'assets/images/logos/rose.png',
                          fit: BoxFit.cover,
                        ),
                      ),

                      /// sign up text
                      const AuthHeaderLabel(labelText: 'Welcome'),
                      const SizedBox(height: 40),

                      ///email TFF
                      buildContainerForTFF(
                        myChild: TextFormField(
                          autofocus: true,
                          focusNode: focusEmail,
                          controller: emailController,
                          decoration: buildInputDecoration()
                              .copyWith(hintText: 'Enter your email'),
                          validator: (value) {
                            //todo: how to call validatorMethod (which works the same)
                            //todo: from SupplierRegisterPage() here
                            if (value!.isEmpty || value == '') {
                              return 'Please Enter email';
                            } else if (value.isValidEmail() == false) {
                              return '    enter valid email only';
                            } else if (value.isValidEmail() == true) {
                              return null;
                            } else {
                              return null;
                            }
                          },
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(focusPassword);
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                      const SizedBox(height: 20),

                      /// password TFF
                      buildContainerForTFF(
                        myChild: TextFormField(
                          focusNode: focusPassword,
                          controller: passwordController,
                          obscureText: isPasswordHidden,
                          decoration: buildInputDecoration().copyWith(
                            hintText: 'Enter password',
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isPasswordHidden = !isPasswordHidden;
                                });
                              },
                              icon: Icon(isPasswordHidden
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.lock),
                            ),
                          ),
                          validator: (value) {
                            //todo: how to call validatorMethod (which works the same)
                            //todo: from SupplierRegisterPage() here
                            if (value!.isEmpty || value == '') {
                              return 'Please Enter password';
                            } else if (value.length < 6) {
                              return 'Please enter at least 6 digits';
                            } else {
                              return null;
                            }
                          },
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).unfocus();
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                      const SizedBox(height: 10),

                      ///  have an account or not
                      HaveAccountOrNot(
                        account: 'Don\'t Have an Account?',
                        buttonLabel: 'Register',
                        onPressed: () {
                          // todo: later to be sent to login page
                          Navigator.pushReplacementNamed(
                              context, SupplierRegisterPage.pageName);
                        },
                      ),
                      const SizedBox(height: 40),
                      isProcessing
                          ? const CircularProgressIndicator()
                          : MyButton(
                              mWidth: double.infinity,
                              mHeight: size.height * .08,
                              title: Text(
                                'L O G I N',
                                style: TextStyle(
                                  fontFamily: 'Playpen',
                                  fontSize: size.width * .07,
                                  letterSpacing: 5,
                                ),
                              ),
                              onTapped: () async {
                                logIn();
                              }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
