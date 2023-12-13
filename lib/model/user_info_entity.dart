import 'package:digital_train/generated/json/base/json_field.dart';
import 'package:digital_train/generated/json/user_info_entity.g.dart';
import 'dart:convert';

import 'package:flutter_nb_net/flutter_net.dart';
export 'package:digital_train/generated/json/user_info_entity.g.dart';

@JsonSerializable()
class UserInfoEntity extends BaseNetModel {
	@JSONField(name: "ID")
	late String iD;
	String? name;
	String? phone;
	String? headImage;
	String? nickname;
	String? role;
	@JSONField(name: "departmentId")
	String? departmentid;
	int? level;

	UserInfoEntity();

	factory UserInfoEntity.fromJson(Map<String, dynamic> json) => $UserInfoEntityFromJson(json);

	Map<String, dynamic> toJson() => $UserInfoEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}

  @override
  fromJson(Map<String, dynamic> json) {
		return UserInfoEntity.fromJson(json);
  }
}