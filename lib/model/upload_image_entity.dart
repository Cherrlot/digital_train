import 'package:digital_train/generated/json/base/json_field.dart';
import 'package:digital_train/generated/json/upload_image_entity.g.dart';
import 'dart:convert';

import 'package:flutter_nb_net/flutter_net.dart';
export 'package:digital_train/generated/json/upload_image_entity.g.dart';

@JsonSerializable()
class UploadImageEntity extends BaseNetModel{
	String? url;

	UploadImageEntity();

	factory UploadImageEntity.fromJson(Map<String, dynamic> json) => $UploadImageEntityFromJson(json);

	Map<String, dynamic> toJson() => $UploadImageEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}

	@override
	fromJson(Map<String, dynamic> json) {
		return UploadImageEntity.fromJson(json);
	}
}