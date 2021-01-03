import 'package:flutter/material.dart';

void showNormalDialog(BuildContext context, String title, String content) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
        );
      });
}
