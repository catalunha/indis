import 'package:indis/models/firestore_model.dart';
import 'package:indis/models/user_model.dart';

//uma para cada município ou setor
class InfoDataModel extends FirestoreModel {
  static final String collection = 'infodata';
  String uf;
  String city;
  String area;
  String code;
  String description;
  dynamic updated;
  Map<String, InfoDataSourceField> sourceMap;
  Map<String, InfoDataCodeField> codeMap;

  InfoDataModel(
    String id, {
    this.uf,
    this.city,
    this.area,
    this.code,
    this.description,
    this.updated,
    this.codeMap,
    this.sourceMap,
  }) : super(id);

  @override
  InfoDataModel fromMap(Map<String, dynamic> map) {
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
        sourceMap = Map<String, InfoDataSourceField>();
        map["sourceMap"].forEach((k, v) {
          sourceMap[k] = InfoDataSourceField(k).fromMap(v);
        });
      }
      if (map["codeMap"] is Map) {
        codeMap = Map<String, InfoDataCodeField>();
        map["codeMap"].forEach((k, v) {
          codeMap[k] = InfoDataCodeField(k).fromMap(v);
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
    if (updated != null) data['updated'] = this.updated;
    if (sourceMap != null) {
      Map<String, dynamic> dataFromField = Map<String, dynamic>();
      this.sourceMap.forEach((k, v) {
        dataFromField[k] = v.toMap();
      });
      data['sourceMap'] = dataFromField;
    }
    if (codeMap != null) {
      Map<String, dynamic> dataFromField = Map<String, dynamic>();
      this.codeMap.forEach((k, v) {
        dataFromField[k] = v.toMap();
      });
      data['codeMap'] = dataFromField;
    }
    return data;
  }
}

class InfoDataCodeField {
  String id;
  String code;
  Map<String, InfoDataValueField> dataMap;

  InfoDataCodeField(this.id, {this.code, this.dataMap});

  InfoDataCodeField fromMap(Map<String, dynamic> map) {
    if (map != null) {
      if (map.containsKey('code')) code = map['code'];
      if (map["dataMap"] is Map) {
        dataMap = Map<String, InfoDataValueField>();
        map["dataMap"].forEach((k, v) {
          dataMap[k] = InfoDataValueField(k).fromMap(v);
        });
      }
    }
    return this;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (code != null) data['code'] = this.code;
    if (dataMap != null) {
      Map<String, dynamic> dataFromField = Map<String, dynamic>();
      this.dataMap.forEach((k, v) {
        dataFromField[k] = v.toMap();
      });
      data['dataMap'] = dataFromField;
    }
    return data;
  }
}

class InfoDataValueField {
  String id;
  String code;
  String period; //formato: yyyymm. para ano: 202000. para meses: 202001,202002
  String value; // sim,nao,123.45,
  dynamic updated;
  UserModel userRef;
  InfoDataSourceField sourceRef;

  InfoDataValueField(
    this.id, {
    this.code,
    this.period,
    this.value,
    this.userRef,
    this.updated,
    this.sourceRef,
  });

  InfoDataValueField fromMap(Map<String, dynamic> map) {
    if (map != null) {
      if (map.containsKey('code')) code = map['code'];
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
          ? InfoDataSourceField(map['sourceRef']['id'])
              .fromMap(map['sourceRef'])
          : null;
    }
    return this;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (code != null) data['code'] = this.code;
    if (period != null) data['period'] = this.period;
    if (value != null) data['value'] = this.value;
    if (this.userRef != null) {
      data['userRef'] = this.userRef.toMapRef();
    }
    if (this.sourceRef != null) {
      data['sourceRef'] = this.sourceRef.toMapRef();
    }
    if (updated != null) data['updated'] = this.updated;
    return data;
  }
}

class InfoDataSourceField {
  String id;
  String name;
  String description;

  InfoDataSourceField(this.id, {this.name, this.description});

  InfoDataSourceField fromMap(Map<String, dynamic> map) {
    if (map != null) {
      if (map.containsKey('name')) name = map['name'];
      if (map.containsKey('description')) description = map['description'];
    }
    return this;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (name != null) data['name'] = this.name;
    if (description != null) data['description'] = this.description;
    return data;
  }

  Map<String, dynamic> toMapRef() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (name != null) data['name'] = this.name;
    data.addAll({'id': this.id});
    return data;
  }
}
