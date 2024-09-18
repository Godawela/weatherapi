import 'package:flutter/material.dart';
import 'package:weatherapp/Models/weathermodel.dart';
import 'package:weatherapp/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State <WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  //api key
  final _weatherService = WeatherService('bc9e956e963996bca3ef3acc31f6278e'
);

  Weathermodel? _weather;

  //fetch weather
  _fetchWeather() async {

    //get the current city
      String cityName = await _weatherService.getCurrentCity();
    //get weather for city

      try{
        final WeatherModel= await _weatherService.getWeather(cityName);

        setState(() {
          _weather =WeatherModel;
        });
      }

      //any error

      catch(e){
        print(e);
      }
  }
  //weather animations

  //int state

  @override
  void initState(){
    super.initState();

    //fetch weather on start up
    _fetchWeather();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          //city name
          Text(_weather?.cityName ?? "loading"),

          //temp
          Text('${_weather?.temperature.round()}*C')
        ],
      ),
    )
    );
  }
}