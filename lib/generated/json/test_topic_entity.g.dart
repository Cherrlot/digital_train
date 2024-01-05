import 'package:digital_train/generated/json/base/json_convert_content.dart';
import 'package:digital_train/model/test_topic_entity.dart';
import 'package:flutter_nb_net/flutter_net.dart';


TestTopicEntity $TestTopicEntityFromJson(Map<String, dynamic> json) {
  final TestTopicEntity testTopicEntity = TestTopicEntity();
  final String? iD = jsonConvert.convert<String>(json['ID']);
  if (iD != null) {
    testTopicEntity.iD = iD;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    testTopicEntity.name = name;
  }
  final List<TestTopicItems>? items = (json['items'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<TestTopicItems>(e) as TestTopicItems).toList();
  if (items != null) {
    testTopicEntity.items = items;
  }
  return testTopicEntity;
}

Map<String, dynamic> $TestTopicEntityToJson(TestTopicEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ID'] = entity.iD;
  data['name'] = entity.name;
  data['items'] = entity.items.map((v) => v.toJson()).toList();
  return data;
}

extension TestTopicEntityExtension on TestTopicEntity {
  TestTopicEntity copyWith({
    String? iD,
    String? name,
    List<TestTopicItems>? items,
  }) {
    return TestTopicEntity()
      ..iD = iD ?? this.iD
      ..name = name ?? this.name
      ..items = items ?? this.items;
  }
}

TestTopicItems $TestTopicItemsFromJson(Map<String, dynamic> json) {
  final TestTopicItems testTopicItems = TestTopicItems();
  final String? iD = jsonConvert.convert<String>(json['ID']);
  if (iD != null) {
    testTopicItems.iD = iD;
  }
  final String? paperId = jsonConvert.convert<String>(json['paperId']);
  if (paperId != null) {
    testTopicItems.paperId = paperId;
  }
  final String? bankId = jsonConvert.convert<String>(json['bankId']);
  if (bankId != null) {
    testTopicItems.bankId = bankId;
  }
  final TestTopicItemsBank? bank = jsonConvert.convert<TestTopicItemsBank>(json['bank']);
  if (bank != null) {
    testTopicItems.bank = bank;
  }
  final String? typeId = jsonConvert.convert<String>(json['typeId']);
  if (typeId != null) {
    testTopicItems.typeId = typeId;
  }
  return testTopicItems;
}

Map<String, dynamic> $TestTopicItemsToJson(TestTopicItems entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ID'] = entity.iD;
  data['paperId'] = entity.paperId;
  data['bankId'] = entity.bankId;
  data['bank'] = entity.bank.toJson();
  data['typeId'] = entity.typeId;
  return data;
}

extension TestTopicItemsExtension on TestTopicItems {
  TestTopicItems copyWith({
    String? iD,
    String? paperId,
    String? bankId,
    TestTopicItemsBank? bank,
    String? typeId,
  }) {
    return TestTopicItems()
      ..iD = iD ?? this.iD
      ..paperId = paperId ?? this.paperId
      ..bankId = bankId ?? this.bankId
      ..bank = bank ?? this.bank
      ..typeId = typeId ?? this.typeId;
  }
}

TestTopicItemsBank $TestTopicItemsBankFromJson(Map<String, dynamic> json) {
  final TestTopicItemsBank testTopicItemsBank = TestTopicItemsBank();
  final String? iD = jsonConvert.convert<String>(json['ID']);
  if (iD != null) {
    testTopicItemsBank.iD = iD;
  }
  final String? descr = jsonConvert.convert<String>(json['descr']);
  if (descr != null) {
    testTopicItemsBank.descr = descr;
  }
  final String? input = jsonConvert.convert<String>(json['input']);
  if (input != null) {
    testTopicItemsBank.input = input;
  }
  final String? answer = jsonConvert.convert<String>(json['answer']);
  if (answer != null) {
    testTopicItemsBank.answer = answer;
  }
  final String? category = jsonConvert.convert<String>(json['category']);
  if (category != null) {
    testTopicItemsBank.category = category;
  }
  final int? scores = jsonConvert.convert<int>(json['scores']);
  if (scores != null) {
    testTopicItemsBank.scores = scores;
  }
  final String? typeId = jsonConvert.convert<String>(json['typeId']);
  if (typeId != null) {
    testTopicItemsBank.typeId = typeId;
  }
  final List<String>? selections = (json['selections'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<String>(e) as String).toList();
  if (selections != null) {
    testTopicItemsBank.selections = selections;
  }
  final List<TestTopicItemsOption>? options = (json['options'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<TestTopicItemsOption>(e) as TestTopicItemsOption).toList();
  if (options != null) {
    testTopicItemsBank.options = options;
  }
  return testTopicItemsBank;
}

Map<String, dynamic> $TestTopicItemsBankToJson(TestTopicItemsBank entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ID'] = entity.iD;
  data['descr'] = entity.descr;
  data['input'] = entity.input;
  data['answer'] = entity.answer;
  data['category'] = entity.category;
  data['scores'] = entity.scores;
  data['typeId'] = entity.typeId;
  data['selections'] = entity.selections;
  data['options'] = entity.options.map((v) => v.toJson()).toList();
  return data;
}

extension TestTopicItemsBankExtension on TestTopicItemsBank {
  TestTopicItemsBank copyWith({
    String? iD,
    String? descr,
    String? input,
    String? answer,
    String? category,
    int? scores,
    String? typeId,
    List<String>? selections,
    List<TestTopicItemsOption>? options,
  }) {
    return TestTopicItemsBank()
      ..iD = iD ?? this.iD
      ..descr = descr ?? this.descr
      ..input = input ?? this.input
      ..answer = answer ?? this.answer
      ..category = category ?? this.category
      ..scores = scores ?? this.scores
      ..typeId = typeId ?? this.typeId
      ..selections = selections ?? this.selections
      ..options = options ?? this.options;
  }
}

TestTopicItemsOption $TestTopicItemsOptionFromJson(Map<String, dynamic> json) {
  final TestTopicItemsOption testTopicItemsOption = TestTopicItemsOption();
  final String? value = jsonConvert.convert<String>(json['value']);
  if (value != null) {
    testTopicItemsOption.value = value;
  }
  final String? label = jsonConvert.convert<String>(json['label']);
  if (label != null) {
    testTopicItemsOption.label = label;
  }
  return testTopicItemsOption;
}

Map<String, dynamic> $TestTopicItemsOptionToJson(TestTopicItemsOption entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['value'] = entity.value;
  data['label'] = entity.label;
  return data;
}

extension TestTopicItemsOptionExtension on TestTopicItemsOption {
  TestTopicItemsOption copyWith({
    String? value,
    String? label,
  }) {
    return TestTopicItemsOption()
      ..value = value ?? this.value
      ..label = label ?? this.label;
  }
}