import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shopzmclay/vendors/screens/earnings_screen.dart';
import 'package:shopzmclay/vendors/screens/edit_product_screen.dart';
import 'package:shopzmclay/vendors/screens/upload_screen.dart';
import 'package:shopzmclay/vendors/screens/vendor_logout_screen.dart';
import 'package:shopzmclay/vendors/screens/vendor_order_screen.dart';

class MainVendorScreen extends StatefulWidget {
  @override
  State<MainVendorScreen> createState() => _MainVendorScreenState();
}

class _MainVendorScreenState extends State<MainVendorScreen> {
  int _pageIndex = 0;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Widget> _pages = [
    EarningsScreen(),
    UploadScreen(),
    EditProductScreen(),
    VendorUploadScreen(),
    LogoutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.yellow.shade800,
          currentIndex: _pageIndex,
          onTap: (value) {
            setState(() {
              _pageIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.money_dollar),
              label: 'EARNINGS',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.upload),
              label: 'UPLOAD',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit),
              label: 'EDIT',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.shopping_cart),
              label: 'ORDERS',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.logout),
              label: 'LOGOUT',
            ),
          ]),
      body: _pages[_pageIndex],
    );
  }
}
