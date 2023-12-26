import 'package:digital_train/generated/json/base/json_convert_content.dart';
import 'package:digital_train/model/version_entity.dart';
import 'package:flutter_nb_net/flutter_net.dart';


VersionEntity $VersionEntityFromJson(Map<String, dynamic> json) {
  final VersionEntity versionEntity = VersionEntity();
  final String? iD = jsonConvert.convert<String>(json['ID']);
  if (iD != null) {
    versionEntity.iD = iD;
  }
  final String? key = jsonConvert.convert<String>(json['key']);
  if (key != null) {
    versionEntity.key = key;
  }
  final VersionValues? values = jsonConvert.convert<VersionValues>(json['values']);
  if (values != null) {
    versionEntity.values = values;
  }
  return versionEntity;
}

Map<String, dynamic> $VersionEntityToJson(VersionEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ID'] = entity.iD;
  data['key'] = entity.key;
  data['values'] = entity.values.toJson();
  return data;
}

extension VersionEntityExtension on VersionEntity {
  VersionEntity copyWith({
    String? iD,
    String? key,
    VersionValues? values,
  }) {
    return VersionEntity()
      ..iD = iD ?? this.iD
      ..key = key ?? this.key
      ..values = values ?? this.values;
  }
}

VersionValues $VersionValuesFromJson(Map<String, dynamic> json) {
  final VersionValues versionValues = VersionValues();
  final String? update = jsonConvert.convert<String>(json['update']);
  if (update != null) {
    versionValues.update = update;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    versionValues.url = url;
  }
  final String? version = jsonConvert.convert<String>(json['version']);
  if (version != null) {
    versionValues.version = version;
  }
  return versionValues;
}

Map<String, dynamic> $VersionValuesToJson(VersionValues entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['update'] = entity.update;
  data['url'] = entity.url;
  data['version'] = entity.version;
  return data;
}

extension VersionValuesExtension on VersionValues {
  VersionValues copyWith({
    String? update,
    String? url,
    String? version,
  }) {
    return VersionValues()
      ..update = update ?? this.update
      ..url = url ?? this.url
      ..version = version ?? this.version;
  }
}