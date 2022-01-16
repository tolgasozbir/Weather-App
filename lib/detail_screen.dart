import 'package:flutter/material.dart';
import 'package:weather_app/context_extension.dart';
import 'package:weather_app/main_screen.dart';
import 'package:weather_app/shared_preferences.dart';
import 'package:weather_app/utils.dart';
import 'package:weather_app/weather.dart';
import 'package:http/http.dart' as http;

class DetailScreen extends StatefulWidget {
  DetailScreen({required this.weather, required this.tempCity, Key? key }) : super(key: key);

  Weather weather;
  TempCityName tempCity;

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
    temp=widget.weather;
    Future.delayed(const Duration(milliseconds: 500), () {
      
      setState(() {
        if (widget.weather.current!.feelslikeC<0) {
          feelsLikeC +=-widget.weather.current!.feelslikeC*5;
        }else{
          feelsLikeC +=widget.weather.current!.feelslikeC*5;
        }
        windSpeed += widget.weather.current!.windKph*5;
        humidity += widget.weather.current!.humidity*(context.dynamicHeight(0.3)/100);

        //TODO: max values context.dynamicHeight(0.3)
        if (feelsLikeC<20) {
          feelsLikeC=20;
        }
        if (feelsLikeC>context.dynamicHeight(0.3)) {
          feelsLikeC=context.dynamicHeight(0.3);
        }
        if (windSpeed<20) {
          windSpeed=20;
        }    
        if (windSpeed>context.dynamicHeight(0.3)) {
          windSpeed=context.dynamicHeight(0.3);
        }
      });
    });
    
  }


  bool isSearch=false;
  TextEditingController tfController = TextEditingController();
  late Weather temp;

  checkCity(String city) async {
    String _apiKey="f56ba9a7740648168f9192842210210";
    try {
      var url=Uri.parse("http://api.weatherapi.com/v1/current.json?key=${_apiKey}&q=${city}&aqi=no&lang=tr");
      var response = await http.get(url);
      temp=weatherFromJson(response.body);
      if (temp.location?.region != null) {
        widget.tempCity.name = temp.location!.region;
        widget.weather = temp;
        SharedData().setValue(widget.tempCity);
      }else{
        temp=widget.weather;
      }
      setState(() { });
    } catch (e) {
      print(e);
    }
  }

  void refreshAndBack(){
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>MainScreen()),
    (Route<dynamic> route) => false).then((_) => setState(() { }));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        isSearch=false;
      },
      child: WillPopScope(
        onWillPop: () async {
          refreshAndBack();
          return true;
        },
        child: Scaffold(
          backgroundColor: Color(0xffCBE6F9),
          //extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: BackButton(color: Colors.black, onPressed: (){
      
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>MainScreen()),
            (Route<dynamic> route) => false).then((_) => setState(() { }));
      
            }),
            centerTitle: true,
            title: isSearch==false ? searchText() : searchTextField(),
            actions: [
              IconButton(
                icon : Icon(Icons.search,color: Colors.black,),
                onPressed: (){
                  isSearch = !isSearch;
                  checkCity(tfController.text);
                  setState(() {});
                  tfController.text="";
                },
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SafeArea(child: body()),
          ),
        ),
      ),
    );
  }

  Text searchText() => Text("Search",style: TextStyle(color: Colors.black),);

  TextField searchTextField() {
    return TextField(
      controller: tfController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Search"
      ),
      onSubmitted: (value){
        checkCity(value);
        FocusScope.of(context).unfocus();
        isSearch=false;
        setState(() {});
        tfController.text="";
      },
    );
  }

  Widget body() {
    return Center(
      child: Column(
        children: [
          Text(utf8convert(widget.weather.current!.condition!.text),style: context.theme.textTheme.headline5!.copyWith(color: Color(0xff43656A))),
          Text(widget.weather.location!.name.toString(),style: context.theme.textTheme.headline4!.copyWith(color: Color(0xff43656A))),
          Text(widget.weather.current!.tempC.toInt().toString()+"°",style: context.theme.textTheme.headline3!.copyWith(color: Color(0xff43656A))),
          Expanded(flex: 8, child: Image.network("http:"+widget.weather.current!.condition!.icon, fit: BoxFit.cover)),
          Expanded(flex: 10, child: statusBars())
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
        Expanded(child: stackContain(animContain)),
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