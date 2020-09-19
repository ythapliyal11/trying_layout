
import 'package:cloud_firestore/cloud_firestore.dart';

class UserEntity {

  String name;
  int age;
  String sex;
  String location;
  bool smoker;
	String id;

	UserEntity(this.name, this.age, this.sex, this.location, this.smoker);

  UserEntity.fromJsonMap(DocumentSnapshot map):
		name = map.data()["name"],
		age = map.data()["age"],
		sex = map.data()["sex"],
		location = map.data()["location"],
		smoker = map.data()["smoker"],
		id = map.id;


	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = name;
		data['age'] = age;
		data['sex'] = sex;
		data['location'] = location;
		data['smoker'] = smoker;
		return data;
	}
}
