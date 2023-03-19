import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopzmclay/provider/cart_provider.dart';
import 'package:shopzmclay/utils/show_snackbar.dart';

class ProductDetailScreen extends StatefulWidget {
  final dynamic productData;

  const ProductDetailScreen({required this.productData});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String formatedDate(date) {
    final outputFormat = DateFormat('dd/MM/yyyy');
    final outputDate = outputFormat.format(date);
    return outputDate;
  }

  int _imageIndex = 0;
  String? _selectedSize;

  @override
  Widget build(BuildContext context) {
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          widget.productData['productName'],
          style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 5),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  child: PhotoView(
                      imageProvider: NetworkImage(
                          widget.productData['imageUrlList'][_imageIndex])),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        itemCount: widget.productData['imageUrlList'].length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _imageIndex = index;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.yellow.shade900)),
                                height: 60,
                                width: 60,
                                child: Image.network(
                                  widget.productData['imageUrlList'][index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Text(
                '₹' + widget.productData['productPrice'].toStringAsFixed(2),
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 8,
                    color: Colors.yellow.shade900),
              ),
            ),
            Text(
              widget.productData['productName'],
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 8,
              ),
            ),
            ExpansionTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Product description',
                    style: TextStyle(color: Colors.yellow.shade900),
                  ),
                  Text(
                    'View more',
                    style: TextStyle(color: Colors.yellow.shade900),
                  ),
                ],
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.productData['description'],
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey,
                      letterSpacing: 3,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'This Product will be shipping on',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow.shade900),
                  ),
                  Text(
                    formatedDate(widget.productData['scheduleDate'].toDate()),
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ],
              ),
            ),
            ExpansionTile(
              title: Text('Available sizes'),
              children: [
                Container(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.productData['sizeList'].length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: _selectedSize ==
                                  widget.productData['sizeList'][index]
                              ? Colors.yellow
                              : null,
                          child: OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  _selectedSize =
                                      widget.productData['sizeList'][index];
                                });
                                print(_selectedSize);
                              },
                              child:
                                  Text(widget.productData['sizeList'][index])),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: _cartProvider.getCartItem
                  .containsKey(widget.productData['productId'])
              ? null
              : () {
                  if (_selectedSize == null) {
                    return showSnack(context, 'Please select a Size');
                  } else {
                    _cartProvider.addProductToCart(
                        widget.productData['productName'],
                        widget.productData['productId'],
                        widget.productData['imageUrlList'],
                        1,
                        widget.productData['quantity'],
                        widget.productData['productPrice'],
                        widget.productData['vendorId'],
                        // widget.productData['_selectedSize'],

                        _selectedSize!,
                        widget.productData['scheduleDate']);

                        return showSnack(context, 'You Added ${widget.productData['productName']} to your Cart');
                    
                  }
                },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: _cartProvider.getCartItem
                        .containsKey(widget.productData['productId'])
                    ? Colors.green.shade900
                    : Colors.yellow.shade900,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    CupertinoIcons.cart,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _cartProvider.getCartItem
                          .containsKey(widget.productData['productId'])
                      ? Text(
                          'ADDED IN CART',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18,
                              letterSpacing: 5),
                        )
                      : Text(
                          'ADD TO CART',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18,
                              letterSpacing: 5),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
