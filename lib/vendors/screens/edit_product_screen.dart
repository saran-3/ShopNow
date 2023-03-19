import 'package:flutter/material.dart';
import 'package:shopzmclay/vendors/screens/edit_products_tabs/published_tab.dart';
import 'package:shopzmclay/vendors/screens/edit_products_tabs/unpublished_tab.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.yellow.shade900,
          title: Text(
            'Manage Products',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, letterSpacing: 7),
          ),
          bottom: TabBar(tabs: [
            Tab(
              child: Text('Published'),
            ),
            Tab(
              child: Text('Unpublished'),
            ),
          ]),
        ),
        body: TabBarView(children: [
          PublishedTab(),
          UnPublishedTab(),
        ]),
      ),
    );
  }
}
