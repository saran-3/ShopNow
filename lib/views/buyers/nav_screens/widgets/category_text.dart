import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shopzmclay/views/buyers/nav_screens/category_screen.dart';
import 'package:shopzmclay/views/buyers/nav_screens/widgets/home_products.dart';
import 'package:shopzmclay/views/buyers/nav_screens/widgets/main_products_widget.dart';

class CategoryText extends StatefulWidget {
  @override
  State<CategoryText> createState() => _CategoryTextState();
}

class _CategoryTextState extends State<CategoryText> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _categoriesStream =
        FirebaseFirestore.instance.collection('categories').snapshots();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories',
          style: TextStyle(fontSize: 19),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: _categoriesStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading Categories");
            }

            return Container(
              height: 40,
              child: Row(
                children: [
                  Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final categoryData = snapshot.data!.docs[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ActionChip(
                                backgroundColor: Colors.yellow.shade900,
                                onPressed: () {
                                  setState(() {
                                    _selectedCategory =
                                        categoryData['categoryName'];
                                  });
                                },
                                label: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Text(
                                      categoryData['categoryName'],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          })),
                  IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CategoryScreen();
                        }));
                      },
                      icon: Icon(Icons.arrow_forward_ios))
                ],
              ),
            );
          },
        ),
        if (_selectedCategory == null) MainProductsWidget(),
        if (_selectedCategory != null)
          HomeProductsWidget(categoryName: _selectedCategory!),
      ],
    );
  }
}
