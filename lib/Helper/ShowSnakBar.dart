import 'package:flutter/material.dart';

void ShowSnakBar(BuildContext context, String messge) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(messge)));
}
