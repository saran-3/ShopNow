import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopzmclay/views/buyers/inner_screens/all_screen_products.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productStream =
        FirebaseFirestore.instance.collection('categories').snapshots();

    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          title: (Text(
            'Categories',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                letterSpacing: 3),
          )),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _productStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.yellow.shade900,
                ),
              );
            }

            return Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  itemExtent: 100,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, Index) {
                    final categoryData = snapshot.data!.docs[Index];

                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return AllProductsScreen(
                                categoryData: categoryData,
                              );
                            }));
                          },
                          leading: Container(
                            height: 200,
                            width: 100,
                            child: Center(
                              child: Image.network(
                                categoryData['image'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(categoryData['categoryName']),
                        ),
                      ),
                    );
                  }),
            );
          },
        ));
  }
}
