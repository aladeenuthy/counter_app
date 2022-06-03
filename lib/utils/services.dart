import 'package:flutter/material.dart';
import 'package:counter_app/helpers/key_helper.dart';
void showSnackBar(String message, [bool error = true]) {
  KeyHelper.scafKey.currentState?.showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: error ? Colors.redAccent : Colors.greenAccent,
  ));
}
