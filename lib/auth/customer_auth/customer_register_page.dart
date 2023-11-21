import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:latuni/agent_screens/agent_login_page.dart';
import 'package:latuni/auth/customer_auth/customer_login_page.dart';
import 'package:latuni/my_widgets/my_button.dart';

//import '../../firebase_auth.dart';
import '../../models/customer_model.dart';
import '../../my_widgets/auth_widgets.dart';
import '../../my_widgets/my_snackbar.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class CustomerRegisterPage extends StatefulWidget {
  const CustomerRegisterPage({super.key});
  static String pageName = '/customer_register_page';
  @override
  State<CustomerRegisterPage> createState() => _CustomerRegisterPageState();
}

class _CustomerRegisterPageState extends State<CustomerRegisterPage> {
  //
  /// GlobalKey things
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  ///

  /// firebase things
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');

  ///

  /// TextFormField things
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  ///
  late String _uid; // for storing customer uid

  /// All FocusNodes
  FocusNode focusName = FocusNode();
  FocusNode focusEmail = FocusNode();
  FocusNode focusPhone = FocusNode();
  FocusNode focusPassword = FocusNode();
  FocusNode focusConfirmPassword = FocusNode();
  FocusNode focusCity = FocusNode();

  ///
//
  /// All booleans
  bool isPasswordHidden = true;
  bool isProcessing = false;

  ///
  void cleanController() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    cityController.clear();
  }

  /// signUp method starts
  signUp() async {
    // checking
    if (formKey.currentState!.validate()) {
      setState(() {
        isProcessing = true;
      });
      try {
        //in try block first
        await firebaseAuth.createUserWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString());

        setState(() {
          formKey.currentState!
              .reset(); // this single line method is not working, Raunak Bhaiya
        });
        /*
        // for storing images named on their email. When the app requires to save
        // images by the user.

      // step 1. create a reference for firebase_storage
        final firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref('customerImages/${email}.jpg');

         // step 2. in that created path, we send out XFile type file's path
        await ref.putFile(
            File(imageFile.path)); // this imageFile must be of XFile type

        // step 3. from Firebase storage, we need to download that URL
        // and have it saved in an File type variable.
       //File? profileImage= await ref.getDownloadURL();
       */
        _uid = firebaseAuth.currentUser!.uid; // initiated here for usage now

        CustomerModel customerModel = CustomerModel(
          cid: _uid,
          name: nameController.text.toString(),
          email: emailController.text.toString(),
          phone: phoneController.text.toString(),
          address: '',
          city: cityController.text.toString(),
        );
        MyMessageHandler.showMySnackBar(
            scaffoldKey: _scaffoldKey,
            message: ' User Created.Taking to login page. Login from there');
        await customers.doc(_uid).set(customerModel.toFirebase());

        // later will redirect to the login page,
        //Navigator.pushReplacementNamed(context, CustomerHomePage.pageName);

        //  the last action in try block
        cleanController();
        setState(() {
          isProcessing = false;
        });
        Navigator.pushReplacementNamed(context, CustomerLoginPage.pageName);
        // try block ends here
      } on FirebaseAuthException catch (e) {
        // in catch block, multiple if
        if (e.code == 'weak-password') {
          setState(() {
            isProcessing = false;
          });
          MyMessageHandler.showMySnackBar(
              scaffoldKey: _scaffoldKey,
              message: 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          setState(() {
            isProcessing = false;
          });
          MyMessageHandler.showMySnackBar(
              scaffoldKey: _scaffoldKey,
              message: 'Email already in use. so Login');
        }
      }
    } else {
      setState(() {
        isProcessing = false;
      });
      //when either TFF is not validated
      MyMessageHandler.showMySnackBar(
          scaffoldKey: _scaffoldKey,
          message: 'Please fill all the fields above');
    }
  }

  /// signUp method ends
  @override
  // void dispose() {
  //   FocusScope.of(context).unfocus();
  //   // TODO: implement dispose
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return WillPopScope(
      onWillPop: () async {
        MyMessageHandler.showMySnackBar(
            scaffoldKey: _scaffoldKey,
            message: ' Please press Home icon to leave');
        return false;
      },
      child: ScaffoldMessenger(
        key: _scaffoldKey,
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              //reverse: true,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * .07, vertical: size.height * .015),
                alignment: Alignment.center,
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 10),

                      ///logo
                      myLogo(size),

                      /// sign up text
                      const AuthHeaderLabel(labelText: 'S I G N U P'),
                      const SizedBox(height: 40),

                      /// name TFF
                      nameTFF(),
                      const SizedBox(height: 20),

                      /// email TFF
                      emailTFF(),
                      const SizedBox(height: 20),

                      /// phone TFF
                      phoneTFF(),
                      const SizedBox(height: 20),

                      /// password TFF
                      passwordTFF(size),
                      const SizedBox(height: 20),

                      /// confirm password TFF
                      confirmPasswordTFF(),
                      const SizedBox(height: 20),

                      /// address TFF
                      //   addressTFF(), // will have it called later.
                      // const SizedBox(height: 20),

                      /// city TFF
                      cityTFF(),
                      const SizedBox(height: 10),

                      ///  have an account or not
                      HaveAccountOrNot(
                        account: 'Already Have an Account?',
                        buttonLabel: 'Login',
                        onPressed: () {
                          // todo: later to be sent to login page
                          Navigator.pushReplacementNamed(
                              context, CustomerLoginPage.pageName);
                        },
                      ),
                      const SizedBox(height: 20),

                      /// after all validations button to register

                      isProcessing
                          ? CircularProgressIndicator()
                          : MyButton(
                              mWidth: double.infinity,
                              mHeight: size.height * .08,
                              title: Text(
                                'R E G I S T E R',
                                style: TextStyle(
                                  fontFamily: 'Playpen',
                                  fontSize: size.width * .07,
                                  letterSpacing: 5,
                                ),
                              ),
                              onTapped: () async {
                                FocusScope.of(context).unfocus(); // not working
                                signUp();
                              }),
                      const SizedBox(height: 20),
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

  SizedBox myLogo(Size size) {
    return SizedBox(
      height: size.height * .15,
      child: Image.asset(
        'assets/images/logos/rose.png',
        fit: BoxFit.cover,
      ),
    );
  }

  Container nameTFF() {
    return buildContainerForTFF(
      myChild: TextFormField(
        autofocus: true,
        focusNode: focusName,
        controller: nameController,
        decoration:
            buildInputDecoration().copyWith(hintText: 'Enter your name'),
        validator: (value) {
          //todo: how to call validatorMethod (which works the same)
          //todo: from CustomerRegisterPage() here
          if (value!.isEmpty) {
            return 'Please Enter name';
          } else if (value.isValidName() == false) {
            return '    enter valid name only';
          } else if (value.isValidName() == true) {
            return null;
          } else {
            return null;
          }
        },
        onFieldSubmitted: (value) {
          FocusScope.of(context).requestFocus(focusEmail);
        },

        //onChanged: Focus.of(context).requestFocus(focusEmail),
        //onTapOutside: (){},
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }

  Container emailTFF() {
    return buildContainerForTFF(
      myChild: TextFormField(
        focusNode: focusEmail,
        controller: emailController,
        decoration:
            buildInputDecoration().copyWith(hintText: 'Enter your email'),
        validator: (value) {
          //todo: how to call validatorMethod (which works the same)
          //todo: from CustomerRegisterPage() here
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
          FocusScope.of(context).requestFocus(focusPhone);
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }

  Container phoneTFF() {
    return buildContainerForTFF(
      myChild: TextFormField(
        controller: phoneController,
        focusNode: focusPhone,
        keyboardType: TextInputType.number,
        decoration:
            buildInputDecoration().copyWith(hintText: 'Enter your phone'),
        validator: (value) {
          //todo: how to call validatorMethod (which works the same)
          //todo: from CustomerRegisterPage() here
          if (value!.isEmpty || value == '') {
            return 'Please Enter phone';
          } else if (value.isValidPhone() == false) {
            return '    enter valid phone only';
          } else if (value.isValidPhone() == true) {
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
    );
  }

  Container passwordTFF(Size size) {
    return buildContainerForTFF(
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
            icon: Icon(
                isPasswordHidden ? Icons.remove_red_eye_outlined : Icons.lock),
          ),
        ),
        validator: (value) {
          //todo: how to call validatorMethod (which works the same)
          //todo: from CustomerRegisterPage() here
          if (value!.isEmpty || value == '') {
            return 'Please Enter password';
          } else if (value.length < 6) {
            return 'Please enter at least 6 digits';
          } else {
            return null;
          }
        },
        onFieldSubmitted: (value) {
          FocusScope.of(context).requestFocus(focusConfirmPassword);
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }

  Container confirmPasswordTFF() {
    return buildContainerForTFF(
      myChild: TextFormField(
        focusNode: focusConfirmPassword,
        controller: confirmPasswordController,
        obscureText: isPasswordHidden,
        decoration: buildInputDecoration().copyWith(
          hintText: 'repeat your password',
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                isPasswordHidden = !isPasswordHidden;
              });
            },
            icon: Icon(
                isPasswordHidden ? Icons.remove_red_eye_outlined : Icons.lock),
          ),
        ),
        validator: (value) {
          //todo: how to call validatorMethod (which works the same)
          //todo: from CustomerRegisterPage() here
          if (value!.isEmpty || value == '') {
            return '  Please re-Enter password';
          } else if (value != passwordController.text) {
            return '  password does not match';
          } else {
            return null;
          }
        },
        onFieldSubmitted: (value) {
          FocusScope.of(context).requestFocus(focusCity);
          setState(() {
            isPasswordHidden = true;
          });
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }

//
  Container addressTFF() {
    return buildContainerForTFF(
      myChild: TextFormField(
        focusNode: focusCity,
        controller: addressController,
        decoration:
            buildInputDecoration().copyWith(hintText: 'Your address here'),
        validator: (value) {
          //todo: how to call validatorMethod (which works the same)
          //todo: from CustomerRegisterPage() here
          if (value!.isEmpty || value == '') {
            return '  Right Address means precise delivery';
          }
          // else if (value.isValidName() == false) {
          //   return '    enter valid name only';
          // } else if (value.isValidName() == true) {
          //   return null;
          // }
          else {
            return null;
          }
        },
        onFieldSubmitted: (value) {
          FocusScope.of(context).unfocus();
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
  //

  Container cityTFF() {
    return buildContainerForTFF(
      myChild: TextFormField(
        focusNode: focusCity,
        controller: cityController,
        decoration:
            buildInputDecoration().copyWith(hintText: 'Enter your city'),
        validator: (value) {
          //todo: how to call validatorMethod (which works the same)
          //todo: from CustomerRegisterPage() here
          if (value!.isEmpty || value == '') {
            return 'Please Enter city name did somechanges';
          } else if (value.isValidName() == false) {
            return '    enter valid name only';
          } else if (value.isValidName() == true) {
            return null;
          } else {
            return null;
          }
        },
        onFieldSubmitted: (value) {
          FocusScope.of(context).unfocus();
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}
