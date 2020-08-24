import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:indis/models/firestore_model.dart';
import 'package:indis/models/info_code_model.dart';
import 'package:indis/models/user_model.dart';

//uma para cada município ou setor
class InfoSetorModel extends FirestoreModel {
  static final String collection = 'infosetor';

  UserModel userRef;
  String uf;
  String city;
  String area;
  String code;
  String description;
  dynamic updated;
  bool public; //qq user pode cooperar
  Map<String, UserModel> editorsMap; //apenas estes users podem cooperar
  Map<String, ValueInfo> valueInfoMap;
  Map<String, SourceInfo> sourceInfoMap;

  InfoSetorModel(
    String id, {
    this.uf,
    this.city,
    this.area,
    this.code,
    this.description,
    this.updated,
    this.public,
    this.editorsMap,
    this.valueInfoMap,
    this.sourceInfoMap,
  }) : super(id);

  @override
  InfoSetorModel fromMap(Map<String, dynamic> map) {
    if (map != null) {
      if (map.containsKey('uf')) uf = map['uf'];
      if (map.containsKey('city')) city = map['city'];
      if (map.containsKey('area')) area = map['area'];
      if (map.containsKey('code')) code = map['code'];
      if (map.containsKey('description')) description = map['description'];
      if (map.containsKey('public')) public = map['public'];
      userRef = map.containsKey('userRef') && map['userRef'] != null
          ? UserModel(map['userRef']['id']).fromMap(map['userRef'])
          : null;
      updated = map.containsKey('updated') && map['updated'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              map['updated'].millisecondsSinceEpoch)
          : null;
      if (map["sourceInfoMap"] is Map) {
        sourceInfoMap = Map<String, SourceInfo>();
        map["sourceInfoMap"].forEach((k, v) {
          sourceInfoMap[k] = SourceInfo(k).fromMap(v);
        });
      }
      if (map["valueInfoMap"] is Map) {
        valueInfoMap = Map<String, ValueInfo>();
        map["valueInfoMap"].forEach((k, v) {
          valueInfoMap[k] = ValueInfo(k).fromMap(v);
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
    if (public != null) data['public'] = this.public;
    if (userRef != null) {
      data['userRef'] = this.userRef.toMapRef();
    }
    data['updated'] = this.updated;
    if (sourceInfoMap != null) {
      Map<String, dynamic> dataFromField = Map<String, dynamic>();
      this.sourceInfoMap.forEach((k, v) {
        dataFromField[k] = v.toMap();
      });
      data['sourceInfoMap'] = dataFromField;
    }
    if (valueInfoMap != null) {
      Map<String, dynamic> dataFromField = Map<String, dynamic>();
      this.valueInfoMap.forEach((k, v) {
        dataFromField[k] = v.toMap();
      });
      data['valueInfoMap'] = dataFromField;
    }
    return data;
  }

  @override
  String toString() {
    String temp = 'InfoSetorModel:';
    temp = temp + '\nuf: $uf';
    temp = temp + '\ncity: $city';
    temp = temp + '\narea: $area';
    temp = temp + '\ncode: $code';
    temp = temp + '\ndescription: $description';
    temp = temp + '\nupdated: $updated';
    temp = temp + '\npublic: $public';
    return temp;
  }
}

class ValueInfo {
  String id; //igual ao infoCodeRef.id
  InfoCodeModel infoCodeRef;
  Map<String, ValueInfoData> codeValueDataMap;

  ValueInfo(this.id, {this.infoCodeRef, this.codeValueDataMap});

  ValueInfo fromMap(Map<String, dynamic> map) {
    if (map != null) {
      infoCodeRef = map.containsKey('infoCodeRef') && map['infoCodeRef'] != null
          ? InfoCodeModel(map['infoCodeRef']['id']).fromMap(map['infoCodeRef'])
          : null;
      if (map["codeValueDataMap"] is Map) {
        codeValueDataMap = Map<String, ValueInfoData>();
        map["codeValueDataMap"].forEach((k, v) {
          codeValueDataMap[k] = ValueInfoData(k).fromMap(v);
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

class ValueInfoData {
  String id; //idem a period
  String period; //formato: yyyymm. para ano: 202000. para meses: 202001,202002
  String value; // sim,nao,123.45,
  dynamic updated;
  UserModel userRef;
  SourceInfo sourceRef;

  ValueInfoData(
    this.id, {
    this.period,
    this.value,
    this.userRef,
    this.updated,
    this.sourceRef,
  });

  ValueInfoData fromMap(Map<String, dynamic> map) {
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
          ? SourceInfo(map['sourceRef']['id']).fromMap(map['sourceRef'])
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

class SourceInfo {
  String id;
  String name;
  String description;
  UserModel userRef;

  SourceInfo(this.id, {this.name, this.description, this.userRef});

  SourceInfo fromMap(Map<String, dynamic> map) {
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
