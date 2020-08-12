import 'package:indis/models/firestore_model.dart';

class InformationDataModel extends FirestoreModel {
  static final String collection = 'informationdata';
  //uma para cada município ou setor
  String uf;
  String city;
  String area;
  String code;
  String obs;
  Map<String, Source> source;
  InformationDataModel(
    String id,
  ) : super(id);

  @override
  InformationDataModel fromMap(Map<String, dynamic> map) {
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    return data;
  }
}

//Categoria	CÓDIGO	NOME	DEFINIÇÃO	UNIDADE	FONTE
//Universalização	PT1	População Total do município	Número total de habitantes no município incluindo zona urbana e rural.	Habitantes	IBGE

class Information {
  String code;
  String period; //formato: yyyymm. para ano: 202000. para meses: 202001,202002
  String value; // sim,nao,123.45,
  String userId;
  dynamic dateUpdate;
  Source source;
}

class Source {
  String code;
  String name;
  String site;
  String email;
  String obs;
}
