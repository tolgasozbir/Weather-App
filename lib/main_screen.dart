import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/weather.dart';
import 'dart:convert';
class MainScreen extends StatefulWidget {
  const MainScreen({ Key? key }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  Weather? weather;
  String? image;

  String apiKey="";

  @override
  void initState() {
    super.initState();
    getWeather("gebze");
  }

  Future<void> getWeather(String city) async {
    var url=Uri.parse("http://api.weatherapi.com/v1/current.json?key=${apiKey}&q=${city}&aqi=no&lang=tr");
    var response = await http.get(url);
    this.weather = await weatherFromJson(response.body);
    
    print(weather?.current?.condition?.icon);
    print(utf8convert(weather!.current!.condition!.text));
    
    setState(() { });
  }

  String utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          weather == null ? CircularProgressIndicator() : Image.network("http:"+weather!.current!.condition!.icon)
        ],
      ),
    );
  }
}