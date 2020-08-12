import 'package:indis/models/firestore_model.dart';

class InformationAuthorModel extends FirestoreModel {
  static final String collection = 'informationauthor';

  String code;
  String name;
  String description;

  InformationAuthorModel(
    String id,
  ) : super(id);

  @override
  InformationAuthorModel fromMap(Map<String, dynamic> map) {
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    return data;
  }
}
