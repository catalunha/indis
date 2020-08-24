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
  Map<String, UserModel>
      editorsMap; //são UserModelRef e apenas estes users podem cooperar
  Map<String, ValueInfo> valueMap;
  Map<String, Source> sourceMap;

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
    this.valueMap,
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
      if (map.containsKey('public')) public = map['public'];
      userRef = map.containsKey('userRef') && map['userRef'] != null
          ? UserModel(map['userRef']['id']).fromMap(map['userRef'])
          : null;
      updated = map.containsKey('updated') && map['updated'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              map['updated'].millisecondsSinceEpoch)
          : null;
      if (map["editorsMap"] is Map) {
        editorsMap = Map<String, UserModel>();
        map["editorsMap"].forEach((k, v) {
          editorsMap[k] = UserModel(k).fromMap(v);
        });
      }
      if (map["sourceMap"] is Map) {
        sourceMap = Map<String, Source>();
        map["sourceMap"].forEach((k, v) {
          sourceMap[k] = Source(k).fromMap(v);
        });
      }
      if (map["valueMap"] is Map) {
        valueMap = Map<String, ValueInfo>();
        map["valueMap"].forEach((k, v) {
          valueMap[k] = ValueInfo(k).fromMap(v);
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
    if (sourceMap != null) {
      Map<String, dynamic> dataFromField = Map<String, dynamic>();
      this.sourceMap.forEach((k, v) {
        dataFromField[k] = v.toMap();
      });
      data['sourceMap'] = dataFromField;
    }
    if (editorsMap != null) {
      Map<String, dynamic> dataFromField = Map<String, dynamic>();
      this.editorsMap.forEach((k, v) {
        dataFromField[k] = v.toMapRef();
      });
      data['editorsMap'] = dataFromField;
    }
    if (valueMap != null) {
      Map<String, dynamic> dataFromField = Map<String, dynamic>();
      this.valueMap.forEach((k, v) {
        dataFromField[k] = v.toMap();
      });
      data['valueMap'] = dataFromField;
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
    temp = temp + '\neditorsMap: ${editorsMap?.length}';
    List<UserModel> editorsList = editorsMap?.values?.toList() ?? [];
    editorsList.sort((a, b) => a.name.compareTo(b.name));
    for (var userModel in editorsList) {
      temp = temp + '\n ${userModel.name} (id:${userModel.id.substring(0, 5)})';
    }
    temp = temp + '\nvalueMap: ${valueMap?.length}';
    List<ValueInfo> valueList = valueMap?.values?.toList() ?? [];
    valueList.sort((a, b) => a.infoCodeRef.code.compareTo(b.infoCodeRef.code));
    for (var valueInfo in valueList) {
      temp = temp +
          '\n ${valueInfo.infoCodeRef.code} (id:${valueInfo.id.substring(0, 5)})';
    }
    return temp;
  }
}

class ValueInfo {
  String id; //igual ao infoCodeRef.id
  InfoCodeModel infoCodeRef;
  Map<String, ValueData> valueDataMap;

  ValueInfo(this.id, {this.infoCodeRef, this.valueDataMap});

  ValueInfo fromMap(Map<String, dynamic> map) {
    if (map != null) {
      infoCodeRef = map.containsKey('infoCodeRef') && map['infoCodeRef'] != null
          ? InfoCodeModel(map['infoCodeRef']['id']).fromMap(map['infoCodeRef'])
          : null;
      if (map["valueDataMap"] is Map) {
        valueDataMap = Map<String, ValueData>();
        map["valueDataMap"].forEach((k, v) {
          valueDataMap[k] = ValueData(k).fromMap(v);
        });
      }
    }
    return this;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.infoCodeRef != null) {
      data['infoCodeRef'] = this.infoCodeRef.toMap();
    }
    if (valueDataMap != null) {
      Map<String, dynamic> dataFromField = Map<String, dynamic>();
      this.valueDataMap.forEach((k, v) {
        dataFromField[k] = v.toMap();
      });
      data['valueDataMap'] = dataFromField;
    }
    return data;
  }
}

class ValueData {
  String id;
  String period; //formato: yyyymm. para ano: 202000. para meses: 202001,202002
  String value; // sim,nao,123.45,
  dynamic updated;
  UserModel userRef;
  Source sourceRef;

  ValueData(
    this.id, {
    this.period,
    this.value,
    this.userRef,
    this.updated,
    this.sourceRef,
  });

  ValueData fromMap(Map<String, dynamic> map) {
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
    data['updated'] = this.updated;
    return data;
  }
}

class Source {
  String id;
  String name;
  String description;
  UserModel userRef;
  dynamic updated;

  Source(this.id, {this.name, this.description, this.userRef, this.updated});

  Source fromMap(Map<String, dynamic> map) {
    if (map != null) {
      if (map.containsKey('name')) name = map['name'];
      if (map.containsKey('description')) description = map['description'];
      userRef = map.containsKey('userRef') && map['userRef'] != null
          ? UserModel(map['userRef']['id']).fromMap(map['userRef'])
          : null;
      updated = map.containsKey('updated') && map['updated'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              map['updated'].millisecondsSinceEpoch)
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
    data['updated'] = this.updated;

    return data;
  }

  Map<String, dynamic> toMapRef() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (name != null) data['name'] = this.name;
    data.addAll({'id': this.id});
    return data;
  }
}
