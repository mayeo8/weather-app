import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/services/location.dart';
import 'package:weather/services/networking.dart';

String apiKey = '9863e79ce8b7578d31e29d2333369d7d';
const openWeatherMap = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    var url = '$openWeatherMap?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url: url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getLocation();
    NetworkHelper networkHelper = NetworkHelper(
        url:
            '$openWeatherMap?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔';
    } else if (condition < 700) {
      return '☃';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀';
    } else if (condition <= 804) {
      return '☁';
    } else {
      return '🤷‍';
    }
  }

  IconData getWeatherIcons(int condition) {
    if (condition < 300) {
      return Icons.cloud;
    } else if (condition < 400) {
      return CupertinoIcons.cloud_bolt_rain;
    } else if (condition < 600) {
      return Icons.umbrella;
    } else if (condition < 700) {
      return CupertinoIcons.cloud_snow_fill;
    } else if (condition < 800) {
      return Icons.cloud;
    } else if (condition == 800) {
      return Icons.wb_sunny;
    } else if (condition <= 804) {
      return Icons.wb_cloudy;
    } else {
      return Icons.warning_amber_outlined;
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
