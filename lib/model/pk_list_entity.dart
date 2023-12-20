import 'package:digital_train/generated/json/base/json_field.dart';
import 'package:digital_train/generated/json/pk_list_entity.g.dart';
import 'dart:convert';

import 'package:flutter_nb_net/flutter_net.dart';
export 'package:digital_train/generated/json/pk_list_entity.g.dart';

@JsonSerializable()
class PkListEntity extends BaseNetModel {
  @JSONField(name: "ID")
  late String iD;
  late String category;
  late String department;
  late String nickname;
  late int scores;

  PkListEntity({String? iD, String? category, String? department, String? nickname, int? scores})
      : iD = iD ?? '',
        category = category ?? '',
        department = department ?? '',
        nickname = nickname ?? '',
        scores = scores ?? 0;

  @override
  PkListEntity fromJson(Map<String, dynamic> json) {
    return PkListEntity.fromJson(json);
  }

  factory PkListEntity.fromJson(Map<String, dynamic> json) => $PkListEntityFromJson(json);

  Map<String, dynamic> toJson() => $PkListEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
