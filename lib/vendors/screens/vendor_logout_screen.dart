import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopzmclay/vendors/screens/main_vendor_screen.dart';
import 'package:shopzmclay/views/buyers/main_screen.dart';

class LogoutScreen extends StatelessWidget {
  FirebaseAuth _auth = FirebaseAuth.instance;
  LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ========== above section is created by me for easy testing=========

    // return Scaffold(
    //   body: Center(
    //     child: TextButton(
    //       child: Text('Goto buyer mode'),
    //       onPressed: () {
    //         Navigator.push(context, MaterialPageRoute(builder: (context) {
    //           return MainScreen();
    //         }));
    //         // await _auth.signOut();
    //       },
    //     ),
    //   ),
    // );

    // ========== below section is created by me for easy testing=========

// ================================

    // ========== below section is original=========

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            child: Text('Logout'),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MainScreen();
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
                  'Goto Buyer Mode',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

    // ========== above section is original=========
  


/*TextButton(
                  child: Text('Logout'),
                  onPressed: () async {
                    await _auth.signOut();
                  },
                ),
                
                */