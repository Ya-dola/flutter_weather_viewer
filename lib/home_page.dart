// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'weather_display.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String weatherData = '';
  final TextEditingController _locationController = TextEditingController();

  Future<String> getWeatherData(String city) async {
    final apiKey = dotenv.env['WEATHER_API_KEY'];
    const apiUrl = 'https://api.openweathermap.org/data/2.5/weather';
    var apiFinalUrl = '$apiUrl?q=$city&appid=$apiKey&units=metric';

    final response = await http.get(Uri.tryParse(apiFinalUrl)!);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      // Handle error
      print('Error: ${response.statusCode}');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Weather Viewer'),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoTextField(
                placeholder: 'Enter City',
                controller: _locationController,
                padding: EdgeInsets.all(12.0),
              ),
              SizedBox(height: 20),
              CupertinoButton.filled(
                onPressed: () async {
                  final res = await getWeatherData(_locationController.text);
                  setState(() {
                    weatherData = res;
                  });
                },
                child: Text('Get Weather'),
              ),
              SizedBox(height: 20),
              if (weatherData == '') ...[
                Text('No Weather Info ${_locationController.text}'),
              ] else ...[
                WeatherDisplay(weatherData: weatherData),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
