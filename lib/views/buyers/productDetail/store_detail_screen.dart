import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopzmclay/views/buyers/productDetail/product_detail_screen.dart';

class StoreDetailScreen extends StatelessWidget {
  final dynamic storeData;

  const StoreDetailScreen({super.key, required this.storeData});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
        .collection('products')
        .where('vendorId', isEqualTo: storeData['vendorId'])
        .snapshots();

    return Scaffold(
        appBar: AppBar(
          title: Text(storeData['businessName']),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _productsStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: Colors.yellow.shade900),
              );
            }

            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  'No Products Uploaded',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
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
          },
        ));
  }
}
