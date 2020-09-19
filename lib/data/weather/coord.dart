
class Coord {

  double lon;
  double lat;

	Coord.fromJsonMap(Map<String, dynamic> map): 
		lon = map["lon"],
		lat = map["lat"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['lon'] = lon;
		data['lat'] = lat;
		return data;
	}
}
