import 'package:digital_train/generated/json/base/json_convert_content.dart';
import 'package:digital_train/model/test_result_entity.dart';
import 'package:flutter_nb_net/flutter_net.dart';


TestResultEntity $TestResultEntityFromJson(Map<String, dynamic> json) {
  final TestResultEntity testResultEntity = TestResultEntity();
  final String? iD = jsonConvert.convert<String>(json['ID']);
  if (iD != null) {
    testResultEntity.iD = iD;
  }
  final String? userId = jsonConvert.convert<String>(json['userId']);
  if (userId != null) {
    testResultEntity.userId = userId;
  }
  final int? scores = jsonConvert.convert<int>(json['scores']);
  if (scores != null) {
    testResultEntity.scores = scores;
  }
  return testResultEntity;
}

Map<String, dynamic> $TestResultEntityToJson(TestResultEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ID'] = entity.iD;
  data['userId'] = entity.userId;
  data['scores'] = entity.scores;
  return data;
}

extension TestResultEntityExtension on TestResultEntity {
  TestResultEntity copyWith({
    String? iD,
    String? userId,
    int? scores,
  }) {
    return TestResultEntity()
      ..iD = iD ?? this.iD
      ..userId = userId ?? this.userId
      ..scores = scores ?? this.scores;
  }
}