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
  Map<String, InfoCodeModel> cloneMap;
  Map<String, InfoCodeModel> linkMap;
  bool arquived;

  InfoCodeModel(
    String id, {
    this.infoIndOwnerRef,
    this.code,
    this.cloneMap,
    this.linkMap,
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
      if (map["cloneMap"] is Map) {
        cloneMap = Map<String, InfoCodeModel>();
        map["cloneMap"].forEach((k, v) {
          cloneMap[k] = InfoCodeModel(k).fromMap(v);
        });
      }
      if (map["linkMap"] is Map) {
        linkMap = Map<String, InfoCodeModel>();
        map["linkMap"].forEach((k, v) {
          linkMap[k] = InfoCodeModel(k).fromMap(v);
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
    if (cloneMap != null) {
      Map<String, dynamic> dataFromField = Map<String, dynamic>();
      this.cloneMap.forEach((k, v) {
        dataFromField[k] = v.toMap();
      });
      data['cloneMap'] = dataFromField;
    }
    if (linkMap != null) {
      Map<String, dynamic> dataFromField = Map<String, dynamic>();
      this.linkMap.forEach((k, v) {
        dataFromField[k] = v.toMap();
      });
      data['linkMap'] = dataFromField;
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

  String toStringInfoCodeCloneMap() {
    String _return = '';
    List<InfoCodeModel> cloneList = cloneMap?.values?.toList() ?? [];
    cloneList.sort((a, b) => a.name.compareTo(b.name));
    for (var clone in cloneList) {
      _return = _return +
          '\n${clone.infoIndOwnerRef.name} - ${clone.code} - ${clone.name}   || ${clone.id.substring(0, 5)}';
    }
    return _return;
  }

  String toStringInfoCodeLinkMap() {
    String _return = '';
    List<InfoCodeModel> linkList = linkMap?.values?.toList() ?? [];
    linkList.sort((a, b) => a.name.compareTo(b.name));
    for (var link in linkList) {
      _return = _return +
          '\n${link.infoIndOwnerRef.name} - ${link.code} - ${link.name}   || ${link.id.substring(0, 5)}';
    }
    return _return;
  }
}
