import 'package:flutter/material.dart';
import 'package:weather_app/context_extension.dart';
import 'package:weather_app/weather.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({required this.weather, Key? key }) : super(key: key);

  final Weather weather;

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  double feelsLikeC = 0;



  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        feelsLikeC = widget.weather.current!.feelslikeC*30;
        print("object");
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
          Text(widget.weather.location!.localTime.substring(11).toString(),style: context.theme.textTheme.headline3!.copyWith(color: Color(0xff43656A))),
          Text(widget.weather.location!.name.toString(),style: context.theme.textTheme.headline4!.copyWith(color: Color(0xff43656A))),
          Text(widget.weather.current!.tempC.toInt().toString()+"°",style: context.theme.textTheme.headline3!.copyWith(color: Color(0xff43656A))),
          SizedBox(width: context.dynamicWidth(0.6), child: Image.network("http:"+widget.weather.current!.condition!.icon, fit: BoxFit.cover)),
          Expanded(child: Container(color: Colors.deepOrange, child: statusBars()))
        ],
      ),
    );
  }

  Widget statusBars() {
    return Row(
      children: [
        Expanded(
          child: Column(mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //animContain(),
              stackContain(),
              SizedBox(height: 8,),
              Text("Feels like"),
              Text(widget.weather.current!.feelslikeC.toString()+"°",style: context.theme.textTheme.headline6!.copyWith(fontWeight: FontWeight.normal)),
            ],
          ),
        ),
      ], 
    );
  }

  Stack stackContain(){
    return Stack(alignment: Alignment.bottomCenter,
      children: [
        backgroundContainer(),
        animContain(),
      ],
    );
  }

  AnimatedContainer animContain() {
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
      height: 170,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xff83C6FB),
            blurRadius: 4.0,
            spreadRadius: 4.0,
          )
        ],
        borderRadius: BorderRadius.circular(24),
        /*gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color(0xffC95A08),
              Color(0xffED9309),
            ]),*/
      ),
    );
  }
}