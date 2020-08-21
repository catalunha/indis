import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:indis/models/firestore_model.dart';
import 'package:indis/models/info_code_model.dart';
import 'package:indis/models/user_model.dart';

//uma para cada município ou setor
class InfoSetorModel extends FirestoreModel {
  static final String collection = 'infosetor';
  String uf;
  String city;
  String area;
  String code;
  String description;
  dynamic updated;
  Map<String, CodeValue> valueCodeMap;
  Map<String, Source> sourceMap;

  InfoSetorModel(
    String id, {
    this.uf,
    this.city,
    this.area,
    this.code,
    this.description,
    this.updated,
    this.valueCodeMap,
    this.sourceMap,
  }) : super(id);

  @override
  InfoSetorModel fromMap(Map<String, dynamic> map) {
    if (map != null) {
      if (map.containsKey('uf')) uf = map['uf'];
      if (map.containsKey('city')) city = map['city'];
      if (map.containsKey('area')) area = map['area'];
      if (map.containsKey('code')) code = map['code'];
      if (map.containsKey('description')) description = map['description'];
      updated = map.containsKey('updated') && map['updated'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              map['updated'].millisecondsSinceEpoch)
          : null;
      if (map["sourceMap"] is Map) {
        sourceMap = Map<String, Source>();
        map["sourceMap"].forEach((k, v) {
          sourceMap[k] = Source(k).fromMap(v);
        });
      }
      if (map["valueCodeMap"] is Map) {
        valueCodeMap = Map<String, CodeValue>();
        map["valueCodeMap"].forEach((k, v) {
          valueCodeMap[k] = CodeValue(k).fromMap(v);
        });
      }
    }
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (uf != null) data['uf'] = this.uf;
    if (city != null) data['city'] = this.city;
    if (area != null) data['area'] = this.area;
    if (code != null) data['code'] = this.code;
    if (description != null) data['description'] = this.description;
    data['updated'] = FieldValue.serverTimestamp();
    if (sourceMap != null) {
      Map<String, dynamic> dataFromField = Map<String, dynamic>();
      this.sourceMap.forEach((k, v) {
        dataFromField[k] = v.toMap();
      });
      data['sourceMap'] = dataFromField;
    }
    if (valueCodeMap != null) {
      Map<String, dynamic> dataFromField = Map<String, dynamic>();
      this.valueCodeMap.forEach((k, v) {
        dataFromField[k] = v.toMap();
      });
      data['valueCodeMap'] = dataFromField;
    }
    return data;
  }
}

class CodeValue {
  String id; //igual ao infoCodeRef.id
  InfoCodeModel infoCodeRef;
  Map<String, CodeValueData> codeValueDataMap;

  CodeValue(this.id, {this.infoCodeRef, this.codeValueDataMap});

  CodeValue fromMap(Map<String, dynamic> map) {
    if (map != null) {
      infoCodeRef = map.containsKey('infoCodeRef') && map['infoCodeRef'] != null
          ? InfoCodeModel(map['infoCodeRef']['id']).fromMap(map['infoCodeRef'])
          : null;
      if (map["codeValueDataMap"] is Map) {
        codeValueDataMap = Map<String, CodeValueData>();
        map["codeValueDataMap"].forEach((k, v) {
          codeValueDataMap[k] = CodeValueData(k).fromMap(v);
        });
      }
    }
    return this;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.infoCodeRef != null) {
      data['infoCodeRef'] = this.infoCodeRef.toMapRef();
    }
    if (codeValueDataMap != null) {
      Map<String, dynamic> dataFromField = Map<String, dynamic>();
      this.codeValueDataMap.forEach((k, v) {
        dataFromField[k] = v.toMap();
      });
      data['codeValueDataMap'] = dataFromField;
    }
    return data;
  }
}

class CodeValueData {
  String id; //idem a period
  String period; //formato: yyyymm. para ano: 202000. para meses: 202001,202002
  String value; // sim,nao,123.45,
  dynamic updated;
  UserModel userRef;
  Source sourceRef;

  CodeValueData(
    this.id, {
    this.period,
    this.value,
    this.userRef,
    this.updated,
    this.sourceRef,
  });

  CodeValueData fromMap(Map<String, dynamic> map) {
    if (map != null) {
      if (map.containsKey('period')) period = map['period'];
      if (map.containsKey('value')) value = map['value'];
      updated = map.containsKey('updated') && map['updated'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              map['updated'].millisecondsSinceEpoch)
          : null;
      userRef = map.containsKey('userRef') && map['userRef'] != null
          ? UserModel(map['userRef']['id']).fromMap(map['userRef'])
          : null;
      sourceRef = map.containsKey('sourceRef') && map['sourceRef'] != null
          ? Source(map['sourceRef']['id']).fromMap(map['sourceRef'])
          : null;
    }
    return this;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (period != null) data['period'] = this.period;
    if (value != null) data['value'] = this.value;
    if (this.userRef != null) {
      data['userRef'] = this.userRef.toMapRef();
    }
    if (this.sourceRef != null) {
      data['sourceRef'] = this.sourceRef.toMapRef();
    }
    data['updated'] = FieldValue.serverTimestamp();
    return data;
  }
}

class Source {
  String id;
  String name;
  String description;
  UserModel userRef;

  Source(this.id, {this.name, this.description, this.userRef});

  Source fromMap(Map<String, dynamic> map) {
    if (map != null) {
      if (map.containsKey('name')) name = map['name'];
      if (map.containsKey('description')) description = map['description'];
      userRef = map.containsKey('userRef') && map['userRef'] != null
          ? UserModel(map['userRef']['id']).fromMap(map['userRef'])
          : null;
    }
    return this;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (name != null) data['name'] = this.name;
    if (description != null) data['description'] = this.description;
    if (this.userRef != null) {
      data['userRef'] = this.userRef.toMapRef();
    }
    return data;
  }

  Map<String, dynamic> toMapRef() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (name != null) data['name'] = this.name;
    data.addAll({'id': this.id});
    return data;
  }
}
