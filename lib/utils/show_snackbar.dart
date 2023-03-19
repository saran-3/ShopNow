import 'package:flutter/material.dart';

showSnack(context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: Colors.yellow.shade700, content: Text(title, style: TextStyle(fontWeight: FontWeight.bold),)));
}
