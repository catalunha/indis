import 'package:indis/models/firestore_model.dart';
import 'package:indis/models/info_code_model.dart';
import 'package:indis/models/info_ind_organizer_model.dart';

class InfoCategoryModel extends FirestoreModel {
  static final String collection = 'infocategory';

  InfoIndOrganizerModel infoIndOrganizerRef;
  String name;
  String description;
  InfoCategoryModel infoCategoryRefParent;
  Map<String, InfoCodeModel> infoCodeRefMap;
  InfoCategoryModel(
    String id, {
    this.infoIndOrganizerRef,
    this.name,
    this.infoCategoryRefParent,
    this.infoCodeRefMap,
  }) : super(id);

  @override
  InfoCategoryModel fromMap(Map<String, dynamic> map) {
    if (map != null) {
      if (map.containsKey('name')) name = map['name'];
      if (map.containsKey('description')) description = map['description'];
      infoCategoryRefParent = map.containsKey('infoCategoryRefParent') &&
              map['infoCategoryRefParent'] != null
          ? InfoCategoryModel(map['infoCategoryRefParent']['id'])
              .fromMap(map['infoCategoryRefParent'])
          : null;
      infoIndOrganizerRef = map.containsKey('infoIndOrganizerRef') &&
              map['infoIndOrganizerRef'] != null
          ? InfoIndOrganizerModel(map['infoIndOrganizerRef']['id'])
              .fromMap(map['infoIndOrganizerRef'])
          : null;
      if (map["infoCodeRefMap"] is Map) {
        infoCodeRefMap = Map<String, InfoCodeModel>();
        map["infoCodeRefMap"].forEach((k, v) {
          infoCodeRefMap[k] = InfoCodeModel(k).fromMap(v);
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
    if (this.infoCategoryRefParent != null) {
      data['infoCategoryRefParent'] = this.infoCategoryRefParent.toMapRef();
    } else {
      data['infoCategoryRefParent'] = null;
    }
    if (this.infoIndOrganizerRef != null) {
      data['infoIndOrganizerRef'] = this.infoIndOrganizerRef.toMapRef();
    }
    if (infoCodeRefMap != null) {
      Map<String, dynamic> dataFromField = Map<String, dynamic>();
      this.infoCodeRefMap.forEach((k, v) {
        dataFromField[k] = v.toMapRef();
      });
      data['infoCodeRefMap'] = dataFromField;
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
