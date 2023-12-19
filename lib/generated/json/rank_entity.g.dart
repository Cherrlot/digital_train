import 'package:digital_train/generated/json/base/json_convert_content.dart';
import 'package:digital_train/model/rank_entity.dart';

RankEntity $RankEntityFromJson(Map<String, dynamic> json) {
  final RankEntity rankEntity = RankEntity();
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    rankEntity.userId = userId;
  }
  final String? headImage = jsonConvert.convert<String>(json['headImage']);
  if (headImage != null) {
    rankEntity.headImage = headImage;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    rankEntity.name = name;
  }
  final String? phone = jsonConvert.convert<String>(json['phone']);
  if (phone != null) {
    rankEntity.phone = phone;
  }
  final String? position = jsonConvert.convert<String>(json['position']);
  if (position != null) {
    rankEntity.position = position;
  }
  final int? level = jsonConvert.convert<int>(json['level']);
  if (level != null) {
    rankEntity.level = level;
  }
  final String? nickname = jsonConvert.convert<String>(json['nickname']);
  if (nickname != null) {
    rankEntity.nickname = nickname;
  }
  final int? duration = jsonConvert.convert<int>(json['duration']);
  if (duration != null) {
    rankEntity.duration = duration;
  }
  return rankEntity;
}

Map<String, dynamic> $RankEntityToJson(RankEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['userId'] = entity.userId;
  data['headImage'] = entity.headImage;
  data['name'] = entity.name;
  data['phone'] = entity.phone;
  data['position'] = entity.position;
  data['level'] = entity.level;
  data['nickname'] = entity.nickname;
  data['duration'] = entity.duration;
  return data;
}

extension RankEntityExtension on RankEntity {
  RankEntity copyWith({
    String? userId,
    String? headImage,
    String? name,
    String? phone,
    String? position,
    int? level,
    String? nickname,
    int? duration,
  }) {
    return RankEntity()
      ..userId = userId ?? this.userId
      ..headImage = headImage ?? this.headImage
      ..name = name ?? this.name
      ..phone = phone ?? this.phone
      ..position = position ?? this.position
      ..level = level ?? this.level
      ..nickname = nickname ?? this.nickname
      ..duration = duration ?? this.duration;
  }
}