import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopzmclay/vendors/screens/earnings_screen.dart';
import 'package:shopzmclay/vendors/screens/main_vendor_screen.dart';
import 'package:shopzmclay/vendors/screens/vendor_profile_screen.dart';
import 'package:shopzmclay/vendors/views/auth/vendor_register_screen.dart';
import 'package:shopzmclay/views/buyers/auth/login_screen.dart';
import 'package:shopzmclay/views/buyers/auth/register_screen.dart';
import 'package:shopzmclay/views/buyers/inner_screens/edit_profile.dart';
import 'package:shopzmclay/views/buyers/inner_screens/order_screen.dart';

class AccountScreen extends StatelessWidget {
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    CollectionReference buyers =
        FirebaseFirestore.instance.collection('buyers');

    return _auth.currentUser == null
        ? Scaffold(
            appBar: AppBar(
              elevation: 2,
              backgroundColor: Colors.yellow.shade900,
              title: Text(
                'Prfile',
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
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: CircleAvatar(
                        radius: 64,
                        backgroundColor: Colors.yellow.shade900,
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Login Account to Access Profile',
                        style: (TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ))),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginScreen();
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
                          'LOGIN ACCOUNT',
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 4,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return BuyersRegisterScreen();
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
                          'SIGNUP',
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 4,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 25,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(15),
                  //   child: InkWell(
                  //     onTap: () {
                  //       Navigator.push(context,
                  //           MaterialPageRoute(builder: (context) {
                  //         return VendorRegisterationScreen();
                  //       }));
                  //     },
                  //     child: Container(
                  //       height: 50,
                  //       width: 600,
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadiusDirectional.circular(10),
                  //         color: Colors.yellow.shade900,
                  //       ),
                  //       child: Center(
                  //         child: Text(
                  //           'Goto Vendor Mode',
                  //           style: TextStyle(color: Colors.white),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          )
        : FutureBuilder<DocumentSnapshot>(
            future: buyers.doc(FirebaseAuth.instance.currentUser!.uid).get(),
            // future: buyers.doc('7lpRA9VqotaLTWuT7loYtGFxCEN2').get(),

            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                // return Text("Document does not exist");
                return Scaffold(
                  appBar: AppBar(
                    elevation: 2,
                    backgroundColor: Colors.yellow.shade900,
                    title: Text(
                      'Profil',
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
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // SizedBox(
                        //   height: 250,
                        // ),
                        CircleAvatar(
                          radius: 64,
                          backgroundColor: Colors.yellow.shade900,
                          child: Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text('Login Account to Access Profile',
                            style: (TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ))),
                        SizedBox(
                          height: 25,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return LoginScreen();
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
                                'LOGIN ACCOUNT',
                                style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 4,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return BuyersRegisterScreen();
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
                                'SIGNUP',
                                style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 4,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: 25,
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(15),
                        //   child: InkWell(
                        //     onTap: () {
                        //       Navigator.push(context,
                        //           MaterialPageRoute(builder: (context) {
                        //         return MainVendorScreen();
                        //       }));
                        //     },
                        //     child: Container(
                        //       height: 50,
                        //       width: 600,
                        //       decoration: BoxDecoration(
                        //         borderRadius:
                        //             BorderRadiusDirectional.circular(10),
                        //         color: Colors.yellow.shade900,
                        //       ),
                        //       child: Center(
                        //         child: Text(
                        //           'Goto Vendor Mode',
                        //           style: TextStyle(color: Colors.white),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;

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
                    body: SingleChildScrollView(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // SizedBox(
                              //   height: 250,
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: CircleAvatar(
                                  radius: 64,
                                  backgroundColor: Colors.yellow.shade900,
                                  backgroundImage:
                                      NetworkImage(data['profileImage']),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),

                              Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width - 200,
                                decoration: BoxDecoration(
                                    color: Colors.yellow.shade900,
                                    borderRadius: BorderRadius.circular(4)),
                                child: Center(
                                  child: Text(
                                    data['fullName'].toString().toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: 4,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 25,
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
                                    Navigator.pushReplacement(context,
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
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                      return MainVendorScreen();
                                    }));
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 600,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadiusDirectional.circular(10),
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
                              ),
                            ]),
                      ),
                    ));
              }

              return Center(child: CircularProgressIndicator());
            },
          );
  }
}




/*


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
                ) */