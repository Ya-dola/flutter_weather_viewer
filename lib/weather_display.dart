// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeatherDisplay extends StatelessWidget {
  final String weatherData;

  const WeatherDisplay({super.key, required this.weatherData});

  String capitalizeWords(String description) {
    List<String> words = description.split(' ');

    for (int i = 0; i < words.length; i++) {
      words[i] = '${words[i][0].toUpperCase()}${words[i].substring(1)}';
    }

    return words.join(' ');
  }

  @override
  Widget build(BuildContext context) {
    // Parse the JSON data and extract relevant information
    Map<String, dynamic> data = jsonDecode(weatherData);

    String temperature = data['main']['temp'].toString();
    String description = data['weather'][0]['description'];
    String city = data['name'];

    return Card(
      elevation: 3.0,
      margin: EdgeInsets.all(16.0),
      color: Color(0xffeee2fa),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              'Weather for $city',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.thermostat_rounded,
                  size: 48,
                  color: CupertinoColors.systemPurple,
                ),
                SizedBox(width: 4),
                Text(
                  '$temperature °C',
                  style: TextStyle(fontSize: 32),
                )
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.info,
                  size: 28,
                ),
                SizedBox(width: 4),
                Text(
                  capitalizeWords(description),
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
