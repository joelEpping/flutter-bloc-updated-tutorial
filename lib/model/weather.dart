import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Weather extends Equatable {
  final String cityName;
  final double temperature;
  final bool isFake;

  Weather( {
    @required this.cityName,
    @required this.temperature,
    @required this.isFake
  }) : super([cityName, temperature,isFake]);
}
