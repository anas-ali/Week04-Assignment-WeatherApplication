class WeatherDetail {
  final Main main;
  List<WeatherDesc> weather = List();

  WeatherDetail({this.main, this.weather});

  factory WeatherDetail.fromJson(Map<String, dynamic> json) {
    return WeatherDetail(
        main: Main.fromJson(json['main']),
        weather: (json['weather'] as List)
            .map((weatherDesc) => WeatherDesc.fromJson(weatherDesc))
            .toList());
  }
}

class WeatherDesc {
  final String desc;
  WeatherDesc({this.desc});
  factory WeatherDesc.fromJson(dynamic json) {
    return WeatherDesc(
      desc: json['description'] as String,
    );
  }
  @override
  String toString() {
    return '${desc[0].toUpperCase()}${desc.substring(1)}';
  }
}

class Main {
  final int temperature;
  final int maxTemp;
  final int minTemp;
  final double feelsLike;

  Main({this.temperature, this.maxTemp, this.minTemp, this.feelsLike});
  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
        temperature: json['temp'],
        maxTemp: json['temp_max'],
        minTemp: json['temp_min'],
        feelsLike: json['feels_like']);
  }
}