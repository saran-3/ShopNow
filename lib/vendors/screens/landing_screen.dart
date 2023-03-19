import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopzmclay/vendors/models/vendor_user_models.dart';
import 'package:shopzmclay/vendors/screens/main_vendor_screen.dart';
import 'package:shopzmclay/vendors/views/auth/vendor_register_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final CollectionReference _vendorsStream =
        FirebaseFirestore.instance.collection('vendors');

    return Scaffold(
        body: StreamBuilder<DocumentSnapshot>(
      stream: _vendorsStream.doc(_auth.currentUser!.uid).snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        if (!snapshot.data!.exists) {
          return VendorRegisterationScreen();
        }
        VendorUserModel vendorUserModel = VendorUserModel.fromJson(
            snapshot.data!.data() as Map<String, dynamic>);

        if (vendorUserModel.approved == true) {
          return MainVendorScreen();
        }
        return Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                vendorUserModel.storeImage.toString(),
                fit: BoxFit.cover,
                width: 90,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              vendorUserModel.businessName.toString(),
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Your Application is under processing. We will get back to you soon.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () async {
                  await _auth.signOut();
                },
                child: Text('Signout'))
          ],
        ));
      },
    ));
  }
}
