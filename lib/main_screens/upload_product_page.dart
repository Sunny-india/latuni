import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latuni/auth/agent_auth/agent_login_page.dart';
import 'package:latuni/main_screens/profile_page.dart';
import 'package:latuni/my_widgets/auth_widgets.dart';
import 'package:latuni/my_widgets/my_button.dart';
import 'package:latuni/my_widgets/my_snackbar.dart';
import 'dart:io';

import 'package:latuni/utilities/category_list.dart';

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

  /// All variables for storing data. Will save data with onSaved method in TFF
  double? price;
  double? quantity;
  double? discount;
  String? productName, productDescription;

  ///
  String mainCategoryValue = 'kisan';
  String subCategoryValue = 'sutli';
  List<String> subCategoryList = [];

  ///
  final ImagePicker _imagePicker = ImagePicker();
  List<XFile>? imageFiles = [];

  /// uploadPhotos method
  void uploadPhotos() async {
    var pickedImages = await _imagePicker.pickMultiImage(
        maxWidth: 300, maxHeight: 300, imageQuality: 95);
    setState(() {
      imageFiles = pickedImages;
    });
  }

  /// previewing images in that container method
  Widget previewImagesInContainer() {
    if (imageFiles!.isNotEmpty) {
      return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: imageFiles!.length,
          itemBuilder: (context, index) {
            return Image.file(
              File(imageFiles![index].path),
            );
          });
    } else {
      return const Center(
        child: Text(
          'You\'ve not picked \nany image yet',
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  /// how to select categories and sub-categories
  void selectCategory(String newValue) {
    if (newValue == 'kisan') {
      setState(() {
        subCategoryValue = 'sutli';
        subCategoryList = kisan;
      });
    } else if (newValue == 'kirana') {
      setState(() {
        subCategoryValue = 'PolyBags';
        subCategoryList = kirana;
      });
    } else if (newValue == 'dairy') {
      setState(() {
        subCategoryList = dairy;
        subCategoryValue = 'rubber bands';
      });
    } else if (newValue == 'clothing') {
      setState(() {
        subCategoryList = clothing;
        subCategoryValue = 'Jumbo';
      });
    }
  }

  /// upload Product thing
  void uploadProduct() {
    if (imageFiles!.isNotEmpty) {
      if (subCategoryList.isNotEmpty) {
        if (_formKey.currentState!.validate()) {
          // works synchronously with onSaved methods in TFF
          _formKey.currentState!.save();

          _formKey.currentState!.reset();
          setState(() {
            imageFiles = [];
          });
          // print(mainCategoryValue);
          // print(subCategoryValue);
        } else {
          MyMessageHandler.showMySnackBar(
              scaffoldKey: _scaffoldKey,
              message: 'Please fill-in all the fields above');
        }
      } else {
        MyMessageHandler.showMySnackBar(
            scaffoldKey: _scaffoldKey,
            message: 'Please choose category for the selected image/s');
      }
    } else {
      MyMessageHandler.showMySnackBar(
          scaffoldKey: _scaffoldKey, message: 'Please pick images first');
    }
  }

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
                children: [
                  /// Container for showing stored images in list
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      /// first container to show all the picked images in stack
                      Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                top: size.height * .01, left: size.width * .01),
                            height: size.height * .4,
                            width: size.width * .5,
                            color: Colors.redAccent,
                            child: previewImagesInContainer(),
                          ),
                          imageFiles!.isEmpty
                              ? const SizedBox()
                              : IconButton(
                                  onPressed: () {
                                    setState(() {
                                      imageFiles = [];
                                    });
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                        ],
                      ),

                      /// the second container to pick categories and sub-categories
                      Container(
                        margin: EdgeInsets.only(top: size.height * .01),
                        height: size.height * .4,
                        width: size.width * .45,
                        color: Colors.tealAccent,
                        // alignment: Alignment.center,
                        child: Column(
                          children: [
                            /// first sub-container
                            Expanded(
                              child: Container(
                                width: size.width * .45,
                                color: Colors.purpleAccent,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text('Choose Category'),
                                    FittedBox(
                                      child: DropdownButton(
                                          padding: EdgeInsets.zero,
                                          iconSize: 40,
                                          //isExpanded: true,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          alignment: Alignment.bottomRight,
                                          menuMaxHeight: size.height * .4,
                                          dropdownColor:
                                              Colors.purpleAccent.shade100,
                                          isDense: true,
                                          iconEnabledColor: Colors.lime,

                                          // below three are all required
                                          value: mainCategoryValue,
                                          items: mainCategoryList
                                              .map<DropdownMenuItem<String>>(
                                                  (e) {
                                            return DropdownMenuItem(
                                              value: e,
                                              child: Text(e),
                                            );
                                          }).toList(),
                                          onChanged: (newValue) {
                                            selectCategory(newValue!);
                                            setState(() {
                                              mainCategoryValue = newValue;
                                            });
                                          }),
                                    )
                                  ],
                                ),
                              ),
                            ),

                            /// second sub-container
                            Expanded(
                              child: Container(
                                width: size.width * .45,
                                color: Colors.lime,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text('SubCategory'),
                                    FittedBox(
                                      child: DropdownButton(
                                          padding: EdgeInsets.zero,
                                          iconSize: 40,
                                          //isExpanded: true,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          alignment: Alignment.bottomRight,
                                          menuMaxHeight: size.height * .4,
                                          dropdownColor: Colors.lime.shade100,
                                          isDense: true,
                                          iconEnabledColor: Colors.deepPurple,
                                          // below are all three required
                                          value: subCategoryValue,
                                          items: subCategoryList
                                              .map<DropdownMenuItem<String>>(
                                                  (e) {
                                            return DropdownMenuItem(
                                              value: e,
                                              child: Text(e),
                                            );
                                          }).toList(),
                                          onChanged: (newValue) {
                                            setState(() {
                                              subCategoryValue = newValue!;
                                            });
                                          }),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
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
                          onTapped: () {
                            uploadPhotos();
                          },
                        ),

                        /// price TFF
                        buildContainerForTFF(
                          mWidth: size.width * .42,
                          myChild: TextFormField(
                            focusNode: priceNode,
                            onFieldSubmitted: (value) {
                              FocusScope.of(context).requestFocus(quantityNode);
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
                                return 'Not valid price-format';
                              } else {
                                return null;
                              }
                            },
                            // save price into variable
                            onSaved: (value) {
                              setState(() {
                                price = double.parse(value!);
                              });
                            },
                          ),
                        ),
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
                                return 'Not a valid format';
                              } else {
                                return null;
                              }
                            },
                            // save quantity into variable
                            onSaved: (value) {
                              setState(() {
                                quantity = double.parse(value!);
                              });
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
                            },
                            // save discount into variable
                            onSaved: (value) {
                              setState(() {
                                discount = double.parse(value!);
                              });
                            },
                          ),
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
                        // save product name into variable
                        onSaved: (value) {
                          setState(() {
                            productName = value;
                          });
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
                        },
                        // save product description into variable
                        onSaved: (value) {
                          setState(() {
                            productDescription = value;
                          });
                        },
                      ),
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
                        uploadProduct();
                      },
                    ),
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

/// extension for quantity validation
extension QuantityValidator on String {
  bool isValidQuantity() {
    return RegExp(r'^[1-9][0-9]*$').hasMatch(this);
  }
}

/// extension for price validation
extension PriceValidator on String {
  bool isValidPrice() {
    return RegExp(r'^(([1-9][0-9]*[\.]*)||([0]*[\.]*)([0-9]{1,2}))$')
        .hasMatch(this);
    // RegExp(r'^(([1-9][0-9]*[.][0-9]{1,2})||(0*[.][0-9]{1,2}))$')
    //   .hasMatch(this);
  }
}
