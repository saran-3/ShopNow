import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopzmclay/views/buyers/auth/login_screen.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  _uploadProfileImageToStorage(Uint8List? image) async {
    Reference ref =
        _storage.ref().child('profilePics').child(_auth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(image!);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  pickProfileImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      print('Image not selected');
    }
  }

  Future<String> SignUpUser(String email, String fullName, String phoneNumber,
      String password, Uint8List? image, String address) async {
    String res = 'Some error occured';

    try {
      if (email.isNotEmpty &&
          fullName.isNotEmpty &&
          phoneNumber.isNotEmpty &&
          password.isNotEmpty &&
          address.isNotEmpty &&
          image != null
          
          ) {
        // create the users

        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

       String profileImageUrl = await _uploadProfileImageToStorage(image);
        await _firestore.collection('buyers').doc(cred.user!.uid).set({
          'address': '',
          'email': email,
          'fullName': fullName,
          'phonenumber': phoneNumber,
          'buyersId': cred.user!.uid,
          'profileImage':profileImageUrl,
          
          
        });

        res = 'Success';
      } else {
        res = 'Please, Fields must not be empty';
      }
    } catch (e) {}
    return res;
  }

  loginUsers(String email, String password) async {
    String res = 'Something went wrong';
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        res = 'Success';
      } else {
        res = 'Please, Fields must not be empty';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
