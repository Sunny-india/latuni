import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latuni/main_screens/cart_page.dart';
import 'package:latuni/main_screens/welcome_page.dart';
import 'package:latuni/my_widgets/appbar_widgets.dart';
import 'package:latuni/utilities/clippers.dart';

import '../customer_screens/customer_order_page.dart';
import '../customer_screens/wishlist_page.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key, required this.documentId});
  late String documentId;
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void logOut() {
    FirebaseAuth.instance.signOut();

    Navigator.pushReplacementNamed(context, WelcomePage.pageName);
  }

  void goToCustomerOrderPage() {
    Navigator.pushNamed(context, CustomerOrderPage.pageName);
  }

  void goToWishlistPage() {
    Navigator.pushNamed(context, WishlistPage.pageName);
  }

  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return FutureBuilder<DocumentSnapshot>(
        future: customers.doc(widget.documentId).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Center(
              child: Text('No Data Exists'),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            ///
            Map<String, dynamic> customerData =
                snapshot.data!.data() as Map<String, dynamic>;
            return Scaffold(
                backgroundColor: Colors.grey.shade200,
                body: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      elevation: 0,
                      backgroundColor: Colors
                          .white, // Colors.grey.shade200 matching scaffold also
                      centerTitle: true,
                      pinned: true,
                      floating: true,
                      expandedHeight: 160,
                      flexibleSpace:
                          LayoutBuilder(builder: (context, constraints) {
                        return FlexibleSpaceBar(
                          title: AnimatedOpacity(
                            duration: const Duration(milliseconds: 200),
                            opacity: constraints.biggest.height <= 120 ? 1 : 0,
                            child: Text(
                              'A C C O U N T',
                              style: TextStyle(
                                  color: constraints.biggest.height <= 120
                                      ? Colors.black
                                      : Colors.white),
                            ),
                          ),
                          background: Container(
                            padding: EdgeInsets.only(
                                left: size.width * .09, top: 20),
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.yellow, Colors.brown]),
                            ),
                            child: const Row(
                              children: [
                                CircleAvatar(
                                    radius: 50,
                                    backgroundImage: AssetImage(
                                        'assets/images/rubber_bands/disco/DISCO_0.JPG')),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'GUEST',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      fontFamily: 'Playpen'),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height * .02,
                          ),

                          /// cart, orders, wishlist containers in one container
                          Container(
                            height: 100, // todo: set in ratio
                            width: size.width * .9,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(45),
                              boxShadow: [
                                const BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(-1, -2),
                                    spreadRadius: 1),
                                BoxShadow(
                                    color: Colors.grey.shade400,
                                    offset: const Offset(1, 2),
                                    spreadRadius: .5)
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                /// cart button
                                Container(
                                    height: 80,
                                    width: size.width * .2,
                                    decoration: const BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(50),
                                          bottomLeft: Radius.circular(50)),
                                    ),
                                    alignment: Alignment.center,
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return const CartPage(
                                            back: AppbarBackButton(),
                                          );
                                        }));
                                      },
                                      child: const FittedBox(
                                        child: Text(
                                          'Cart',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    )),

                                /// order button
                                Container(
                                    height: 80,
                                    width: size.width * .4,
                                    decoration: const BoxDecoration(
                                      color: Colors.yellow,
                                    ),
                                    alignment: Alignment.center,
                                    child: TextButton(
                                      onPressed: goToCustomerOrderPage,
                                      child: const FittedBox(
                                        child: Text(
                                          'ORDERS',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 40),
                                        ),
                                      ),
                                    )),

                                /// wishlist container
                                Container(
                                  height: 80,
                                  width: size.width * .2,
                                  decoration: const BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(50),
                                        bottomRight: Radius.circular(50)),
                                  ),
                                  alignment: Alignment.center,
                                  child: TextButton(
                                    onPressed: goToWishlistPage,
                                    child: const FittedBox(
                                      child: Text(
                                        'WishList',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: size.height * .03),

                          /// image container
                          /// todo: to be changed later by actual logo
                          // LayoutBuilder(
                          //   builder: (context, constraints) {
                          //     if (constraints.maxWidth > 600) {
                          //       return ClipRRect(
                          //         borderRadius: BorderRadius.circular(18),
                          //         child: Container(
                          //           height: size.height * .4,
                          //           width: size.width * .85,
                          //           decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(18),
                          //           ),
                          //           child: Image.asset(
                          //             'assets/images/rubber_bands/disco/DISCO_3.JPG',
                          //             fit: BoxFit.cover,
                          //           ),
                          //         ),
                          //       );
                          //     } else {
                          //       return const Text('OKIE');
                          //     }
                          //   },
                          // ),
                          ClipPath(
                            clipper: ParchiBottom(),
                            child: Container(
                              height: size.height * .25,
                              width: size.width * .9,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/rubber_bands/disco/DISCO_3.JPG',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),

                          /// account info divider & label
                          const ProfileHeaderLabel(label: ' Account info '),

                          ///container for email, phone number, and address
                          ContainerForProfile(
                            myChild: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                RepeatedListTile(
                                  leadingIcon: Icons.email_outlined,
                                  title: 'Email Address',
                                  subTitle: customerData['email'].toString(),
                                ),
                                const RedDotRow(),
                                // RedDivider(size: size),
                                RepeatedListTile(
                                  leadingIcon: Icons.phone_android_outlined,
                                  title: 'Phone Number',
                                  subTitle: customerData['phone'] ?? '00000',
                                ),
                                const RedDotRow(),

                                //RedDivider(size: size),
                                RepeatedListTile(
                                  leadingIcon: Icons.location_on_outlined,
                                  title: 'Address',
                                  subTitle: customerData['address'] ??
                                      'Ex: Kothi No D/60,\nKeshav Nagar, Numaish Camp, Saharanpur',
                                ),
                                RedDivider(size: size),
                              ],
                            ),
                          ),

                          /// account setting divider and label
                          const ProfileHeaderLabel(label: ' Account settings '),

                          ///container for editing email, phone number, and address settings changed
                          ContainerForProfile(
                            myChild: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                /// for editing profile
                                RepeatedListTile(
                                  onPressed: () {
                                    // todo: on tapping edit whole profile from here to database
                                  },
                                  leadingIcon: Icons.edit,
                                  title: 'Edit Profile',
                                  subTitle: '',
                                ),
                                const RedDotRow(),
                                // RedDivider(size: size),

                                /// for editing password
                                RepeatedListTile(
                                  onPressed: () {
                                    // todo: on tapping edit phone number from here to database
                                    // todo: later, we might use it for OTP purpose
                                  },
                                  leadingIcon: Icons.lock,
                                  title: 'Change password',
                                  subTitle: '',
                                ),
                                const RedDotRow(),
                                //RedDivider(size: size),

                                /// for loggingOut
                                RepeatedListTile(
                                  // todo: for logout from database

                                  onPressed: logOut,

                                  leadingIcon: Icons.logout,
                                  title: 'LogOut',
                                  subTitle: '',
                                ),
                                // YellowDivider(size: size),
                                RedDivider(size: size),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ],
                ));

            ///
          }
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey,
              color: Colors.red,
            ),
          );
        });
  }
}

class ContainerForProfile extends StatelessWidget {
  const ContainerForProfile({super.key, required this.myChild});
  final Widget myChild;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
        height: size.height * .42,
        width: size.width * .9,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          // border: Border.all(color: Colors.black54),
          boxShadow: [
            const BoxShadow(
                color: Colors.white, offset: Offset(-1, -1), spreadRadius: 1),
            BoxShadow(
                color: Colors.grey.shade400,
                offset: const Offset(1, 1),
                spreadRadius: 1)
          ],
        ),
        child: myChild);
  }
}

class RedDotRow extends StatelessWidget {
  const RedDotRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          padding:
              EdgeInsets.only(left: size.width * .15, right: size.width * .15),
          width: size.width * .9,
          height: size.height * .03,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: size.width * .75 ~/ 4,
              itemBuilder: (context, index) {
                return Container(
                  height: 5.0,
                  width: 5.0,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                );
              }),
        ),
      ],
    );
  }
}

class RedDivider extends StatelessWidget {
  const RedDivider({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Divider(
      indent: size.width * .15,
      endIndent: size.width * .15,
      thickness: 2,
      color: Colors.red.shade300,
    );
  }
}

class ProfileHeaderLabel extends StatelessWidget {
  const ProfileHeaderLabel({super.key, required this.label});

  // final Size size;
  final String label;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
        padding: EdgeInsets.only(
            left: size.width * .05,
            right: size.width * .05,
            top: size.height * .03,
            bottom: 8),
        child: Row(
          children: [
            const Expanded(
              child: Divider(
                thickness: 2,
                color: Colors.black54,
              ),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 18, fontFamily: 'Playpen'),
            ),
            const Expanded(
              child: Divider(
                thickness: 2,
                color: Colors.black54,
              ),
            ),
          ],
        ));
  }
}

class RepeatedListTile extends StatelessWidget {
  const RepeatedListTile(
      {super.key,
      required this.leadingIcon,
      required this.title,
      required this.subTitle,
      this.onPressed});
  final IconData leadingIcon;
  final String title;
  final String subTitle;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ListTile(
        horizontalTitleGap: 8,
        leading: Icon(
          leadingIcon,
          color: CupertinoColors.destructiveRed,
          size: 30,
        ),
        title: Text(
          title,
          style: const TextStyle(color: Colors.black),
        ),
        subtitle: Text(
          subTitle,
          style: const TextStyle(
            color: Colors.black54,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
