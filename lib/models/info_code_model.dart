import 'package:indis/models/firestore_model.dart';
import 'package:indis/models/info_ind_owner_model.dart';

class InfoCodeModel extends FirestoreModel {
  static final String collection = 'infocode';

  String code;
  String name;
  String description;
  String unit;
  // bool isNumber;
  InfoIndOwnerModel infoIndOwnerRef;
  Map<String, InfoCodeModel> cloneInfoCodeRefMap;
  Map<String, InfoCodeModel> linkInfoCodeRefMap;
  bool arquived;

  InfoCodeModel(
    String id, {
    this.infoIndOwnerRef,
    this.code,
    this.cloneInfoCodeRefMap,
    this.linkInfoCodeRefMap,
    this.name,
    this.description,
    this.unit,
    // this.isNumber,
    this.arquived,
  }) : super(id);

  @override
  InfoCodeModel fromMap(Map<String, dynamic> map) {
    if (map != null) {
      if (map.containsKey('code')) code = map['code'];
      if (map.containsKey('name')) name = map['name'];
      if (map.containsKey('description')) description = map['description'];
      if (map.containsKey('unit')) unit = map['unit'];
      // if (map.containsKey('isNumber')) isNumber = map['isNumber'];
      if (map.containsKey('arquived')) arquived = map['arquived'];
      infoIndOwnerRef =
          map.containsKey('infoIndOwnerRef') && map['infoIndOwnerRef'] != null
              ? InfoIndOwnerModel(map['infoIndOwnerRef']['id'])
                  .fromMap(map['infoIndOwnerRef'])
              : null;
      if (map["cloneInfoCodeRefMap"] is Map) {
        cloneInfoCodeRefMap = Map<String, InfoCodeModel>();
        map["cloneInfoCodeRefMap"].forEach((k, v) {
          cloneInfoCodeRefMap[k] = InfoCodeModel(k).fromMap(v);
        });
      }
      if (map["linkInfoCodeRefMap"] is Map) {
        linkInfoCodeRefMap = Map<String, InfoCodeModel>();
        map["linkInfoCodeRefMap"].forEach((k, v) {
          linkInfoCodeRefMap[k] = InfoCodeModel(k).fromMap(v);
        });
      }
    }
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (code != null) data['code'] = this.code;
    if (name != null) data['name'] = this.name;
    if (description != null) data['description'] = this.description;
    if (unit != null) data['unit'] = this.unit;
    // if (isNumber != null) data['isNumber'] = this.isNumber;
    if (this.infoIndOwnerRef != null) {
      data['infoIndOwnerRef'] = this.infoIndOwnerRef.toMapRef();
    }
    if (cloneInfoCodeRefMap != null) {
      Map<String, dynamic> dataFromField = Map<String, dynamic>();
      this.cloneInfoCodeRefMap.forEach((k, v) {
        dataFromField[k] = v.toMapRef();
      });
      data['cloneInfoCodeRefMap'] = dataFromField;
    }
    if (linkInfoCodeRefMap != null) {
      Map<String, dynamic> dataFromField = Map<String, dynamic>();
      this.linkInfoCodeRefMap.forEach((k, v) {
        dataFromField[k] = v.toMapRef();
      });
      data['linkInfoCodeRefMap'] = dataFromField;
    }
    return data;
  }

  Map<String, dynamic> toMapRef() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (code != null) data['code'] = this.code;
    if (name != null) data['name'] = this.name;
    data.addAll({'id': this.id});
    return data;
  }
}
