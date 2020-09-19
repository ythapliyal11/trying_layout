import 'package:trying_layout/data/weather/coord.dart';
import 'package:trying_layout/data/weather/weather.dart';
import 'package:trying_layout/data/weather/main.dart';
import 'package:trying_layout/data/weather/wind.dart';
import 'package:trying_layout/data/weather/clouds.dart';
import 'package:trying_layout/data/weather/sys.dart';

class Weatherentity {

  Coord coord;
  List<Weather> weather;
  String base;
  Main main;
  int visibility;
  Wind wind;
  Clouds clouds;
  int dt;
  Sys sys;
  int timezone;
  int id;
  String name;
  int cod;

	Weatherentity.fromJsonMap(Map<String, dynamic> map): 
		coord = Coord.fromJsonMap(map["coord"]),
		weather = List<Weather>.from(map["weather"].map((it) => Weather.fromJsonMap(it))),
		base = map["base"],
		main = Main.fromJsonMap(map["main"]),
		visibility = map["visibility"],
		wind = Wind.fromJsonMap(map["wind"]),
		clouds = Clouds.fromJsonMap(map["clouds"]),
		dt = map["dt"],
		sys = Sys.fromJsonMap(map["sys"]),
		timezone = map["timezone"],
		id = map["id"],
		name = map["name"],
		cod = map["cod"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['coord'] = coord == null ? null : coord.toJson();
		data['weather'] = weather != null ? 
			this.weather.map((v) => v.toJson()).toList()
			: null;
		data['base'] = base;
		data['main'] = main == null ? null : main.toJson();
		data['visibility'] = visibility;
		data['wind'] = wind == null ? null : wind.toJson();
		data['clouds'] = clouds == null ? null : clouds.toJson();
		data['dt'] = dt;
		data['sys'] = sys == null ? null : sys.toJson();
		data['timezone'] = timezone;
		data['id'] = id;
		data['name'] = name;
		data['cod'] = cod;
		return data;
	}
}
