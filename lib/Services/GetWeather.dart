import 'package:tour_guide_app/Services/ApiDecoder.dart';

const urlbase = 'https://api.openweathermap.org/data/2.5/weather';
const apiKey = '488a4d1974da47d10ffc98ce217011d9';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    ApiDecoder apiDecoder =
        ApiDecoder('$urlbase?q=$cityName&appid=$apiKey&units=metric');
    var weatherData = await apiDecoder.getData();
    return weatherData;
  }

//this function will check the current Coordinates id and compare them to the weather conditiion found at https://openweathermap.org/weather-conditions
//then this will return the corrosponding icon
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }
}
