import 'package:digital_train/generated/json/base/json_field.dart';
import 'package:digital_train/generated/json/test_topic_entity.g.dart';
import 'dart:convert';

import 'package:flutter_nb_net/flutter_net.dart';
export 'package:digital_train/generated/json/test_topic_entity.g.dart';

@JsonSerializable()
class TestTopicEntity extends BaseNetModel {
  @JSONField(name: "ID")
  late String iD;
  late String name;
  late List<TestTopicItems> items;

  @override
  TestTopicEntity fromJson(Map<String, dynamic> json) {
    return TestTopicEntity.fromJson(json);
  }

  TestTopicEntity({String? iD, String? name, List<TestTopicItems>? items})
      : iD = iD ?? '',
        name = name ?? '',
        items = items ?? [];

  factory TestTopicEntity.fromJson(Map<String, dynamic> json) => $TestTopicEntityFromJson(json);

  Map<String, dynamic> toJson() => $TestTopicEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class TestTopicItems extends BaseNetModel {
  @JSONField(name: "ID")
  late String iD;
  late String paperId;
  late String bankId;
  late TestTopicItemsBank bank;
  late String typeId;

  @override
  TestTopicItems fromJson(Map<String, dynamic> json) {
    return TestTopicItems.fromJson(json);
  }

  TestTopicItems({String? iD, String? paperId, String? bankId, TestTopicItemsBank? bank, String? typeId})
      : iD = iD ?? '',
        paperId = paperId ?? '',
        bankId = bankId ?? '',
        bank = bank ?? TestTopicItemsBank(),
        typeId = typeId ?? '';

  factory TestTopicItems.fromJson(Map<String, dynamic> json) => $TestTopicItemsFromJson(json);

  Map<String, dynamic> toJson() => $TestTopicItemsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class TestTopicItemsBank extends BaseNetModel {
  @JSONField(name: "ID")
  late String iD;
  late String descr;
  late String input;
  late String answer;
  late String category;
  late int scores;
  late String typeId;
  late String type;
  late List<String> selections;
  late List<TestTopicItemsOption> options;

  @override
  TestTopicItemsBank fromJson(Map<String, dynamic> json) {
    return TestTopicItemsBank.fromJson(json);
  }

  TestTopicItemsBank(
      {String? iD,
      String? descr,
      String? input,
      String? answer,
      String? category,
      int? scores,
      String? typeId,
      String? type,
        List<String>? selections,
      List<TestTopicItemsOption>? options})
      : iD = iD ?? '',
        descr = descr ?? '',
        input = input ?? '',
        answer = answer ?? '',
        category = category ?? '',
        scores = scores ?? 0,
        type = type ?? '',
        selections = selections ?? [],
        options = options ?? [],
        typeId = typeId ?? '';

  factory TestTopicItemsBank.fromJson(Map<String, dynamic> json) => $TestTopicItemsBankFromJson(json);

  Map<String, dynamic> toJson() => $TestTopicItemsBankToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class TestTopicItemsOption extends BaseNetModel {
  late String value;
  late String label;

  @override
  TestTopicItemsBank fromJson(Map<String, dynamic> json) {
    return TestTopicItemsBank.fromJson(json);
  }

  TestTopicItemsOption({String? value, String? label})
      : value = value ?? '',
        label = label ?? '';

  factory TestTopicItemsOption.fromJson(Map<String, dynamic> json) => $TestTopicItemsOptionFromJson(json);

  Map<String, dynamic> toJson() => $TestTopicItemsOptionToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
