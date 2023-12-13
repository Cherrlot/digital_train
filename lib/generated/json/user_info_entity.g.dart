import 'package:digital_train/generated/json/base/json_convert_content.dart';
import 'package:digital_train/model/user_info_entity.dart';
import 'package:flutter_nb_net/flutter_net.dart';


UserInfoEntity $UserInfoEntityFromJson(Map<String, dynamic> json) {
  final UserInfoEntity userInfoEntity = UserInfoEntity();
  final String? iD = jsonConvert.convert<String>(json['ID']);
  if (iD != null) {
    userInfoEntity.iD = iD;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    userInfoEntity.name = name;
  }
  final String? phone = jsonConvert.convert<String>(json['phone']);
  if (phone != null) {
    userInfoEntity.phone = phone;
  }
  final String? headImage = jsonConvert.convert<String>(json['headImage']);
  if (headImage != null) {
    userInfoEntity.headImage = headImage;
  }
  final String? nickname = jsonConvert.convert<String>(json['nickname']);
  if (nickname != null) {
    userInfoEntity.nickname = nickname;
  }
  final String? role = jsonConvert.convert<String>(json['role']);
  if (role != null) {
    userInfoEntity.role = role;
  }
  final String? departmentid = jsonConvert.convert<String>(json['departmentId']);
  if (departmentid != null) {
    userInfoEntity.departmentid = departmentid;
  }
  final int? level = jsonConvert.convert<int>(json['level']);
  if (level != null) {
    userInfoEntity.level = level;
  }
  return userInfoEntity;
}

Map<String, dynamic> $UserInfoEntityToJson(UserInfoEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ID'] = entity.iD;
  data['name'] = entity.name;
  data['phone'] = entity.phone;
  data['headImage'] = entity.headImage;
  data['nickname'] = entity.nickname;
  data['role'] = entity.role;
  data['departmentId'] = entity.departmentid;
  data['level'] = entity.level;
  return data;
}

extension UserInfoEntityExtension on UserInfoEntity {
  UserInfoEntity copyWith({
    String? iD,
    String? name,
    String? phone,
    String? headImage,
    String? nickname,
    String? role,
    String? departmentid,
    int? level,
  }) {
    return UserInfoEntity()
      ..iD = iD ?? this.iD
      ..name = name ?? this.name
      ..phone = phone ?? this.phone
      ..headImage = headImage ?? this.headImage
      ..nickname = nickname ?? this.nickname
      ..role = role ?? this.role
      ..departmentid = departmentid ?? this.departmentid
      ..level = level ?? this.level;
  }
}