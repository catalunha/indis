import 'package:indis/models/firestore_model.dart';
import 'package:indis/models/info_code_model.dart';
import 'package:indis/models/user_model.dart';
import 'package:uuid/uuid.dart' as uuid;

class InfoCategoryModel extends FirestoreModel {
  static final String collection = 'infocategory';

  UserModel userRef;
  String name;
  String description;
  Map<String, CategoryData> categoryDataMap;
  InfoCategoryModel(
    String id, {
    this.userRef,
    this.name,
    this.categoryDataMap,
  }) : super(id);

  @override
  InfoCategoryModel fromMap(Map<String, dynamic> map) {
    if (map != null) {
      if (map.containsKey('name')) name = map['name'];
      if (map.containsKey('description')) description = map['description'];
      userRef = map.containsKey('userRef') && map['userRef'] != null
          ? UserModel(map['userRef']['id']).fromMap(map['userRef'])
          : null;
      if (map["categoryDataMap"] is Map) {
        categoryDataMap = Map<String, CategoryData>();
        map["categoryDataMap"].forEach((k, v) {
          categoryDataMap[k] = CategoryData(k).fromMap(v);
        });
      }
    }
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (name != null) data['name'] = this.name;
    if (description != null) data['description'] = this.description;
    if (this.userRef != null) {
      data['userRef'] = this.userRef.toMapRef();
    }

    Map<String, dynamic> _categoryDataMap = Map<String, dynamic>();
    CategoryData _categoryData1 = CategoryData(uuid.Uuid().v4());
    // _categoryData1.id = uuid.Uuid().v4();
    _categoryData1.name = 'a';
    _categoryData1.description = 'a...';
    _categoryData1.idParente = null;
    _categoryData1.infoCodeRefMap = Map<String, InfoCodeModel>();
    String _uuidCode = uuid.Uuid().v4();
    _categoryData1.infoCodeRefMap[_uuidCode] = InfoCodeModel('pt1')
        .fromMap({'id': _uuidCode, 'code': 'PT1', 'name': 'PT1...'});
    _categoryDataMap[_categoryData1.id] = _categoryData1;
    CategoryData _categoryData2 = CategoryData(uuid.Uuid().v4());
    // _categoryData2.id = uuid.Uuid().v4();
    _categoryData2.name = 'b';
    _categoryData2.description = 'b...';
    _categoryData2.idParente = _categoryData1.id;
    _categoryData2.infoCodeRefMap = Map<String, InfoCodeModel>();
    _uuidCode = uuid.Uuid().v4();
    _categoryData2.infoCodeRefMap[_uuidCode] = InfoCodeModel('pu1')
        .fromMap({'id': _uuidCode, 'code': 'PU1', 'name': 'PU1...'});
    _categoryDataMap[_categoryData2.id] = _categoryData2;

    if (_categoryDataMap != null) {
      Map<String, dynamic> dataFromField = Map<String, dynamic>();
      _categoryDataMap.forEach((k, v) {
        dataFromField[k] = v.toMap();
      });
      data['categoryDataMap'] = dataFromField;
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

class CategoryData {
  String id;
  String name;
  String description;
  String idParente;
  Map<String, InfoCodeModel> infoCodeRefMap;

  CategoryData(
    this.id, {
    this.name,
    this.description,
    this.idParente,
    this.infoCodeRefMap,
  });

  CategoryData fromMap(Map<String, dynamic> map) {
    if (map != null) {
      if (map.containsKey('name')) this.name = map['name'];
      if (map.containsKey('description')) this.description = map['description'];
      if (map.containsKey('idParente')) this.idParente = map['idParente'];
      if (map["infoCodeRefMap"] is Map) {
        this.infoCodeRefMap = Map<String, InfoCodeModel>();
        map["infoCodeRefMap"].forEach((k, v) {
          this.infoCodeRefMap[k] = InfoCodeModel(k).fromMap(v);
        });
      }
    }
    return this;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.name != null) data['name'] = this.name;
    if (this.description != null) data['description'] = this.description;
    if (this.idParente != null) data['idParente'] = this.idParente;
    if (this.infoCodeRefMap != null) {
      Map<String, dynamic> dataFromField = Map<String, dynamic>();
      this.infoCodeRefMap.forEach((k, v) {
        dataFromField[k] = v.toMapRef();
      });
      data['infoCodeRefMap'] = dataFromField;
    }
    return data;
  }
}
