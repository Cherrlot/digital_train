import 'package:digital_train/generated/json/base/json_convert_content.dart';
import 'package:digital_train/model/machine_entity.dart';
import 'package:flutter_nb_net/flutter_net.dart';


MachineEntity $MachineEntityFromJson(Map<String, dynamic> json) {
  final MachineEntity machineEntity = MachineEntity();
  final String? category = jsonConvert.convert<String>(json['Category']);
  if (category != null) {
    machineEntity.category = category;
  }
  final String? cdate = jsonConvert.convert<String>(json['Cdate']);
  if (cdate != null) {
    machineEntity.cdate = cdate;
  }
  final String? co = jsonConvert.convert<String>(json['Co']);
  if (co != null) {
    machineEntity.co = co;
  }
  final String? cycle = jsonConvert.convert<String>(json['Cycle']);
  if (cycle != null) {
    machineEntity.cycle = cycle;
  }
  final String? descr = jsonConvert.convert<String>(json['Descr']);
  if (descr != null) {
    machineEntity.descr = descr;
  }
  final String? ee = jsonConvert.convert<String>(json['Ee']);
  if (ee != null) {
    machineEntity.ee = ee;
  }
  final int? finish = jsonConvert.convert<int>(json['Finish']);
  if (finish != null) {
    machineEntity.finish = finish;
  }
  final String? id = jsonConvert.convert<String>(json['Id']);
  if (id != null) {
    machineEntity.id = id;
  }
  final int? issuetime = jsonConvert.convert<int>(json['Issuetime']);
  if (issuetime != null) {
    machineEntity.issuetime = issuetime;
  }
  final String? key1 = jsonConvert.convert<String>(json['Key1']);
  if (key1 != null) {
    machineEntity.key1 = key1;
  }
  final String? key2 = jsonConvert.convert<String>(json['Key2']);
  if (key2 != null) {
    machineEntity.key2 = key2;
  }
  final String? key3 = jsonConvert.convert<String>(json['Key3']);
  if (key3 != null) {
    machineEntity.key3 = key3;
  }
  final String? line = jsonConvert.convert<String>(json['Line']);
  if (line != null) {
    machineEntity.line = line;
  }
  final String? no = jsonConvert.convert<String>(json['No']);
  if (no != null) {
    machineEntity.no = no;
  }
  final String? oee = jsonConvert.convert<String>(json['Oee']);
  if (oee != null) {
    machineEntity.oee = oee;
  }
  final int? plantime = jsonConvert.convert<int>(json['Plantime']);
  if (plantime != null) {
    machineEntity.plantime = plantime;
  }
  final int? reject = jsonConvert.convert<int>(json['Reject']);
  if (reject != null) {
    machineEntity.reject = reject;
  }
  final String? status = jsonConvert.convert<String>(json['Status']);
  if (status != null) {
    machineEntity.status = status;
  }
  final int? target = jsonConvert.convert<int>(json['Target']);
  if (target != null) {
    machineEntity.target = target;
  }
  final String? times = jsonConvert.convert<String>(json['Times']);
  if (times != null) {
    machineEntity.times = times;
  }
  final String? udate = jsonConvert.convert<String>(json['Udate']);
  if (udate != null) {
    machineEntity.udate = udate;
  }
  final String? uname = jsonConvert.convert<String>(json['Uname']);
  if (uname != null) {
    machineEntity.uname = uname;
  }
  final String? workplace = jsonConvert.convert<String>(json['Workplace']);
  if (workplace != null) {
    machineEntity.workplace = workplace;
  }
  return machineEntity;
}

Map<String, dynamic> $MachineEntityToJson(MachineEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['Category'] = entity.category;
  data['Cdate'] = entity.cdate;
  data['Co'] = entity.co;
  data['Cycle'] = entity.cycle;
  data['Descr'] = entity.descr;
  data['Ee'] = entity.ee;
  data['Finish'] = entity.finish;
  data['Id'] = entity.id;
  data['Issuetime'] = entity.issuetime;
  data['Key1'] = entity.key1;
  data['Key2'] = entity.key2;
  data['Key3'] = entity.key3;
  data['Line'] = entity.line;
  data['No'] = entity.no;
  data['Oee'] = entity.oee;
  data['Plantime'] = entity.plantime;
  data['Reject'] = entity.reject;
  data['Status'] = entity.status;
  data['Target'] = entity.target;
  data['Times'] = entity.times;
  data['Udate'] = entity.udate;
  data['Uname'] = entity.uname;
  data['Workplace'] = entity.workplace;
  return data;
}

extension MachineEntityExtension on MachineEntity {
  MachineEntity copyWith({
    String? category,
    String? cdate,
    String? co,
    String? cycle,
    String? descr,
    String? ee,
    int? finish,
    String? id,
    int? issuetime,
    String? key1,
    String? key2,
    String? key3,
    String? line,
    String? no,
    String? oee,
    int? plantime,
    int? reject,
    String? status,
    int? target,
    String? times,
    String? udate,
    String? uname,
    String? workplace,
  }) {
    return MachineEntity()
      ..category = category ?? this.category
      ..cdate = cdate ?? this.cdate
      ..co = co ?? this.co
      ..cycle = cycle ?? this.cycle
      ..descr = descr ?? this.descr
      ..ee = ee ?? this.ee
      ..finish = finish ?? this.finish
      ..id = id ?? this.id
      ..issuetime = issuetime ?? this.issuetime
      ..key1 = key1 ?? this.key1
      ..key2 = key2 ?? this.key2
      ..key3 = key3 ?? this.key3
      ..line = line ?? this.line
      ..no = no ?? this.no
      ..oee = oee ?? this.oee
      ..plantime = plantime ?? this.plantime
      ..reject = reject ?? this.reject
      ..status = status ?? this.status
      ..target = target ?? this.target
      ..times = times ?? this.times
      ..udate = udate ?? this.udate
      ..uname = uname ?? this.uname
      ..workplace = workplace ?? this.workplace;
  }
}