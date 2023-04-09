import 'package:flutter/material.dart';

class AlertNotif {
  static void ShowSnackBar(BuildContext context, String text) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}
