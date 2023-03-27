import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class WithdrawalScreen extends StatelessWidget {
  // final TextEditingController amountController = TextEditingController();

  late String amount;
  late String name;
  late String mobile;
  late String bankName;
  late String bankAccountName;
  late String bankAccountNumber;
  final GlobalKey<FormState> _formkey = GlobalKey();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade900,
        elevation: 0,
        title: Text(
          'Withdraw',
          style: TextStyle(
              color: Colors.white,
              letterSpacing: 6,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Amount must not be empty';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  amount = value;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Name must not be empty';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  name = value;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Mobile must not be empty';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  mobile = value;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Mobile',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Bank Name must not be empty';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  bankName = value;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Bank Name',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Bank Account Name must not be empty';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  bankAccountName = value;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Bank Account Name',
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Bank Account Number must not be empty';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  bankAccountNumber = value;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Bank Account Number',
                ),
              ),
              TextButton(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      await _firestore
                          .collection('withdrawal')
                          .doc(Uuid().v4())
                          .set({
                        'Amount': amount,
                        'Name': name,
                        'Mobile': mobile,
                        'BankName': bankName,
                        'Bank Account Name': bankAccountName,
                        'Bank Account Number': bankAccountNumber,
                      });
                      print('Cool');
                    } else {}
                  },
                  child: Text(
                    'Get Cash',
                    style: TextStyle(
                      // color: Colors.white,
                      // letterSpacing: 6,
                      fontSize: 18,
                      // fontWeight: FontWeight.bold
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
