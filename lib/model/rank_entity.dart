import 'package:digital_train/generated/json/base/json_field.dart';
import 'package:digital_train/generated/json/rank_entity.g.dart';
import 'dart:convert';

import 'package:flutter_nb_net/flutter_net.dart';
export 'package:digital_train/generated/json/rank_entity.g.dart';

@JsonSerializable()
class RankEntity extends BaseNetModel {
  late String userId;
  late String headImage;
  late String name;
  late String phone;
  /// 职位
  late String position;
  late int level;
  late String nickname;
  late int duration;

  RankEntity(
      {String? userId,
      String? headImage,
      String? name,
      String? phone,
      String? position,
      int? level,
      String? nickname,
      int? duration})
      : userId = userId ?? '',
        headImage = headImage ?? '',
        name = name ?? '',
        phone = phone ?? '',
        position = position ?? '',
        level = level ?? 1,
        nickname = nickname ?? '',
        duration = duration ?? 0;

  String getDisplayName() {
    if(nickname.isNotEmpty) {
      return nickname;
    }
    return name;
  }

  @override
  RankEntity fromJson(Map<String, dynamic> json) {
    return RankEntity.fromJson(json);
  }

  factory RankEntity.fromJson(Map<String, dynamic> json) => $RankEntityFromJson(json);

  Map<String, dynamic> toJson() => $RankEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
