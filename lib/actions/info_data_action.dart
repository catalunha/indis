import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:indis/models/info_setor_model.dart';
import 'package:indis/states/app_state.dart';

// +++ Actions Sync
class SetInfoDataCurrentSyncInfoSetorAction extends ReduxAction<AppState> {
  final String id;

  SetInfoDataCurrentSyncInfoSetorAction(this.id);

  @override
  AppState reduce() {
    InfoSetorModel infoSetorModel = id == null
        ? InfoSetorModel(null)
        : state.infoSetorState.infoSetorList
            .firstWhere((element) => element.id == id);
    return state.copyWith(
      infoSetorState: state.infoSetorState.copyWith(
        infoSetorCurrent: infoSetorModel,
      ),
    );
  }
}

// +++ Actions Async
class GetDocsInfoDataListAsyncInfoSetorAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    print('GetDocsInfoDataListAsyncInfoSetorAction...');
    Firestore firestore = Firestore.instance;

    final collRef = firestore.collection(InfoSetorModel.collection);
    final docsSnap = await collRef.getDocuments();

    final listDocs = docsSnap.documents
        .map((docSnap) =>
            InfoSetorModel(docSnap.documentID).fromMap(docSnap.data))
        .toList();
    return state.copyWith(
      infoSetorState: state.infoSetorState.copyWith(
        infoSetorList: listDocs,
      ),
    );
  }
}

class CreateDocInfoDataCurrentAsyncInfoSetorAction
    extends ReduxAction<AppState> {
  final String uf;
  final String city;
  final String area;
  final String code;
  final String description;
  final dynamic updated;

  CreateDocInfoDataCurrentAsyncInfoSetorAction({
    this.uf,
    this.city,
    this.area,
    this.code,
    this.description,
    this.updated,
  });
  @override
  Future<AppState> reduce() async {
    print('SetDocInfoDataCurrentAsyncInfoSetorAction...');
    Firestore firestore = Firestore.instance;
    InfoSetorModel infoDataModel =
        InfoSetorModel(state.infoSetorState.infoSetorCurrent.id)
            .fromMap(state.infoSetorState.infoSetorCurrent.toMap());
    infoDataModel.uf = uf;
    infoDataModel.city = city;
    infoDataModel.area = area;
    infoDataModel.code = code;
    infoDataModel.updated = updated;
    infoDataModel.description = description;
    infoDataModel.updated = FieldValue.serverTimestamp();

    var docRef = await firestore
        .collection(InfoSetorModel.collection)
        .where('code', isEqualTo: code)
        .getDocuments();
    bool doc = docRef.documents.length != 0;
    if (doc)
      throw const UserException(
          "Esta proprietário de informações e indicadores já foi cadastrado.");
    await firestore
        .collection(InfoSetorModel.collection)
        .document(infoDataModel.id)
        .setData(infoDataModel.toMap(), merge: true);
    return state.copyWith(
      infoSetorState: state.infoSetorState.copyWith(
        infoSetorCurrent: infoDataModel,
      ),
    );
  }

  @override
  Object wrapError(error) => UserException("ATENÇÃO:", cause: error);
  @override
  void after() => dispatch(GetDocsInfoDataListAsyncInfoSetorAction());
}

class UpdateDocInfoDataCurrentAsyncInfoSetorAction
    extends ReduxAction<AppState> {
  final String uf;
  final String city;
  final String area;
  final String code;
  final String description;
  final dynamic updated;

  UpdateDocInfoDataCurrentAsyncInfoSetorAction({
    this.uf,
    this.city,
    this.area,
    this.code,
    this.description,
    this.updated,
  });
  @override
  Future<AppState> reduce() async {
    print('SetDocInfoDataCurrentAsyncInfoSetorAction...');
    Firestore firestore = Firestore.instance;
    InfoSetorModel infoDataModel =
        InfoSetorModel(state.infoSetorState.infoSetorCurrent.id)
            .fromMap(state.infoSetorState.infoSetorCurrent.toMap());
    infoDataModel.uf = uf;
    infoDataModel.city = city;
    infoDataModel.area = area;
    infoDataModel.code = code;
    infoDataModel.updated = updated;
    infoDataModel.description = description;
    infoDataModel.updated = FieldValue.serverTimestamp();

    await firestore
        .collection(InfoSetorModel.collection)
        .document(infoDataModel.id)
        .updateData(infoDataModel.toMap());
    return state.copyWith(
      infoSetorState: state.infoSetorState.copyWith(
        infoSetorCurrent: infoDataModel,
      ),
    );
  }

  @override
  void after() => dispatch(GetDocsInfoDataListAsyncInfoSetorAction());
}
