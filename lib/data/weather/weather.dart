
class Weather {

  int id;
  String main;
  String description;
  String icon;

	Weather.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		main = map["main"],
		description = map["description"],
		icon = map["icon"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['main'] = main;
		data['description'] = description;
		data['icon'] = icon;
		return data;
	}
}
