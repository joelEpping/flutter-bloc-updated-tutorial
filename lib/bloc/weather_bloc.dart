import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:bloc_updated_tutorial/model/weather.dart';
import './bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  @override
  WeatherState get initialState => WeatherInitial();

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    // Distinguish between different events, even though this app has only one
    if (event is GetWeather) {
      // Outputting a state from the asynchronous generator
      yield WeatherLoading();
      final weather = await _fetchWeatherFromRealApi(event.cityName);
      yield WeatherLoaded(weather);
    }
  }

  Future<Weather> _fetchWeatherFromRealApi(String cityName) {
    // Simulate network delay
    //To get a valid apikey go to https://www.apixu.com 
    return Future.delayed(
      Duration(seconds: 1),
      () async{
        var apiKey = 'THIS IS NOT A VALID API KEY';
        var url = "http://api.apixu.com/v1/current.json?q=${cityName}&key=${apiKey}";

        // Await the http get response, then decode the json-formatted responce.
        var response = await http.get(url);
        if (response.statusCode == 200) {
          var jsonResponse = convert.jsonDecode(response.body);
          //print('response: '+jsonResponse.toString());
          var tempInCelcius = jsonResponse['current']['temp_c'];
          print("la temperatura es: $tempInCelcius.");
          if(tempInCelcius != null){
            return Weather(cityName: cityName,temperature: tempInCelcius);
          }
        } else {
          //if you dont get a valid api key it will generated a random value.
          print("Request failed with status: ${response.statusCode}.");
           return Weather(
          cityName: cityName,
          // Temperature between 20 and 35.99
          temperature: 20 + Random().nextInt(15) + Random().nextDouble(),
        );
        }
      },
    );
  }
}
