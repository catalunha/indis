import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:indis/models/info_data_model.dart';
import 'package:indis/states/app_state.dart';

// +++ Actions Sync
class SetInfoDataCurrentSyncInfoDataAction extends ReduxAction<AppState> {
  final String id;

  SetInfoDataCurrentSyncInfoDataAction(this.id);

  @override
  AppState reduce() {
    InfoDataModel infoDataModel = id == null
        ? InfoDataModel(null)
        : state.infoDataState.infoDataList
            .firstWhere((element) => element.id == id);
    return state.copyWith(
      infoDataState: state.infoDataState.copyWith(
        infoDataCurrent: infoDataModel,
      ),
    );
  }
}

// +++ Actions Async
class GetDocsInfoDataListAsyncInfoDataAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    print('GetDocsInfoDataListAsyncInfoDataAction...');
    Firestore firestore = Firestore.instance;

    final collRef = firestore.collection(InfoDataModel.collection);
    final docsSnap = await collRef.getDocuments();

    final listDocs = docsSnap.documents
        .map((docSnap) =>
            InfoDataModel(docSnap.documentID).fromMap(docSnap.data))
        .toList();
    return state.copyWith(
      infoDataState: state.infoDataState.copyWith(
        infoDataList: listDocs,
      ),
    );
  }
}

class CreateDocInfoDataCurrentAsyncInfoDataAction
    extends ReduxAction<AppState> {
  final String uf;
  final String city;
  final String area;
  final String code;
  final String description;
  final dynamic updated;

  CreateDocInfoDataCurrentAsyncInfoDataAction({
    this.uf,
    this.city,
    this.area,
    this.code,
    this.description,
    this.updated,
  });
  @override
  Future<AppState> reduce() async {
    print('SetDocInfoDataCurrentAsyncInfoDataAction...');
    Firestore firestore = Firestore.instance;
    InfoDataModel infoDataModel =
        InfoDataModel(state.infoDataState.infoDataCurrent.id)
            .fromMap(state.infoDataState.infoDataCurrent.toMap());
    infoDataModel.uf = uf;
    infoDataModel.city = city;
    infoDataModel.area = area;
    infoDataModel.code = code;
    infoDataModel.updated = updated;
    infoDataModel.description = description;
    infoDataModel.updated = FieldValue.serverTimestamp();

    var docRef = await firestore
        .collection(InfoDataModel.collection)
        .where('code', isEqualTo: code)
        .getDocuments();
    bool doc = docRef.documents.length != 0;
    if (doc)
      throw const UserException(
          "Esta proprietário de informações e indicadores já foi cadastrado.");
    await firestore
        .collection(InfoDataModel.collection)
        .document(infoDataModel.id)
        .setData(infoDataModel.toMap(), merge: true);
    return state.copyWith(
      infoDataState: state.infoDataState.copyWith(
        infoDataCurrent: infoDataModel,
      ),
    );
  }

  @override
  Object wrapError(error) => UserException("ATENÇÃO:", cause: error);
  @override
  void after() => dispatch(GetDocsInfoDataListAsyncInfoDataAction());
}

class UpdateDocInfoDataCurrentAsyncInfoDataAction
    extends ReduxAction<AppState> {
  final String uf;
  final String city;
  final String area;
  final String code;
  final String description;
  final dynamic updated;

  UpdateDocInfoDataCurrentAsyncInfoDataAction({
    this.uf,
    this.city,
    this.area,
    this.code,
    this.description,
    this.updated,
  });
  @override
  Future<AppState> reduce() async {
    print('SetDocInfoDataCurrentAsyncInfoDataAction...');
    Firestore firestore = Firestore.instance;
    InfoDataModel infoDataModel =
        InfoDataModel(state.infoDataState.infoDataCurrent.id)
            .fromMap(state.infoDataState.infoDataCurrent.toMap());
    infoDataModel.uf = uf;
    infoDataModel.city = city;
    infoDataModel.area = area;
    infoDataModel.code = code;
    infoDataModel.updated = updated;
    infoDataModel.description = description;
    infoDataModel.updated = FieldValue.serverTimestamp();

    await firestore
        .collection(InfoDataModel.collection)
        .document(infoDataModel.id)
        .updateData(infoDataModel.toMap());
    return state.copyWith(
      infoDataState: state.infoDataState.copyWith(
        infoDataCurrent: infoDataModel,
      ),
    );
  }

  @override
  void after() => dispatch(GetDocsInfoDataListAsyncInfoDataAction());
}
