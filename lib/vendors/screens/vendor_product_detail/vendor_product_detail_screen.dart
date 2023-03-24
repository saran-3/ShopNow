import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopzmclay/utils/show_snackbar.dart';

class VendorProductDetailScreen extends StatefulWidget {
  final dynamic productData;

  const VendorProductDetailScreen({super.key, required this.productData});

  @override
  State<VendorProductDetailScreen> createState() =>
      _VendorProductDetailScreenState();
}

class _VendorProductDetailScreenState extends State<VendorProductDetailScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _brandNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productdescriptionController =
      TextEditingController();
  final TextEditingController _categoryNameController = TextEditingController();

  @override
  void initState() {
    setState(() {
      _productNameController.text = widget.productData['productName'];
      _brandNameController.text = widget.productData['brandName'];
      _quantityController.text = widget.productData['quantity'].toString();
      _productPriceController.text =
          widget.productData['productPrice'].toString();
      _productdescriptionController.text = widget.productData['description'];
      _categoryNameController.text = widget.productData['category'];
    });
    super.initState();
  }

  double? productPrice;
  int? productQuantity;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.productData['productName']),
          backgroundColor: Colors.yellow.shade900,
          elevation: 0,
        ),
        body: Column(children: [
          TextFormField(
            controller: _productNameController,
            decoration: InputDecoration(labelText: 'Product Name'),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _brandNameController,
            decoration: InputDecoration(labelText: 'Brand Name'),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            onChanged: (value) {
              productQuantity = int.parse(value);
            },
            controller: _quantityController,
            decoration: InputDecoration(labelText: 'Quantity'),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            onChanged: (value) {
              productPrice = double.parse(value);
            },
            controller: _productPriceController,
            decoration: InputDecoration(labelText: 'Price'),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            maxLength: 800,
            maxLines: 3,
            controller: _productdescriptionController,
            decoration: InputDecoration(labelText: 'Description'),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            enabled: false,
            controller: _categoryNameController,
            decoration: InputDecoration(labelText: 'Category'),
          ),
        ]),
        bottomSheet: InkWell(
          onTap: () async {
            if (productPrice != null && productQuantity != null) {
              await _firestore
                  .collection('products')
                  .doc(widget.productData['productId'])
                  .update({
                'productName': _productNameController.text,
                'brandName': _brandNameController.text,
                'quantity': productQuantity,
                'productPrice': productPrice,
                'description': _productdescriptionController.text,
                'category': _categoryNameController.text,
              });
            } else {
              showSnack(context, 'Update Price and Quantity');
            }
          },
          child: Container(
            height: 40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.yellow.shade900,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                'UPDATE PRODUCT',
                style: TextStyle(
                    fontSize: 18,
                    letterSpacing: 6,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
