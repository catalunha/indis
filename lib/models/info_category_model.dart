import 'package:indis/models/firestore_model.dart';
import 'package:indis/models/info_code_model.dart';
import 'package:indis/models/info_setor_model.dart';
import 'package:indis/models/user_model.dart';
// import 'package:uuid/uuid.dart' as uuid;

class InfoCategoryModel extends FirestoreModel {
  static final String collection = 'infocategory';

  UserModel userRef;
  String name;
  String description;
  bool public;
  Map<String, InfoCategoryItem> itemMap;
  InfoSetorModel setorRef;
  InfoCategoryModel(
    String id, {
    this.userRef,
    this.name,
    this.public,
    this.itemMap,
    this.setorRef,
  }) : super(id);

  @override
  InfoCategoryModel fromMap(Map<String, dynamic> map) {
    if (map != null) {
      if (map.containsKey('name')) name = map['name'];
      if (map.containsKey('description')) description = map['description'];
      if (map.containsKey('public')) public = map['public'];
      userRef = map.containsKey('userRef') && map['userRef'] != null
          ? UserModel(map['userRef']['id']).fromMap(map['userRef'])
          : null;
      setorRef = map.containsKey('setorRef') && map['setorRef'] != null
          ? InfoSetorModel(map['setorRef']['id']).fromMap(map['setorRef'])
          : null;
      if (map["itemMap"] is Map) {
        itemMap = Map<String, InfoCategoryItem>();
        map["itemMap"].forEach((k, v) {
          itemMap[k] = InfoCategoryItem(k).fromMap(v);
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
    if (public != null) data['public'] = this.public;
    if (userRef != null) {
      data['userRef'] = this.userRef.toMapRef();
    }
    if (setorRef != null) {
      data['setorRef'] = this.setorRef.toMapRef();
    } else {
      data['setorRef'] = null;
    }
    if (itemMap != null) {
      Map<String, dynamic> dataFromField = Map<String, dynamic>();
      itemMap.forEach((k, v) {
        dataFromField[k] = v.toMap();
      });
      data['itemMap'] = dataFromField;
    }
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
    String temp = 'InfoCategoryModel:';
    temp = temp + '\nuserRef.name: ${userRef.name}';
    temp = temp + '\nname: $name';
    temp = temp + '\ndescription: $description';
    temp = temp + '\npublic: $public';
    temp = temp + '\nitemMap: ${itemMap?.length}';
    temp = temp + '\nsetorRef.code: ${setorRef?.code}';

    // List<UserModel> editorsList = editorsMap?.values?.toList() ?? [];
    // editorsList.sort((a, b) => a.name.compareTo(b.name));
    // for (var userModel in editorsList) {
    //   temp = temp + '\n ${userModel.name} (id:${userModel.id.substring(0, 5)})';
    // }
    return temp;
  }
}

class InfoCategoryItem {
  String id;
  String name;
  String description;
  String idParente;
  Map<String, InfoCodeModel> infoCodeRefMap;

  InfoCategoryItem(
    this.id, {
    this.name,
    this.description,
    this.idParente,
    this.infoCodeRefMap,
  });

  InfoCategoryItem fromMap(Map<String, dynamic> map) {
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

  String toString() {
    return id + ':' + toMap().toString();
  }
}

// Map<String, dynamic> _itemMap = Map<String, dynamic>();
/*
    //a=null
    CategoryData _categoryData_a = CategoryData(uuid.Uuid().v4());
    _categoryData_a.name = 'a';
    _categoryData_a.description = 'a...';
    _categoryData_a.idParente = null;
    _categoryData_a.infoCodeRefMap = Map<String, InfoCodeModel>();
    String _uuidCode = uuid.Uuid().v4();
    _categoryData_a.infoCodeRefMap[_uuidCode] = InfoCodeModel('a1')
        .fromMap({'id': _uuidCode, 'code': 'a1', 'name': 'a1...'});
    _itemMap[_categoryData_a.id] = _categoryData_a;
    //b=a
    CategoryData _categoryData_b = CategoryData(uuid.Uuid().v4());
    _categoryData_b.name = 'b';
    _categoryData_b.description = 'b...';
    _categoryData_b.idParente = _categoryData_a.id;
    _categoryData_b.infoCodeRefMap = Map<String, InfoCodeModel>();
    _uuidCode = uuid.Uuid().v4();
    _categoryData_b.infoCodeRefMap[_uuidCode] = InfoCodeModel('b1')
        .fromMap({'id': _uuidCode, 'code': 'b1', 'name': 'b1...'});
    _itemMap[_categoryData_b.id] = _categoryData_b;
    //c=a
    CategoryData _categoryData_c = CategoryData(uuid.Uuid().v4());
    _categoryData_c.name = 'c';
    _categoryData_c.description = 'c...';
    _categoryData_c.idParente = _categoryData_a.id;
    _categoryData_c.infoCodeRefMap = Map<String, InfoCodeModel>();
    _uuidCode = uuid.Uuid().v4();
    _categoryData_c.infoCodeRefMap[_uuidCode] = InfoCodeModel('c1')
        .fromMap({'id': _uuidCode, 'code': 'c1', 'name': 'c1...'});
    _itemMap[_categoryData_c.id] = _categoryData_c;
    //d=c
    CategoryData _categoryData_d = CategoryData(uuid.Uuid().v4());
    _categoryData_d.name = 'd';
    _categoryData_d.description = 'd...';
    _categoryData_d.idParente = _categoryData_c.id;
    _categoryData_d.infoCodeRefMap = Map<String, InfoCodeModel>();
    _uuidCode = uuid.Uuid().v4();
    _categoryData_d.infoCodeRefMap[_uuidCode] = InfoCodeModel('d1')
        .fromMap({'id': _uuidCode, 'code': 'd1', 'name': 'd1...'});
    _itemMap[_categoryData_d.id] = _categoryData_d;
    //e=null
    CategoryData _categoryData_e = CategoryData(uuid.Uuid().v4());
    _categoryData_e.name = 'e';
    _categoryData_e.description = 'e...';
    _categoryData_e.idParente = null;
    _categoryData_e.infoCodeRefMap = Map<String, InfoCodeModel>();
    _uuidCode = uuid.Uuid().v4();
    _categoryData_e.infoCodeRefMap[_uuidCode] = InfoCodeModel('e1')
        .fromMap({'id': _uuidCode, 'code': 'e1', 'name': 'e1...'});
    _itemMap[_categoryData_e.id] = _categoryData_e;
*/
/*
    //a=null
    CategoryData _categoryData_a = CategoryData(uuid.Uuid().v4());
    _categoryData_a.name = 'a';
    _categoryData_a.description = 'a...';
    _categoryData_a.idParente = null;
    _categoryData_a.infoCodeRefMap = Map<String, InfoCodeModel>();
    String _uuidCode = uuid.Uuid().v4();
    _categoryData_a.infoCodeRefMap[_uuidCode] = InfoCodeModel('a1')
        .fromMap({'id': _uuidCode, 'code': 'a1', 'name': 'a1...'});
    _itemMap[_categoryData_a.id] = _categoryData_a;
    //b=a
    CategoryData _categoryData_b = CategoryData(uuid.Uuid().v4());
    _categoryData_b.name = 'b';
    _categoryData_b.description = 'b...';
    _categoryData_b.idParente = _categoryData_a.id;
    _categoryData_b.infoCodeRefMap = Map<String, InfoCodeModel>();
    _uuidCode = uuid.Uuid().v4();
    _categoryData_b.infoCodeRefMap[_uuidCode] = InfoCodeModel('b1')
        .fromMap({'id': _uuidCode, 'code': 'b1', 'name': 'b1...'});
    _itemMap[_categoryData_b.id] = _categoryData_b;
    //c=a
    CategoryData _categoryData_c = CategoryData(uuid.Uuid().v4());
    _categoryData_c.name = 'c';
    _categoryData_c.description = 'c...';
    _categoryData_c.idParente = _categoryData_b.id;
    _categoryData_c.infoCodeRefMap = Map<String, InfoCodeModel>();
    _uuidCode = uuid.Uuid().v4();
    _categoryData_c.infoCodeRefMap[_uuidCode] = InfoCodeModel('c1')
        .fromMap({'id': _uuidCode, 'code': 'c1', 'name': 'c1...'});
    _itemMap[_categoryData_c.id] = _categoryData_c;
    //d=c
    CategoryData _categoryData_d = CategoryData(uuid.Uuid().v4());
    _categoryData_d.name = 'd';
    _categoryData_d.description = 'd...';
    _categoryData_d.idParente = _categoryData_c.id;
    _categoryData_d.infoCodeRefMap = Map<String, InfoCodeModel>();
    _uuidCode = uuid.Uuid().v4();
    _categoryData_d.infoCodeRefMap[_uuidCode] = InfoCodeModel('d1')
        .fromMap({'id': _uuidCode, 'code': 'd1', 'name': 'd1...'});
    _itemMap[_categoryData_d.id] = _categoryData_d;
    //e=null
    CategoryData _categoryData_e = CategoryData(uuid.Uuid().v4());
    _categoryData_e.name = 'e';
    _categoryData_e.description = 'e...';
    _categoryData_e.idParente = _categoryData_d.id;
    _categoryData_e.infoCodeRefMap = Map<String, InfoCodeModel>();
    _uuidCode = uuid.Uuid().v4();
    _categoryData_e.infoCodeRefMap[_uuidCode] = InfoCodeModel('e1')
        .fromMap({'id': _uuidCode, 'code': 'e1', 'name': 'e1...'});
    _itemMap[_categoryData_e.id] = _categoryData_e;
*/
