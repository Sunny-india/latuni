import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latuni/auth/agent_auth/agent_login_page.dart';
import 'package:latuni/auth/supplier_auth/supplier_login_page.dart';
import 'package:latuni/my_widgets/my_button.dart';
import 'dart:io'; // for handling files
//import '../../firebase_auth.dart';
import '../../models/supplier_model.dart';
import '../../my_widgets/auth_widgets.dart';
import '../../my_widgets/my_snackbar.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SupplierRegisterPage extends StatefulWidget {
  const SupplierRegisterPage({super.key});
  static String pageName = '/supplier_register_page';
  @override
  State<SupplierRegisterPage> createState() => _SupplierRegisterPageState();
}

class _SupplierRegisterPageState extends State<SupplierRegisterPage> {
  //
  /// GlobalKey things
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  ///

  /// firebase things
  final _auth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference suppliers =
      FirebaseFirestore.instance.collection('suppliers');

  ///

  /// TextFormField things
  TextEditingController storeNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  /// All String things

  // for storing supplier uid
  late String _sid;

  // for storing images for the purpose of send that to
  // Supplier's profile in Firebase through Model class
  late String storeLogo;

  /// All FocusNodes
  FocusNode focusName = FocusNode();
  FocusNode focusEmail = FocusNode();
  FocusNode focusPhone = FocusNode();
  FocusNode focusPassword = FocusNode();
  FocusNode focusConfirmPassword = FocusNode();
  FocusNode focusCity = FocusNode();

  /// All other instances

  // for picking images from either gallery or camera.
  // Before that we need to make some changes in
  // info.plist file for ios
  final ImagePicker _imagePicker = ImagePicker();

  /// for storing those images in a file format.
  XFile? _imageFile;

  /// for handling the error while picking images
  dynamic _pickedImageError;

  /// All booleans
  bool isPasswordHidden = true;
  bool isProcessing = false;

  /// method to pick image from camera
  void pickImageFromCamera() async {
    try {
      final pickedImage = await _imagePicker.pickImage(
          source: ImageSource.camera,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        _imageFile = pickedImage;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      MyMessageHandler.showMySnackBar(
          scaffoldKey: _scaffoldKey, message: _pickedImageError);
    }
  }

  /// method to pick image from gallery
  void pickImageFromGallery() async {
    try {
      final pickedImage = await _imagePicker.pickImage(
          source: ImageSource.gallery, maxWidth: 300, imageQuality: 95);
      setState(() {
        _imageFile = pickedImage;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      MyMessageHandler.showMySnackBar(
          scaffoldKey: _scaffoldKey, message: _pickedImageError);
    }
  }

  ///
  void cleanController() {
    storeNameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    cityController.clear();
  }

  /// signUp method starts
  signUp() async {
    // checking
    if (_imageFile != null) {
      if (formKey.currentState!.validate()) {
        setState(() {
          isProcessing = true;
        });
        try {
          //in try block first
          await _auth.createUserWithEmailAndPassword(
              email: emailController.text.toString(),
              password: passwordController.text.toString());

          // step 1. create an instance of FirebaseStorage. Main thing is how we save them
          // we create them under the name of their email. as they're unique
          firebase_storage.Reference ref = firebase_storage
              .FirebaseStorage.instance
              .ref('supplierImage/${emailController.text.toString()}.jpg');

          // step 2. Now is the time to save those images we picked from either camera or
          // gallery to those reference
          await ref.putFile(File(_imageFile!.path));

          // step 3. this image file once sent to database, we need to initiate it over
          // there, and have it downloaded here.
          storeLogo = await ref.getDownloadURL();

          setState(() {
            formKey.currentState!
                .reset(); // this single line method is not working, Raunak Bhaiya
          });

          _sid = _auth.currentUser!.uid; // initiated here for usage now

          SupplierModel supplierModel = SupplierModel(
            sid: _sid,
            storeName: storeNameController.text.toString(),
            email: emailController.text.toString(),
            phone: phoneController.text.toString(),
            address: '',
            city: cityController.text.toString(),
            storeLogo: storeLogo,
          );
          MyMessageHandler.showMySnackBar(
              scaffoldKey: _scaffoldKey,
              message: ' User Created. Please Login Now');
          await suppliers.doc(_sid).set(supplierModel.toFirebase());

          // later will redirect to the login page,
          //Navigator.pushReplacementNamed(context, SupplierHomePage.pageName);

          //  the last action in try block
          cleanController();

          Navigator.pushReplacementNamed(context, SupplierLoginPage.pageName);
          setState(() {
            isProcessing = false;
            _imageFile = null;
          });
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
    } else {
      setState(() {
        isProcessing = false;
      });
      MyMessageHandler.showMySnackBar(
          scaffoldKey: _scaffoldKey,
          message: 'Please Provide your store logo first');
    }
  }

  /// signUp method ends

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
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * .07, vertical: size.height * .015),
              //reverse: true,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(height: 30),

                    ///logo
                    //  myLogo(size),

                    /// for showing Supplier image from firebase later
                    CircleAvatar(
                      radius: size.width * .19,
                      backgroundColor: Colors.deepPurpleAccent,
                      backgroundImage: _imageFile == null
                          ? null
                          : FileImage(File(_imageFile!.path)),
                      child: Text(
                        'YOUR\nSTORE LOGO\nHERE',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: _imageFile == null
                                ? Colors.white
                                : Colors.transparent),
                      ),
                    ),
                    const SizedBox(height: 20),

                    /// Row for Camera, Gallery photos taking functions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // photos from camera applied
                        SizedBox(
                          height: size.height * .12,
                          child: FittedBox(
                            child: Column(
                              children: [
                                IconButton(
                                  iconSize: size.width * .1,
                                  onPressed: pickImageFromCamera,
                                  icon: const Icon(
                                    CupertinoIcons.camera,
                                    color: CupertinoColors.destructiveRed,
                                  ),
                                ),
                                const Text('Camera'),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // photos from gallery applied
                        SizedBox(
                          height: size.height * .12,
                          child: FittedBox(
                            child: Column(
                              children: [
                                IconButton(
                                  iconSize: size.width * .1,
                                  onPressed: pickImageFromGallery,
                                  icon: const Icon(
                                    CupertinoIcons.photo_on_rectangle,
                                    color: Colors.deepOrange,
                                  ),
                                ),
                                const Text('Gallery'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

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

                    passwordTFF(),
                    const SizedBox(height: 20),

                    /// confirm password TFF
                    confirmPasswordTFF(),

                    /// password TFF

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
                        Navigator.pushReplacementNamed(
                            context, SupplierLoginPage.pageName);
                      },
                    ),
                    const SizedBox(height: 20),

                    /// after all validations button to register

                    isProcessing
                        ? const CircularProgressIndicator()
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
        //  autofocus: true,
        focusNode: focusName,
        controller: storeNameController,
        decoration:
            buildInputDecoration().copyWith(hintText: 'Enter your name'),
        validator: (value) {
          //todo: how to call validatorMethod (which works the same)
          //todo: from SupplierRegisterPage() here
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
          //todo: from SupplierRegisterPage() here
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

  Container passwordTFF() {
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
          //todo: from SupplierRegisterPage() here
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
          //todo: from SupplierRegisterPage() here
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
          //todo: from SupplierRegisterPage() here
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
