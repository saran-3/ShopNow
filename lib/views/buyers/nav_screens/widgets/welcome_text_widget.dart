import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopzmclay/views/buyers/nav_screens/cart_screen.dart';

class WelcomeText extends StatelessWidget {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    CollectionReference buyers =
        FirebaseFirestore.instance.collection('buyers');

    return _auth.currentUser == null
        ? Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top, left: 25, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Welcome, What are you \nLooking for👀',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CartScreen();
                    }));
                  },
                  child: Container(
                    child: SvgPicture.asset(
                      'assets/icons/cart.svg',
                      width: 20,
                    ),
                  ),
                )
              ],
            ),
          )
        : FutureBuilder<DocumentSnapshot>(
            future: buyers.doc(FirebaseAuth.instance.currentUser!.uid).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                // return Text("Document does not exist");
                return Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top,
                      left: 25,
                      right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hi, What are you \nLooking for👀',
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return CartScreen();
                          }));
                        },
                        child: Container(
                          child: SvgPicture.asset(
                            'assets/icons/cart.svg',
                            width: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;

                return Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top,
                      left: 25,
                      right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hi ' +
                            data['fullName'].toString().toUpperCase() +
                            ', What are you \nLooking for👀',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold, ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return CartScreen();
                          }));
                        },
                        child: Container(
                          child: SvgPicture.asset(
                            'assets/icons/cart.svg',
                            width: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                );

                // Text(data['fullName']);
              }

              return Center(
                child: CircularProgressIndicator(
                  color: Colors.yellow.shade900,
                ),
              );
            },
          );
  }
}







//     CollectionReference buyers =
//         FirebaseFirestore.instance.collection('buyers');

//     FutureBuilder<DocumentSnapshot>(
//         future: buyers.doc(FirebaseAuth.instance.currentUser!.uid).get(),
//         // future: buyers.doc('7lpRA9VqotaLTWuT7loYtGFxCEN2').get(),

//         builder:
//             (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             Map<String, dynamic> data =
//                 snapshot.data!.data() as Map<String, dynamic>;

//             return _auth.currentUser == null
//                 ? Padding(
//                     padding: EdgeInsets.only(
//                         top: MediaQuery.of(context).padding.top,
//                         left: 25,
//                         right: 15),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Howdy, What are you \nLooking for👀',
//                           style: TextStyle(
//                               fontSize: 19, fontWeight: FontWeight.bold),
//                         ),
//                         Container(
//                           child: SvgPicture.asset(
//                             'assets/icons/cart.svg',
//                             width: 20,
//                           ),
//                         )
//                       ],
//                     ),
//                   )
//                 // : FutureBuilder<DocumentSnapshot>(
//                 //     future: buyers.doc(FirebaseAuth.instance.currentUser!.uid).get(),
//                 //     // future: buyers.doc('7lpRA9VqotaLTWuT7loYtGFxCEN2').get(),

//                 //     builder: (BuildContext context,
//                 //         AsyncSnapshot<DocumentSnapshot> snapshot) {
//                 //       if (snapshot.hasError) {
//                 //         return Text("Something went wrong");
//                 //       }

//                 //       if (snapshot.hasData && !snapshot.data!.exists) {
//                 //         return Text("Document does not exist");
//                 //       }

//                 //       if (snapshot.connectionState == ConnectionState.done) {
//                 // Map<String, dynamic> data =
//                 //     snapshot.data!.data() as Map<String, dynamic>;

//                 : Padding(
//                     padding: EdgeInsets.only(
//                         top: MediaQuery.of(context).padding.top,
//                         left: 25,
//                         right: 15),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Hi' +
//                               data['fullName'] +
//                               snapshot.data!.data().toString() +
//                               'Login, What are you \nLooking for👀',
//                           style: TextStyle(
//                               fontSize: 19, fontWeight: FontWeight.bold),
//                         ),
//                         Container(
//                           child: SvgPicture.asset(
//                             'assets/icons/cart.svg',
//                             width: 20,
//                           ),
//                         )
//                       ],
//                     ),
//                   );
//           }

//           return Center(child: CircularProgressIndicator());
//         }
//         );
//   }
// }

