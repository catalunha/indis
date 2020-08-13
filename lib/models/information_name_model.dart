import 'package:indis/models/firestore_model.dart';

class InformationCodeModel extends FirestoreModel {
  static final String collection = 'informationcode';

  String informationOwnerRef;
  String code;
  List<String> codeIdClone;
  List<String> codeIdLink;
  String category;
  String categoryParent;
  String name;
  String description;
  bool isNumber;
  String unit;

  InformationCodeModel(
    String id,
  ) : super(id);

  @override
  InformationCodeModel fromMap(Map<String, dynamic> map) {
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    return data;
  }
}
