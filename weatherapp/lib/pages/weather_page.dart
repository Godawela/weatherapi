import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/Models/weathermodel.dart';
import 'package:weatherapp/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // API key
  final _weatherService = WeatherService('bc9e956e963996bca3ef3acc31f6278e');
  Weathermodel? _weather;

  // Fetch weather
  _fetchWeather() async {
    // Get the current city
    String cityName = await _weatherService.getCurrentCity();
    // Get weather for the city
    try {
      final WeatherModel = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = WeatherModel;
      });
    } catch (e) {
      print(e);
    }
  }

// weather animations
String getWeatherAnimation(String? mainCondition) {
if (mainCondition == null) return 'assets/sunny.json'; // default to sunny

switch (mainCondition. toLowerCase()) {
  case 'clouds':
  case 'mist':
  case 'smoke':
  case 'haze':
  case 'dust':
  case 'fog':
  case 'few clouds':
  case 'overcast clouds':
  case 'broken clouds':
    return 'assets/cloud.json';
  case 'rain':
  case 'drizzle':
  case 'shower rain':
    return 'assets/rain.json';
  case 'thunderstorm':
    return 'assets/thunder.json';
  case 'clear':
    return 'assets/sunny.json';
  default:
    return 'assets/sunny.json';

}
}

  @override
  void initState() {
    super.initState();
    // Fetch weather on start up
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
     
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Icon(
                Icons.location_on,
                color: const Color.fromARGB(255, 240, 246, 240),
                size: 60,
            ),
            // City name
            Text(_weather?.cityName ?? "Loading...",
            style: TextStyle(color: Colors.white,fontSize: 30,),  // Set font color to white
            
            ),
            // Animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),  // Relative path to asset
            // Temperature
            Text('${_weather?.temperature.round()}°C',
            style: TextStyle(color: Colors.white,fontSize: 25,),  // Set font color to white
            ),

            //weather condition

            Text(_weather?.mainCondition?? "",
            style: TextStyle(color: Colors.white),  // Set font color to white
            ),
          ],
        ),
      ),
    );
  }
}
