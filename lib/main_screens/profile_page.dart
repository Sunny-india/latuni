import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latuni/main_screens/cart_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0,
              backgroundColor:
                  Colors.white, // Colors.grey.shade200 matching scaffold also
              centerTitle: true,
              pinned: true,
              floating: true,
              expandedHeight: 160,
              flexibleSpace: LayoutBuilder(builder: (context, constraints) {
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
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.yellow, Colors.brown])),
                  ),
                );
              }),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  /// cart, orders, wishlist containers in one container
                  Container(
                    height: 100,
                    width: size.width * .9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
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
                                    MaterialPageRoute(builder: (context) {
                                  return const CartPage();
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
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const CartPage();
                                }));
                              },
                              child: const FittedBox(
                                child: Text(
                                  'ORDERS',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 40),
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
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) {
                                //       return const CartPage();
                                //     },
                                //   ),
                                // );
                              },
                              child: const FittedBox(
                                child: Text(
                                  'WishList',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * .03),

                  /// image container
                  //todo: to be changed later by actual logo
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      height: size.height * .2,
                      width: size.width * .9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Image.asset(
                        'assets/images/rubber_bands/disco/DISCO_3.JPG',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  /// account info divider & label
                  const ProfileHeaderLabel(label: ' Account info '),

                  ///container for email, phone number, and address
                  Container(
                    height: size.height * .4,
                    width: size.width * .9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black54),
                    ),
                    child: Column(
                      children: [
                        const RepeatedListTile(
                          leadingIcon: Icons.email_outlined,
                          title: 'Email Address',
                          subTitle: 'example@gmail.com',
                        ),
                        YellowDivider(size: size),
                        const RepeatedListTile(
                          leadingIcon: Icons.phone_android_outlined,
                          title: 'Phone Number',
                          subTitle: '9810098100',
                        ),
                        YellowDivider(size: size),
                        const RepeatedListTile(
                          leadingIcon: Icons.location_on_outlined,
                          title: 'Address',
                          subTitle:
                              'Ex: Kothi No D/60,\nKeshav Nagar, Numaish Camp, Saharanpur',
                        ),
                        YellowDivider(size: size),
                      ],
                    ),
                  ),

                  /// account setting divider and label
                  const ProfileHeaderLabel(label: ' Account settings '),

                  ///container for editing email, phone number, and address settings changed
                  Container(
                    height: size.height * .4,
                    width: size.width * .9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black54),
                    ),
                    child: Column(
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
                        YellowDivider(size: size),

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
                        YellowDivider(size: size),

                        /// for loggingOut
                        RepeatedListTile(
                          onPressed: () {
                            // todo: on tapping edit address from here to database
                          },
                          leadingIcon: Icons.logout,
                          title: 'Log Out',
                          subTitle: '',
                        ),
                        YellowDivider(size: size),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class YellowDivider extends StatelessWidget {
  const YellowDivider({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Divider(
      indent: size.width * .05,
      endIndent: size.width * .05,
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
            bottom: 4),
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
          style: const TextStyle(color: Colors.black54),
        ),
      ),
    );
  }
}
