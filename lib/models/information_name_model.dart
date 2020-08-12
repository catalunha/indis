import 'package:indis/models/firestore_model.dart';

class InformationNameModel extends FirestoreModel {
  static final String collection = 'informationname';
//Categoria	CÓDIGO	NOME	DEFINIÇÃO	UNIDADE	FONTE
//Universalização	PT1	População Total do município	Número total de habitantes no município incluindo zona urbana e rural.	Habitantes	IBGE

  String informationAuthorRef;
  String code;
  List<String> codeIdClone;
  List<String> codeIdLink;
  String category;
  String categoryParent;
  String name;
  String description;
  bool isNumber;
  String unit;

  InformationNameModel(
    String id,
  ) : super(id);

  @override
  InformationNameModel fromMap(Map<String, dynamic> map) {
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    return data;
  }
}
