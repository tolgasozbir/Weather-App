import 'package:flutter/material.dart';
import 'package:weather_app/Api.dart';
import 'package:weather_app/context_extension.dart';

import 'package:weather_app/weather.dart';
import 'dart:convert';
class MainScreen extends StatefulWidget {
  const MainScreen({ Key? key }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  Api _api = Api();

  String utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: weatherData()
      ),
    );
  }

  Widget weatherData() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded( flex: 10, child: mainCity()),
          Spacer(flex: 1,),
          Align(alignment: Alignment.center, child: Text("Other Citys",style: context.theme.textTheme.headline6)),
          Expanded( flex: 15, child: otherCities(),
          )
        ],
      ),
    );
  }

  FutureBuilder<Weather> mainCity() {
    return FutureBuilder<Weather>(
      future: _api.getWeather("gebze"),
      builder: (context, snapshot) {
        if (snapshot.hasData) {  
          Weather? _weather = snapshot.data;
          return cardMainCityWeather(_weather!);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Text("Await for data");
      },
    );
  }

  Container otherCities() {
    return Container(
      width: context.dynamicWidth(0.85),
      decoration: BoxDecoration(
        color: Colors.blue.shade100, 
        borderRadius: BorderRadius.all(Radius.circular(24))
      ),
      child: Column(
        children: [
          Expanded( flex: 8, child: otherCitiesTop()),                   
          Spacer(flex: 1,),
          Expanded(flex: 8, child: otherCitiesBottom())       
        ],
      ),
    );
  }

  Row otherCitiesTop() {
    return Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(flex: 12, child: futureBuilderCity("İstanbul")),
        Spacer(),
        Expanded(flex: 12, child: futureBuilderCity("Ankara"))
      ],
    );
  }

  Row otherCitiesBottom() {
    return Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(flex: 16, child: futureBuilderCity("New york")),
        Spacer(),
        Expanded(flex: 16, child: futureBuilderCity("Paris"))
      ],
    );
  }

  FutureBuilder<Weather> futureBuilderCity(String city) {
    return FutureBuilder<Weather>(
      future: _api.getWeather(city),
      builder: (context, snapshot) {
        if (snapshot.hasData) {  
          Weather? _weather = snapshot.data;
          return otherCityCard(_weather!);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Text("Await for data");
      },
    );
  }

  Widget otherCityCard(Weather? weatherOther) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue, 
        borderRadius: BorderRadius.all(Radius.circular(24))
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(weatherOther!.location!.name,style: context.theme.textTheme.headline5!.copyWith(fontWeight: FontWeight.w600)),
                SizedBox(width: context.dynamicWidth(0.16), child: Image.network("http:"+weatherOther.current!.condition!.icon,fit: BoxFit.cover,)),
              ],
            ),
            Positioned(bottom: 0, right: 0, child: Text(weatherOther.current!.tempC.toString()+"°",style: context.theme.textTheme.headline4)),
          ],
        ),
      ),
    );
  }

  Container cardMainCityWeather(Weather weather) {
    String weatherText = utf8convert(weather.current!.condition!.text);
    return Container(
          width: context.dynamicWidth(0.85),
          decoration: BoxDecoration(
            color: Colors.blue, 
            borderRadius: BorderRadius.all(Radius.circular(24))
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(width: context.dynamicWidth(0.32), child: Image.network("http:"+weather.current!.condition!.icon,fit: BoxFit.contain,)),
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(weather.location!.region,style: context.theme.textTheme.headline4!.copyWith(color: Color(0xBF000000),fontWeight: FontWeight.w500)),
                            Text(weatherText),
                          ],
                        ),
                      ),
                      Text(weather.current!.tempC.toInt().toString()+"°",style: context.theme.textTheme.headline2)
                    ],
                  ),
                ),
      
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        SizedBox(width: context.dynamicWidth(0.12), child: Image.asset("assets/temp.png")),
                        Text("feels like",style: context.theme.textTheme.headline6),
                        Text(weather.current!.feelslikeC.toString()+"°",style: context.theme.textTheme.headline6!.copyWith(fontWeight: FontWeight.normal)),
                      ],
                    ),                    
                    
                    Column(
                      children: [
                        SizedBox(width: context.dynamicWidth(0.12), child: Image.asset("assets/wind.png")),
                        Text("Wind",style: context.theme.textTheme.headline6),
                        Text(weather.current!.windKph.toString()+" km/h",style: context.theme.textTheme.headline6!.copyWith(fontWeight: FontWeight.normal)),
                      ],
                    ),                    
                    
                    Column(
                      children: [
                        SizedBox(width: context.dynamicWidth(0.12), child: Image.asset("assets/humidity.png")),
                        Text("Humidity",style: context.theme.textTheme.headline6),
                        Text(weather.current!.humidity.toString()+" %",style: context.theme.textTheme.headline6!.copyWith(fontWeight: FontWeight.normal)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
  }
}