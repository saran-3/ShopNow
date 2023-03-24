import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopzmclay/vendors/screens/main_vendor_screen.dart';
import 'package:shopzmclay/views/buyers/auth/login_screen.dart';
import 'package:shopzmclay/views/buyers/inner_screens/edit_profile.dart';
import 'package:shopzmclay/views/buyers/inner_screens/order_screen.dart';

class AccountScreen extends StatelessWidget {
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    // ========== below section is created by me for easy testing=========
    // return Scaffold(
    //   body: Center(
    //     child: TextButton(
    //       child: Text('Goto Vendor Mode'),
    //       onPressed: () {
    //         Navigator.push(context, MaterialPageRoute(builder: (context) {
    //           return MainVendorScreen();
    //         }));
    //       },
    //     ),
    //   ),
    // );

    // ========== above section is created by me for easy testing=========

    // ==============================================================

    CollectionReference buyers =
        FirebaseFirestore.instance.collection('buyers');

    return FutureBuilder<DocumentSnapshot>(
      future: buyers.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      // future: buyers.doc('7lpRA9VqotaLTWuT7loYtGFxCEN2').get(),

      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          print('connectionOk');
          return Scaffold(
            appBar: AppBar(
              elevation: 2,
              backgroundColor: Colors.yellow.shade900,
              title: Text(
                'Profile',
                style: TextStyle(letterSpacing: 4),
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Icon(Icons.dark_mode),
                )
              ],
            ),
            body: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: CircleAvatar(
                      radius: 64,
                      backgroundColor: Colors.yellow.shade900,
                      backgroundImage: NetworkImage(data['profileImage']),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(data['fullName'],
                      // child: Text('fullName',
                      // child: Text('Full Name: ${data['productName']}',
                      style: (TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(
                    thickness: 2,
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(data['email'],
                      // child: Text('email',
                      style: (TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ))),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return EditProfileScreen(
                        userData: data,
                      );
                    }));
                  },
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width - 200,
                    decoration: BoxDecoration(
                        color: Colors.yellow.shade900,
                        borderRadius: BorderRadius.circular(4)),
                    child: Center(
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 4,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Divider(
                    thickness: 2,
                    color: Colors.grey,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('Phone'),
                ),
                ListTile(
                  leading: Icon(Icons.shop),
                  title: Text('Cart'),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CustomerOrderScreen();
                    }));
                  },
                  leading: Icon(Icons.shopping_cart),
                  title: Text('Orders'),
                ),
                ListTile(
                  onTap: () async {
                    await _auth.signOut().whenComplete(() {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginScreen();
                      }));
                    });
                  },
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return MainVendorScreen();
                      }));
                    },
                    child: Container(
                      height: 50,
                      width: 600,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(10),
                        color: Colors.yellow.shade900,
                      ),
                      child: Center(
                        child: Text(
                          'Goto Vendor Mode',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
