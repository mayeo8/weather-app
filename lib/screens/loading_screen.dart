import 'package:flutter/material.dart';
import 'package:weather/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather/services/weather.dart';
import 'package:weather/utilities/constants.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentLocationData();
  }

  void pushWeatherData(dynamic data) {
    if (data == null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const LocationScreen();
      }));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LocationScreen(locationWeather: data);
      }));
    }
  }

  void getCurrentLocationData() async {
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getLocationWeather();
    if (weatherData == null) {
      pushWeatherData(null);
    } else {
      pushWeatherData(weatherData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade900,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue.shade900,
                Colors.purple.shade900,
                Colors.deepPurple.shade700
              ]),
          image: const DecorationImage(
            image: AssetImage('images/wait3.gif'),
            fit: BoxFit.contain,
            alignment: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Expanded(
              flex: 4,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text('We are Retrieving your data right now',
                      style: kMessageTextStyle),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(''),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 40.0),
              child: Expanded(
                flex: 5,
                child: Text(''),
                // child: SpinKitPouringHourGlass(
                //   color: Colors.yellow.shade700,
                //   size: 50.0,
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
