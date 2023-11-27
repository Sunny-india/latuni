import 'package:flutter/material.dart';
import 'package:latuni/auth/agent_auth/agent_login_page.dart';
import 'package:latuni/main_screens/profile_page.dart';
import 'package:latuni/my_widgets/auth_widgets.dart';
import 'package:latuni/my_widgets/my_button.dart';
import 'package:latuni/my_widgets/my_snackbar.dart';

class UploadProductPage extends StatefulWidget {
  const UploadProductPage({super.key});
  static String pageName = '/upload_product_page';
  @override
  State<UploadProductPage> createState() => _UploadProductPageState();
}

class _UploadProductPageState extends State<UploadProductPage> {
  /// All GlobalKey things
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  /// All FocusNode things
  FocusNode priceNode = FocusNode();
  FocusNode quantityNode = FocusNode();
  FocusNode discountNode = FocusNode();
  FocusNode nameNode = FocusNode();
  FocusNode descriptionNode = FocusNode();
  //
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            reverse: true,
            child: Form(
              key: _formKey,
              child: Column(
                //  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Container for showing stored images in list
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: size.height * .01, left: size.width * .01),
                        height: size.height * .4,
                        width: size.width * .55,
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(14)),
                        alignment: Alignment.center,
                        child: const RotatedBox(
                          quarterTurns: 3,
                          child: Text(
                            'You\'ve not picked any image yet',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const RedDotRow(),
                  const SizedBox(height: 12),

                  /// upload images button, and Price TFF
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * .05,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// button to upload images
                        MyButton(
                          mHeight: size.height * .1,
                          title: const Text('Upload Photos'),
                          onTapped: () {},
                        ),

                        /// price TFF
                        buildContainerForTFF(
                            mWidth: size.width * .42,
                            myChild: TextFormField(
                              focusNode: priceNode,
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(quantityNode);
                              },
                              keyboardType: TextInputType.number,
                              decoration: buildInputDecoration().copyWith(
                                label: const Text('Price'),
                              ),

                              // price validator
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter price';
                                } else if (value.isValidPrice() != true) {
                                  MyMessageHandler.showMySnackBar(
                                      scaffoldKey: _scaffoldKey,
                                      message: 'Price is not valid');
                                } else {
                                  return null;
                                }
                              },
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  /// TFF for  quantity and discount in this Row
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * .05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// TFF for quantity
                        buildContainerForTFF(
                          mWidth: size.width * .42,
                          myChild: TextFormField(
                            focusNode: quantityNode,
                            onFieldSubmitted: (value) {
                              FocusScope.of(context).requestFocus(discountNode);
                            },
                            keyboardType: TextInputType.number,
                            decoration: buildInputDecoration().copyWith(
                              label: const Text('Quantity'),
                            ),

                            // Quantity validator
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter quantity';
                              } else if (value.isValidQuantity() != true) {
                                MyMessageHandler.showMySnackBar(
                                    scaffoldKey: _scaffoldKey,
                                    message: 'Quantity is not valid');
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),

                        /// TFF for Discount

                        buildContainerForTFF(
                          mWidth: size.width * .42,
                          myChild: TextFormField(
                              focusNode: discountNode,
                              onFieldSubmitted: (value) {
                                FocusScope.of(context).requestFocus(nameNode);
                              },
                              keyboardType: TextInputType.number,
                              decoration: buildInputDecoration()
                                  .copyWith(label: const Text('Discount')),
                              // discount validator
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter discount';
                                } else {
                                  return null;
                                }
                              }),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  /// TFF for Product Name
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * .05),
                    child: buildContainerForTFF(
                      myChild: TextFormField(
                        focusNode: nameNode,
                        onEditingComplete: () {
                          FocusScope.of(context).requestFocus(descriptionNode);
                        },
                        maxLength: 70,
                        maxLines: 2,
                        decoration: buildInputDecoration().copyWith(
                          label: const Text('Product Name'),
                          counterText: '',
                        ),

                        // name validator
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter name';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  /// TFF for Product Description
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * .05),
                    child: buildContainerForTFF(
                      myChild: TextFormField(
                          focusNode: descriptionNode,
                          onEditingComplete: () {
                            FocusScope.of(context).unfocus();
                          },
                          maxLength: 400,
                          maxLines: 5,
                          decoration: buildInputDecoration().copyWith(
                              label: const Text('Describe this product'),
                              counterText: ''),
                          // Description validator
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Description';
                            } else {
                              return null;
                            }
                          }),
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// button for uploading products
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * .05),
                    child: MyButton(
                        mWidth: size.width,
                        mHeight: size.height * .07,
                        title: const Text(
                          'Upload Products',
                          style: TextStyle(letterSpacing: 3, fontSize: 25),
                        ),
                        onTapped: () {
                          if (_formKey.currentState!.validate()) {
                            print('valid');
                          } else {
                            MyMessageHandler.showMySnackBar(
                                scaffoldKey: _scaffoldKey,
                                message: 'Please fill-in all the fields above');
                          }
                        }),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// applied at line  no 134 or so
extension QuantityValidator on String {
  bool isValidQuantity() {
    return RegExp(r'^[1-9][0-9]*$').hasMatch(this);
  }
}

/// applied at line no
extension PriceValidator on String {
  bool isValidPrice() {
    return RegExp(r'^((([1-9][0-9]*[\.])||([0]*[\.]))([0-9]{1,2}))$')
        .hasMatch(this);
  }
}
