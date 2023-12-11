import 'package:digital_train/generated/json/base/json_field.dart';
import 'package:digital_train/generated/json/test_result_entity.g.dart';
import 'dart:convert';

import 'package:flutter_nb_net/flutter_net.dart';
export 'package:digital_train/generated/json/test_result_entity.g.dart';

@JsonSerializable()
class TestResultEntity extends BaseNetModel {
  @JSONField(name: "ID")
  String? iD;
  String? userId;
  int? scores;

  TestResultEntity();

  factory TestResultEntity.fromJson(Map<String, dynamic> json) => $TestResultEntityFromJson(json);

  Map<String, dynamic> toJson() => $TestResultEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }

  @override
  TestResultEntity fromJson(Map<String, dynamic> json) {
    return TestResultEntity.fromJson(json);
  }
}
