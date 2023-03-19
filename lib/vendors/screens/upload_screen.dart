import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shopzmclay/provider/product_provider.dart';
import 'package:shopzmclay/vendors/screens/main_vendor_screen.dart';
import 'package:shopzmclay/vendors/screens/upload_tab_screen/attributes_tab__screen.dart';
import 'package:shopzmclay/vendors/screens/upload_tab_screen/general_screen.dart';
import 'package:shopzmclay/vendors/screens/upload_tab_screen/images_tab_screen.dart';
import 'package:shopzmclay/vendors/screens/upload_tab_screen/shipping_screen.dart';
import 'package:uuid/uuid.dart';

class UploadScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);

    return DefaultTabController(
      length: 4,
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.yellow.shade900,
            elevation: 0,
            bottom: TabBar(tabs: [
              Tab(
                child: Text('General'),
              ),
              Tab(
                child: Text('Shipping'),
              ),
              Tab(
                child: Text('Attriputes'),
              ),
              Tab(
                child: Text('Images'),
              ),
            ]),
          ),
          body: TabBarView(children: [
            GeneralScreen(),
            ShippingScreen(),
            AttriputesTabScreen(),
            ImagesTabScreen(),
          ]),
          bottomSheet: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.yellow.shade900,
              ),
              child: Text('Save'),
              onPressed: () async {
                EasyLoading.show(status: 'Please wait...');
                if (_formKey.currentState!.validate()) {
                  final productId = Uuid().v4();
                  await _firestore.collection('products').doc(productId).set({
                    'productId': productId,
                    'productName': _productProvider.productData['productName'],
                    'productPrice':
                        _productProvider.productData['productPrice'],
                    'quantity': _productProvider.productData['quantity'],
                    'category': _productProvider.productData['category'],
                    'description': _productProvider.productData['description'],
                    'scheduleDate':
                        _productProvider.productData['scheduleDate'],
                    'chargeShipping':
                        _productProvider.productData['chargeShipping'],
                    'shippingCharge':
                        _productProvider.productData['shippingCharge'],
                    'brandName': _productProvider.productData['brandName'],
                    'sizeList': _productProvider.productData['sizeList'],
                    'imageUrlList':
                        _productProvider.productData['imageUrlList'],
                    'vendorId':FirebaseAuth.instance.currentUser!.uid,
                    'approved': false,
                        
                  }).whenComplete(() {
                    _productProvider.clearData();
                    _formKey.currentState!.reset();
                    EasyLoading.dismiss();

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MainVendorScreen();
                    }));
                  });
                  print(_productProvider.productData['productName']);
                  print(_productProvider.productData['productPrice']);
                  print(_productProvider.productData['quantity']);
                  print(_productProvider.productData['category']);
                  print(_productProvider.productData['description']);
                  print(_productProvider.productData['scheduleDate']);
                  print(_productProvider.productData['imageUrlList']);
                  print(_productProvider.productData['chargeShipping']);
                  print(_productProvider.productData['shippingCharge']);
                  print(_productProvider.productData['sizeList']);
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
