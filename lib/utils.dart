import 'dart:convert';
import 'package:flutter/material.dart';

class TempCityName {
  late String id;
  late String name;
  TempCityName(this.id, this.name);
}

TempCityName firstCity = TempCityName("1","Kocaeli");
TempCityName otherCity1 = TempCityName("2","Istanbul");
TempCityName otherCity2 = TempCityName("3","Ankara");
TempCityName otherCity3 = TempCityName("4","New York");
TempCityName otherCity4 = TempCityName("5","Paris");

List<TempCityName> allCities = [firstCity,otherCity1,otherCity2,otherCity3,otherCity4];

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