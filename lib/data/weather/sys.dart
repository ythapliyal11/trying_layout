
class Sys {

  int type;
  int id;
  String country;
  int sunrise;
  int sunset;

	Sys.fromJsonMap(Map<String, dynamic> map): 
		type = map["type"],
		id = map["id"],
		country = map["country"],
		sunrise = map["sunrise"],
		sunset = map["sunset"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['type'] = type;
		data['id'] = id;
		data['country'] = country;
		data['sunrise'] = sunrise;
		data['sunset'] = sunset;
		return data;
	}
}
