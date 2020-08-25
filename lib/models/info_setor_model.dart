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
  Map<String, InfoSetorValueModel> valueMap;
  Map<String, InfoSetorSourceModel> sourceMap;

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
        sourceMap = Map<String, InfoSetorSourceModel>();
        map["sourceMap"].forEach((k, v) {
          sourceMap[k] = InfoSetorSourceModel(k).fromMap(v);
        });
      }
      if (map["valueMap"] is Map) {
        valueMap = Map<String, InfoSetorValueModel>();
        map["valueMap"].forEach((k, v) {
          valueMap[k] = InfoSetorValueModel(k).fromMap(v);
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

  Map<String, dynamic> toMapRef() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (uf != null) data['uf'] = this.uf;
    if (city != null) data['city'] = this.city;
    if (code != null) data['code'] = this.code;
    data.addAll({'id': this.id});
    return data;
  }

  @override
  String toString() {
    String temp = 'InfoSetorModel:';
    temp = temp + '\nid: $id';
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
    List<InfoSetorValueModel> valueList = valueMap?.values?.toList() ?? [];
    valueList.sort((a, b) => a.infoCodeRef.code.compareTo(b.infoCodeRef.code));
    for (var valueInfo in valueList) {
      temp = temp +
          '\n ${valueInfo.infoCodeRef.code} (id:${valueInfo.id.substring(0, 5)})';
    }
    return temp;
  }
}

class InfoSetorValueModel {
  String id; //igual ao infoCodeRef.id
  InfoCodeModel infoCodeRef;
  Map<String, InfoSetorValueDataModel> valueDataMap;

  InfoSetorValueModel(this.id, {this.infoCodeRef, this.valueDataMap});

  InfoSetorValueModel fromMap(Map<String, dynamic> map) {
    if (map != null) {
      infoCodeRef = map.containsKey('infoCodeRef') && map['infoCodeRef'] != null
          ? InfoCodeModel(map['infoCodeRef']['id']).fromMap(map['infoCodeRef'])
          : null;
      if (map["valueDataMap"] is Map) {
        valueDataMap = Map<String, InfoSetorValueDataModel>();
        map["valueDataMap"].forEach((k, v) {
          valueDataMap[k] = InfoSetorValueDataModel(k).fromMap(v);
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

class InfoSetorValueDataModel {
  String id;
  String period; //formato: yyyymm. para ano: 202000. para meses: 202001,202002
  String value; // sim,nao,123.45,
  String description; // sim,nao,123.45,
  dynamic updated;
  UserModel userRef;
  InfoSetorSourceModel sourceRef;

  InfoSetorValueDataModel(
    this.id, {
    this.period,
    this.value,
    this.description,
    this.userRef,
    this.updated,
    this.sourceRef,
  });

  InfoSetorValueDataModel fromMap(Map<String, dynamic> map) {
    if (map != null) {
      if (map.containsKey('period')) period = map['period'];
      if (map.containsKey('value')) value = map['value'];
      if (map.containsKey('description')) description = map['description'];
      updated = map.containsKey('updated') && map['updated'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              map['updated'].millisecondsSinceEpoch)
          : null;
      userRef = map.containsKey('userRef') && map['userRef'] != null
          ? UserModel(map['userRef']['id']).fromMap(map['userRef'])
          : null;
      sourceRef = map.containsKey('sourceRef') && map['sourceRef'] != null
          ? InfoSetorSourceModel(map['sourceRef']['id'])
              .fromMap(map['sourceRef'])
          : null;
    }
    return this;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (period != null) data['period'] = this.period;
    if (value != null) data['value'] = this.value;
    if (description != null) data['description'] = this.description;
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

class InfoSetorSourceModel {
  String id;
  String name;
  String description;
  UserModel userRef;
  dynamic updated;

  InfoSetorSourceModel(this.id,
      {this.name, this.description, this.userRef, this.updated});

  InfoSetorSourceModel fromMap(Map<String, dynamic> map) {
    if (map != null) {
      if (map.containsKey('name')) name = map['name'];
      if (map.containsKey('description')) description = map['description'];
      userRef = map['userRef'] != null && map.containsKey('userRef')
          ? UserModel(map['userRef']['id']).fromMap(map['userRef'])
          : null;
      updated = map['updated'] != null && map.containsKey('updated')
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

  @override
  String toString() {
    String temp = 'InfoSetorSourceModel:';
    temp = temp + '\nid: $id';
    temp = temp + '\nname: $name';
    temp = temp + '\ndescription: $description';
    temp = temp + '\nupdated: $updated';
    temp = temp + '\nuserRef: ${userRef.toString()}';

    return temp;
  }
}
