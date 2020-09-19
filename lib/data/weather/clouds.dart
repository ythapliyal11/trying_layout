
class Clouds {

  int all;

	Clouds.fromJsonMap(Map<String, dynamic> map): 
		all = map["all"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['all'] = all;
		return data;
	}
}
