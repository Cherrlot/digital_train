import 'package:digital_train/generated/json/base/json_field.dart';
import 'package:digital_train/generated/json/machine_entity.g.dart';
import 'dart:convert';

import 'package:flutter_nb_net/flutter_net.dart';
export 'package:digital_train/generated/json/machine_entity.g.dart';

@JsonSerializable()
class MachineEntity extends BaseNetModel{
	@JSONField(name: "Category")
	late String category;
	@JSONField(name: "Cdate")
	late String cdate;
	@JSONField(name: "Co")
	late String co;
	@JSONField(name: "Cycle")
	late String cycle;
	@JSONField(name: "Descr")
	late String descr;
	@JSONField(name: "Ee")
	late String ee;
	@JSONField(name: "Finish")
	late int finish;
	@JSONField(name: "Id")
	late String id;
	@JSONField(name: "Issuetime")
	late int issuetime;
	@JSONField(name: "Key1")
	late String key1;
	@JSONField(name: "Key2")
	late String key2;
	@JSONField(name: "Key3")
	late String key3;
	@JSONField(name: "Line")
	late String line;
	@JSONField(name: "No")
	late String no;
	@JSONField(name: "Oee")
	late String oee;
	@JSONField(name: "Plantime")
	late int plantime;
	@JSONField(name: "Reject")
	late int reject;
	@JSONField(name: "Status")
	late String status;
	@JSONField(name: "Target")
	late int target;
	@JSONField(name: "Times")
	late String times;
	@JSONField(name: "Udate")
	late String udate;
	@JSONField(name: "Uname")
	late String uname;
	@JSONField(name: "Workplace")
	late String workplace;

	MachineEntity();

	factory MachineEntity.fromJson(Map<String, dynamic> json) => $MachineEntityFromJson(json);

	Map<String, dynamic> toJson() => $MachineEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}

  @override
  fromJson(Map<String, dynamic> json) {
		return MachineEntity.fromJson(json);
  }
}