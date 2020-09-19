
class Wind {

  double speed;
  int deg;
  double gust;

	Wind.fromJsonMap(Map<String, dynamic> map): 
		speed = map["speed"],
		deg = map["deg"],
		gust = map["gust"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['speed'] = speed;
		data['deg'] = deg;
		data['gust'] = gust;
		return data;
	}
}
