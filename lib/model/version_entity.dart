import 'package:digital_train/generated/json/base/json_field.dart';
import 'package:digital_train/generated/json/version_entity.g.dart';
import 'dart:convert';

import 'package:flutter_nb_net/flutter_net.dart';
export 'package:digital_train/generated/json/version_entity.g.dart';

@JsonSerializable()
class VersionEntity extends BaseNetModel {
	@JSONField(name: "ID")
	late String iD;
	late String key;
	late VersionValues values;


	VersionEntity({String? iD, String? key, VersionValues? values}) :
				iD = iD ?? '',
				key = key ?? '',
				values = values ?? VersionValues();

  @override
	fromJson(Map<String, dynamic> json) {
		return VersionEntity.fromJson(json);
	}
	factory VersionEntity.fromJson(Map<String, dynamic> json) => $VersionEntityFromJson(json);

	Map<String, dynamic> toJson() => $VersionEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class VersionValues extends BaseNetModel {
	late String update;
	late String url;
	late String version;


	VersionValues({String? update, String? url, String? version})
	:update = update ?? '',
				url = url ?? '',
				version = version ?? '';

  @override
	fromJson(Map<String, dynamic> json) {
		return VersionValues.fromJson(json);
	}
	factory VersionValues.fromJson(Map<String, dynamic> json) => $VersionValuesFromJson(json);

	Map<String, dynamic> toJson() => $VersionValuesToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}