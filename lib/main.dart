import 'package:flutter/material.dart';
import 'package:latuni/agent_screens/agent_login_page.dart';
import 'package:latuni/customer_screens/customer_order_page.dart';
import 'package:latuni/customer_screens/wishlist_page.dart';
import 'package:latuni/dashboard_components/edit_business_page.dart';
import 'package:latuni/dashboard_components/manage_products_page.dart';
import 'package:latuni/dashboard_components/my_store.dart';
import 'package:latuni/dashboard_components/supplier_balance_page.dart';
import 'package:latuni/dashboard_components/supplier_orders.dart';
import 'package:latuni/dashboard_components/supplier_statics_page.dart';
import 'package:latuni/main_screens/customer_home_page.dart';
import 'package:latuni/main_screens/dashboard.dart';
import 'package:latuni/main_screens/supplier_home_page.dart';

import 'auth/customer_auth/customer_register_page.dart';
import 'main_screens/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: Colors.grey.shade300,
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => const WelcomePage(),
      WelcomePage.pageName: (context) => const WelcomePage(),

      ///  customers pages start here
      CustomerRegisterPage.pageName: (context) => const CustomerRegisterPage(),
      CustomerHomePage.pageName: (context) => const CustomerHomePage(),
      CustomerOrderPage.pageName: (context) => const CustomerOrderPage(),
      WishlistPage.pageName: (context) => const WishlistPage(),

      /// suppliers pages start here
      SupplierHomePage.pageName: (context) => const SupplierHomePage(),
      DashboardPage.pageName: (context) => const DashboardPage(),
      MyStorePage.pageName: (context) => const MyStorePage(),
      SupplierOrdersPage.pageName: (context) => const SupplierOrdersPage(),
      EditBusinessPage.pageName: (context) => const EditBusinessPage(),
      ManageProductPage.pageName: (context) => const ManageProductPage(),
      SupplierBalancePage.pageName: (context) => const SupplierBalancePage(),
      SupplierStaticsPage.pageName: (context) => const SupplierStaticsPage(),

      /// agent pages start here
      AgentLoginPage.pageName: (context) => const AgentLoginPage(),
    },
  ));
}
