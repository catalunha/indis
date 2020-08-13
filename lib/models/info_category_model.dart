import 'package:indis/models/firestore_model.dart';

class InfoCategoryModel extends FirestoreModel {
  static final String collection = 'infocategory';

  String name;
  InfoCategoryModel infoCategoryRef;

  InfoCategoryModel(
    String id, {
    this.name,
    this.infoCategoryRef,
  }) : super(id);

  @override
  InfoCategoryModel fromMap(Map<String, dynamic> map) {
    if (map != null) {
      if (map.containsKey('name')) name = map['name'];
      infoCategoryRef =
          map.containsKey('infoCategoryRef') && map['infoCategoryRef'] != null
              ? InfoCategoryModel(map['infoCategoryRef']['id'])
                  .fromMap(map['infoCategoryRef'])
              : null;
    }
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (name != null) data['name'] = this.name;
    if (this.infoCategoryRef != null) {
      data['infoCategoryRef'] = this.infoCategoryRef.toMapRef();
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
