
class Main {

  var temp;
  double feels_like;
  double temp_min;
  double temp_max;
  int pressure;
  int humidity;

	Main.fromJsonMap(Map<String, dynamic> map): 
		temp = map["temp"],
		feels_like = map["feels_like"],
		temp_min = map["temp_min"],
		temp_max = map["temp_max"],
		pressure = map["pressure"],
		humidity = map["humidity"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['temp'] = temp;
		data['feels_like'] = feels_like;
		data['temp_min'] = temp_min;
		data['temp_max'] = temp_max;
		data['pressure'] = pressure;
		data['humidity'] = humidity;
		return data;
	}
}
