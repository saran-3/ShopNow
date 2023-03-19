import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopzmclay/views/buyers/productDetail/product_detail_screen.dart';

class AllProductsScreen extends StatelessWidget {
  final dynamic categoryData;

  const AllProductsScreen({required this.categoryData});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productStream = FirebaseFirestore.instance
        .collection('products')
        .where('category', isEqualTo: categoryData['categoryName'])
        .where('approved', isEqualTo: true)
        .snapshots();

    return Scaffold(
      appBar: AppBar( 
        backgroundColor: Colors.yellow.shade900,
        title: Text(
          categoryData['categoryName'],
          style: TextStyle(letterSpacing: 6, fontWeight: FontWeight.bold),
        ),
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

            return GridView.builder(
                itemCount: snapshot.data!.size,
                // scrollDirection: Axis.horizontal,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 200 / 300,
                ),
                itemBuilder: (context, Index) {
                  final productData = snapshot.data!.docs[Index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ProductDetailScreen(
                              productData: productData,
                            );
                          },
                        ),
                      );
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Container(
                            height: 170,
                            width: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                    productData['imageUrlList'][0],
                                  ),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Text(
                            productData['productName'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 4,
                            ),
                          ),
                          Text(
                            '\₹' ' ' +
                                productData['productPrice'].toStringAsFixed(2),
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 4,
                                color: Colors.yellow.shade900),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
