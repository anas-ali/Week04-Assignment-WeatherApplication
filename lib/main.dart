import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/WeatherDetailModels.dart';
import 'network/NetworkService.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<WeatherDetail> post;
  NetworkService networkService;

  @override
  void initState() {
    super.initState();
    networkService = NetworkService();
    post = networkService.fetchWeatherDetails();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: FutureBuilder<WeatherDetail>(
              future: post,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _buildWeatherUI(snapshot.data);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // By default, show a loading spinner.
                return CircularProgressIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherUI(WeatherDetail data) {
    String _degreeSymbol = '°';
    String _temperature = data.main.temperature.toString();
    String _lowest = (data.main.minTemp - 3).toString();
    String _highest = (data.main.maxTemp + 4).toString();
    String _feelsLike = data.main.feelsLike.toInt().toString();
    String _desc = data.weather.first.toString();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Align(
            alignment: Alignment.topRight,
            child: IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: Color(0xFF343334).withOpacity(0.75),
                ),
                onPressed: () {
                  setState(() {
                    post = networkService.fetchWeatherDetails();
                  });
                })),
        Expanded(child: Container()),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: _temperature,
              style: TextStyle(
                color: Colors.black,
                fontSize: 50,
                fontWeight: FontWeight.w700,
                fontFamily: 'Montserrat',
              ),
              children: [
                TextSpan(
                  text: _degreeSymbol,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 60,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Montserrat',
                  ),
                ),
                TextSpan(
                  text: 'C',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 50,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ]),
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: '$_lowest.0 - $_highest.0',
              style: TextStyle(
                color: Color(0xFF343334).withOpacity(0.75),
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'Montserrat',
              ),
              children: [
                TextSpan(
                  text: _degreeSymbol,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat',
                  ),
                ),
                TextSpan(
                  text: 'C',
                  style: TextStyle(
                    color: Color(0xFF343334).withOpacity(0.75),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat',
                  ),
                )
              ]),
        ),
        Text(
          _desc,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 50,
            color: Colors.red,
            fontWeight: FontWeight.w700,
            fontFamily: 'Montserrat',
          ),
        ),
        Text(
          'Karachi',
          style: TextStyle(
            color: Color(0xFF343334).withOpacity(0.75),
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat',
          ),
        ),
        Text(
          'PK',
          style: TextStyle(
            color: Color(0xFF343334).withOpacity(0.75),
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat',
          ),
        ),
        Expanded(child: Container()),
      ],
    );
  }
}