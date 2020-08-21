import 'package:indis/models/firestore_model.dart';

class InfoIndOrganizerModel extends FirestoreModel {
  static final String collection = 'infoindorganizer';

  String name;
  String description;

  InfoIndOrganizerModel(
    String id, {
    this.name,
    this.description,
  }) : super(id);

  @override
  InfoIndOrganizerModel fromMap(Map<String, dynamic> map) {
    if (map != null) {
      if (map.containsKey('name')) name = map['name'];
      if (map.containsKey('description')) description = map['description'];
    }
    return this;
  }

  @override
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
