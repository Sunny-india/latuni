import 'package:flutter/material.dart';
import 'package:latuni/customer_screens/customer_order_page.dart';
import 'package:latuni/dashboard_components/edit_business_page.dart';
import 'package:latuni/dashboard_components/manage_products_page.dart';
import 'package:latuni/dashboard_components/my_store.dart';
import 'package:latuni/dashboard_components/supplier_balance_page.dart';
import 'package:latuni/dashboard_components/supplier_orders.dart';
import 'package:latuni/dashboard_components/supplier_statics_page.dart';
import 'package:latuni/main_screens/customer_home_page.dart';
import 'package:latuni/main_screens/dashboard.dart';
import 'package:latuni/main_screens/supplier_home_page.dart';

import 'main_screens/welcome_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    //home: const WelcomePage(),
    initialRoute: '/',
    routes: {
      '/': (context) => const WelcomePage(),
      WelcomePage.pageName: (context) => const WelcomePage(),
      //  customers pages start here
      CustomerHomePage.pageName: (context) => const CustomerHomePage(),
      CustomerOrderPage.pageName: (context) => const CustomerOrderPage(),

      // suppliers pages start here
      SupplierHomePage.pageName: (context) => const SupplierHomePage(),
      DashboardPage.pageName: (context) => const DashboardPage(),
      MyStorePage.pageName: (context) => const MyStorePage(),
      SupplierOrdersPage.pageName: (context) => const SupplierOrdersPage(),
      EditBusinessPage.pageName: (context) => const EditBusinessPage(),

      ManageProductPage.pageName: (context) => const ManageProductPage(),
      SupplierBalancePage.pageName: (context) => const SupplierBalancePage(),
      SupplierStaticsPage.pageName: (context) => const SupplierStaticsPage(),
    },
    //SupplierHomePage(),

    // CustomerHomeScreen(),
  ));
}
