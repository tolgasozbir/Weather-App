import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/utils.dart';

class SharedData {
    Future<void> setValue(TempCityName city) async {
    var sp= await SharedPreferences.getInstance();
    sp.setString(city.id, city.name);
  }

  Future<void> setValues(List<TempCityName> allCities) async {
    var sp= await SharedPreferences.getInstance();
    for (var item in allCities) {
      sp.setString(item.id, item.name);
    }
  }

  Future<void> getValues(List<TempCityName> allCities) async {
    var sp= await SharedPreferences.getInstance();
    int counter=0;
    for (var item in allCities) {
      counter++;
        switch (counter) {
          case 1: item.name = sp.getString(item.id) ?? "Kocaeli"; break;
          case 2: item.name = sp.getString(item.id) ?? "Istanbul"; break;
          case 3: item.name = sp.getString(item.id) ?? "Ankara"; break;
          case 4: item.name = sp.getString(item.id) ?? "New York"; break;
          case 5: item.name = sp.getString(item.id) ?? "Paris"; break;
        }
    }
  }
}