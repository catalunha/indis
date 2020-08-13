import 'package:indis/models/firestore_model.dart';

class InformationOwnerModel extends FirestoreModel {
  static final String collection = 'informationowner';

  String code;
  String name;
  String description;
  bool arquived;

  InformationOwnerModel(
    String id, {
    this.code,
    this.name,
    this.description,
    this.arquived,
  }) : super(id);

  @override
  InformationOwnerModel fromMap(Map<String, dynamic> map) {
    if (map != null) {
      if (map.containsKey('code')) code = map['code'];
      if (map.containsKey('name')) name = map['name'];
      if (map.containsKey('description')) description = map['description'];
      if (map.containsKey('arquived')) arquived = map['arquived'];
    }
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (code != null) data['code'] = this.code;
    if (name != null) data['name'] = this.name;
    if (description != null) data['description'] = this.description;
    if (arquived != null) data['arquived'] = this.arquived;

    return data;
  }

  Map<String, dynamic> toMapRef() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (name != null) data['name'] = this.name;
    data.addAll({'id': this.id});
    return data;
  }
}
