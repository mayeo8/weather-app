import 'package:flutter/material.dart';
import 'package:weather/utilities/constants.dart';
import 'package:weather/services/weather.dart';
import 'package:weather/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, this.locationWeather});
  final dynamic locationWeather;
  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int? temperature;
  String? weatherIcon;
  String? cityName;
  String? message;
  String? weatherType;
  IconData? weatherIcons;
  String degree = '°';
  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        message = 'Unable to get weather data';
        weatherIcon = 'Error';
        cityName = 'Unknown location';
        weatherType = 'Error';
        weatherIcons = Icons.error;
        degree = '';
        return;
        //you can also use a else block as well
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      message = weather.getMessage(temperature!);
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherIcons = weather.getWeatherIcons(condition);
      cityName = weatherData['name'];
      weatherType = weatherData['weather'][0]['main'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 9,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.zero,
                    bottom: Radius.circular(80.0),
                  ),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.blue.shade900,
                        Colors.purple.shade900,
                        Colors.deepPurple.shade700,
                      ]),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 35.0,
                          ),
                          Text(
                            '$cityName',
                            style: const TextStyle(
                              fontSize: 30.0,
                              fontFamily: 'QuicksandBold',
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Icon(
                        weatherIcons,
                        size: 300.0,
                        color: Colors.white,
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          textBaseline: TextBaseline.alphabetic,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 180.0,
                              child: Text(
                                temperature.toString(),
                                style: kTempTextStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Text(
                              degree,
                              style: const TextStyle(
                                fontSize: 60.0,
                                height: 0.6,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '$weatherType',
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'Spartan MB',
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () async {
                              var weatherData =
                                  await weather.getLocationWeather();
                              updateUI(weatherData);
                            },
                            child: const Icon(
                              Icons.my_location_outlined,
                              size: 50.0,
                              color: Colors.white,
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              var typedName = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const CityScreen();
                                  },
                                ),
                              );
                              if (typedName != null) {
                                var weatherData =
                                    await weather.getCityWeather(typedName);
                                updateUI(weatherData);
                              }
                            },
                            style: const ButtonStyle(),
                            child: const Icon(
                              Icons.location_city_outlined,
                              size: 50.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              flex: 1,
              child: Center(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Text(
                    '$message',
                    style: const TextStyle(
                      fontSize: 30.0,
                      fontFamily: 'Spartan MB',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     TextButton(
            //       onPressed: () async {
            //         var weatherData = await weather.getLocationWeather();
            //         updateUI(weatherData);
            //       },
            //       child: const Icon(
            //         Icons.my_location,
            //         size: 50.0,
            //         color: Colors.white,
            //       ),
            //     ),
            //     TextButton(
            //       onPressed: () async {
            //         var typedName = await Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) {
            //               return const CityScreen();
            //             },
            //           ),
            //         );
            //         if (typedName != null) {
            //           var weatherData =
            //               await weather.getCityWeather(typedName);
            //           updateUI(weatherData);
            //         }
            //       },
            //       child: const Icon(
            //         Icons.location_city,
            //         size: 50.0,
            //         color: Colors.white,
            //       ),
            //     ),
            //   ],
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 15.0),
            //   child: Text(
            //     "$message in $cityName",
            //     textAlign: TextAlign.left,
            //     style: kMessageTextStyle,
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 15.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       Text(
            //         weatherIcon!,
            //         style: kConditionTextStyle,
            //       ),
            //       Row(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         textBaseline: TextBaseline.alphabetic,
            //         children: [
            //           Text(
            //             '$temperature',
            //             style: kTempTextStyle,
            //           ),
            //           const Padding(
            //             padding: EdgeInsets.fromLTRB(0.0, 30.0, 10.0, 0.0),
            //             child: Text(
            //               '°c',
            //               style: TextStyle(
            //                 fontSize: 40.0,
            //               ),
            //             ),
            //           ),
            //         ],
            //       )
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
