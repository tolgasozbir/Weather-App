// To parse this JSON data, do
//
//     final weather = weatherFromJson(jsonString);

// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

Weather weatherFromJson(String str) => Weather.fromJson(json.decode(str));

String weatherToJson(Weather data) => json.encode(data.toJson());

class Weather {
    Weather({
        required this.location,
        required this.current,
    });

    final Location? location;
    final Current? current;

    factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        current: json["current"] == null ? null : Current.fromJson(json["current"]),
    );

    Map<String, dynamic> toJson() => {
        "location": location == null ? null : location?.toJson(),
        "current": current == null ? null : current?.toJson(),
    };
}

class Current {
    Current({
        required this.tempC,
        required this.isDay,
        required this.condition,
        required this.windKph,
        required this.humidity,
        required this.feelslikeC,
    });

    final double tempC;
    final int isDay;
    final Condition? condition;
    final double windKph;
    final int humidity;
    final double feelslikeC;

    factory Current.fromJson(Map<String, dynamic> json) => Current(
        tempC: json["temp_c"] == null ? null : json["temp_c"],
        isDay: json["is_day"] == null ? null : json["is_day"],
        condition: json["condition"] == null ? null : Condition.fromJson(json["condition"]),
        windKph: json["wind_kph"] == null ? null : json["wind_kph"],
        humidity: json["humidity"] == null ? null : json["humidity"],
        feelslikeC: json["feelslike_c"] == null ? null : json["feelslike_c"],
    );

    Map<String, dynamic> toJson() => {
        "temp_c": tempC == null ? null : tempC,
        "is_day": isDay == null ? null : isDay,
        "condition": condition == null ? null : condition?.toJson(),
        "wind_kph": windKph == null ? null : windKph,
        "humidity": humidity == null ? null : humidity,
        "feelslike_c": feelslikeC == null ? null : feelslikeC,
    };
}

class Condition {
    Condition({
        required this.text,
        required this.icon,
        required this.code,
    });

    final String text;
    final String icon;
    final int code;

    factory Condition.fromJson(Map<String, dynamic> json) => Condition(
        text: json["text"] == null ? null : json["text"],
        icon: json["icon"] == null ? null : json["icon"],
        code: json["code"] == null ? null : json["code"],
    );

    Map<String, dynamic> toJson() => {
        "text": text == null ? null : text,
        "icon": icon == null ? null : icon,
        "code": code == null ? null : code,
    };
}

class Location {
    Location({
        required this.name,
        required this.region,
        required this.country,
        required this.localTime
    });

    final String name;
    final String region;
    final String country;
    final String localTime;

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"] == null ? null : json["name"],
        region: json["region"] == null ? null : json["region"],
        country: json["country"] == null ? null : json["country"],
        localTime: json["localtime"] == null ? null : json["localtime"],
    );

    Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "region": region == null ? null : region,
        "country": country == null ? null : country,
        "localtime": localTime == null ? null : localTime,
    };
}
