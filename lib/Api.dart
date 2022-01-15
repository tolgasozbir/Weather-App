import 'package:weather_app/weather.dart';
import 'package:http/http.dart' as http;

class Api {

  String _apiKey="f56ba9a7740648168f9192842210210";

  Future<Weather> getWeather(String city) async {
    var url=Uri.parse("http://api.weatherapi.com/v1/current.json?key=${_apiKey}&q=${city}&aqi=no&lang=tr");
    var response = await http.get(url);
    return await weatherFromJson(response.body);  
    }
}