import 'package:digital_train/generated/json/base/json_field.dart';
import 'package:digital_train/generated/json/login_entity.g.dart';
import 'dart:convert';

import 'package:flutter_nb_net/flutter_net.dart';
export 'package:digital_train/generated/json/login_entity.g.dart';

@JsonSerializable()
class LoginEntity extends BaseNetModel {
	late String token;
	late String authId;
	late String accessToken;

	LoginEntity();

	factory LoginEntity.fromJson(Map<String, dynamic> json) => $LoginEntityFromJson(json);

	Map<String, dynamic> toJson() => $LoginEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}

  @override
	LoginEntity fromJson(Map<String, dynamic> json) {
		return LoginEntity.fromJson(json);
  }
}