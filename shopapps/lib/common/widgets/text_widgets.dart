import 'package:flutter/material.dart';

Widget text24Normal({String text=""}) {
  return  Text(text
    ,
    style: TextStyle(
      color: Colors.blue,
      fontSize: 24,
      fontWeight: FontWeight.normal,
    ),
  );
}

Widget text24Bold() {
  return const Text(
    '',
    style: TextStyle(
      color: Colors.blue,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
  );
}