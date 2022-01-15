import 'dart:convert';
import 'package:flutter/material.dart';

String utf8convert(String text) {
  List<int> bytes = text.toString().codeUnits;
  return utf8.decode(bytes);
}

Widget customCircleIndicator(){
  return Container(
    child: Center(child: CircularProgressIndicator()),
    decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xff80A0CC),
            blurRadius: 8.0,
            spreadRadius: 4.0,
          )
        ],
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF30AAFF), Color(0xffbfe1ff)]),
        borderRadius: BorderRadius.all(Radius.circular(24))),
  );
}
