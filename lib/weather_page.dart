import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String apiKey = 'd06760e345d3a27f7d4a2e75a363a631';
  String city = 'Rabat'; // Default city
  late String weather;
  late String weatherCondition;
  bool isLoading = true;

  List<String> cities = ['Rabat', 'Casablanca', 'Marrakech', 'Tangier', 'Agadir', 'Fez', 'Oujda', 'Laayoune', 'Dakhla', 'Kenitra', 'Khenifra', 'Meknes', 'Mohammedia', 'Ouarzazate', 'Safi', 'Sale', 'Settat', 'Skhirat', 'Tetouan', 'Zagora', 'El Jadida', 'Beni Mellal', 'Errachidia', 'Essaouira'];

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    try {
      final response = await http.get(Uri.parse(
          'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          weather = '${data['name']} Weather: ${data['weather'][0]['main']}';
          weather += '\nTemperature: ${data['main']['temp']}°C';
          weather += '\nMin Temperature: ${data['main']['temp_min']}°C';
          weather += '\nMax Temperature: ${data['main']['temp_max']}°C';
          weather += '\nHumidity: ${data['main']['humidity']}%';
          weatherCondition = data['weather'][0]['main']; // Set weather condition
          isLoading = false;
        });
      } else {
        setState(() {
          weather = 'Failed to load weather data (${response.statusCode})';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        weather = 'Failed to load weather data (${e.toString()})';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Select City',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: city,
              onChanged: (String? newValue) {
                setState(() {
                  city = newValue!;
                  fetchWeather();
                });
              },
              items: cities.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Text(
              'Current Weather in $city',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _getWeatherIcon(weatherCondition),
            const SizedBox(height: 20),
            Text(
              weather,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getWeatherIcon(String weatherCondition) {
    IconData iconData;
    Color color;

    switch (weatherCondition) {
      case 'Clear':
        iconData = Icons.wb_sunny;
        color = Colors.orange;
        break;
      case 'Clouds':
        iconData = Icons.cloud;
        color = Colors.grey;
        break;
      case 'Rain':
        iconData = Icons.grain;
        color = Colors.blue;
        break;
      case 'Drizzle':
        iconData = Icons.grain;
        color = Colors.lightBlue;
        break;
      case 'Thunderstorm':
        iconData = Icons.flash_on;
        color = Colors.deepPurple;
        break;
      case 'Snow':
        iconData = Icons.ac_unit;
        color = Colors.lightBlueAccent;
        break;
      default:
        iconData = Icons.wb_cloudy;
        color = Colors.grey;
    }
    return Icon(iconData, size: 100, color: color);
  }
}
