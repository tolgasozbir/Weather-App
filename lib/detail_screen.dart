import 'package:flutter/material.dart';
import 'package:weather_app/context_extension.dart';
import 'package:weather_app/utils.dart';
import 'package:weather_app/weather.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({required this.weather, Key? key }) : super(key: key);

  final Weather weather;

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  double feelsLikeC = 20;
  double windSpeed = 20;
  double humidity = 0;


  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        feelsLikeC +=-41;//widget.weather.current!.feelslikeC*5;
        windSpeed += widget.weather.current!.windKph*5;
        humidity += widget.weather.current!.humidity*2;
        //TODO: max values 210
        if (feelsLikeC<=0) {
          feelsLikeC*=-1;
        }

        if (feelsLikeC<=20) {
          feelsLikeC=20;
        }
        if (feelsLikeC>=205) {
          feelsLikeC=205;
        }
        if (windSpeed<=0) {
          windSpeed=20;
        }    
        if (windSpeed>=205) {
          windSpeed=205;
        }
                print(feelsLikeC.toString());

        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffCBE6F9),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(child: body()),
      ),
    );
  }

  Widget body() {
    return Center(
      child: Column(
        children: [
          Text(utf8convert(widget.weather.current!.condition!.text),style: context.theme.textTheme.headline5!.copyWith(color: Color(0xff43656A))),
          Text(widget.weather.location!.name.toString(),style: context.theme.textTheme.headline4!.copyWith(color: Color(0xff43656A))),
          Text(widget.weather.current!.tempC.toInt().toString()+"°",style: context.theme.textTheme.headline3!.copyWith(color: Color(0xff43656A))),
          SizedBox(width: context.dynamicWidth(0.6), child: Image.network("http:"+widget.weather.current!.condition!.icon, fit: BoxFit.cover)),
          Expanded(child: statusBars())
        ],
      ),
    );
  }

  Widget statusBars() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        bar("Feels Like", widget.weather.current!.feelslikeC.toString(), "°", animContainFeelsLike()),
        bar("Wind Speed", widget.weather.current!.windKph.toString(), " km", animContainWind()),
        bar("Humidity", widget.weather.current!.humidity.toString(), " %", animContainHumidity()),
      ], 
    );
  }

  Column bar(String title, String weatherDetail, String symbol, Widget animContain) {
    return Column(mainAxisAlignment: MainAxisAlignment.end,
      children: [
        stackContain(animContain),
        const SizedBox(height: 8,),
        Text(title),
        Text(weatherDetail+"${symbol}",style: context.theme.textTheme.headline6!.copyWith(fontWeight: FontWeight.normal)),
      ],
    );
  }

  Stack stackContain(Widget animatedContainer){
    return Stack(alignment: Alignment.bottomCenter,
      children: [
        backgroundContainer(),
        animatedContainer
      ],
    );
  }


  AnimatedContainer animContainHumidity() {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      width: context.dynamicWidth(0.08),
      height: humidity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xff0046E8),
            blurRadius: 4.0,
            spreadRadius: 4.0,
          )
        ],
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color(0xff2a2a72),
              Color(0xff009ffd)
            ]),
      ),
    );
  }

  AnimatedContainer animContainWind() {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      width: context.dynamicWidth(0.08),
      height: windSpeed,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xff1BEB4C),
            blurRadius: 4.0,
            spreadRadius: 4.0,
          )
        ],
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color(0xff6ED31B),
              Color(0xff1DE18B)
            ]),
      ),
    );
  }

  AnimatedContainer animContainFeelsLike() {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      width: context.dynamicWidth(0.08),
      height: feelsLikeC,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xffF27A06),
            blurRadius: 4.0,
            spreadRadius: 4.0,
          )
        ],
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color(0xffC95A08),
              Color(0xffED9309),
            ]),
      ),
    );
  }

    Container backgroundContainer() {
    return Container(
      width: context.dynamicWidth(0.1),
      height: context.dynamicHeight(0.3),
      decoration: BoxDecoration(
        color: Color(0xff83C6FB),
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }
}