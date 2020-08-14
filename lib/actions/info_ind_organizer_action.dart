import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:indis/models/info_ind_organizer_model.dart';
import 'package:indis/states/app_state.dart';

// +++ Actions Sync
class SetInfoIndOrganizerCurrentSyncInfoIndOrganizerAction
    extends ReduxAction<AppState> {
  final String id;

  SetInfoIndOrganizerCurrentSyncInfoIndOrganizerAction(this.id);

  @override
  AppState reduce() {
    InfoIndOrganizerModel infoIndOrganizerModel = id == null
        ? InfoIndOrganizerModel(null)
        : state.infoIndOrganizerState.infoIndOrganizerList
            .firstWhere((element) => element.id == id);
    return state.copyWith(
      infoIndOrganizerState: state.infoIndOrganizerState.copyWith(
        infoIndOrganizerCurrent: infoIndOrganizerModel,
      ),
    );
  }
}

// +++ Actions Async
class GetDocsInfoIndOrganizerListAsyncInfoIndOrganizerAction
    extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    print('GetDocsInfoIndOrganizerListAsyncInfoIndOrganizerAction...');
    Firestore firestore = Firestore.instance;

    final collRef = firestore.collection(InfoIndOrganizerModel.collection);
    final docsSnap = await collRef.getDocuments();

    final listDocs = docsSnap.documents
        .map((docSnap) =>
            InfoIndOrganizerModel(docSnap.documentID).fromMap(docSnap.data))
        .toList();
    return state.copyWith(
      infoIndOrganizerState: state.infoIndOrganizerState.copyWith(
        infoIndOrganizerList: listDocs,
      ),
    );
  }
}

class CreateDocInfoIndOrganizerCurrentAsyncInfoIndOrganizerAction
    extends ReduxAction<AppState> {
  final String code;
  final String name;
  final String description;

  CreateDocInfoIndOrganizerCurrentAsyncInfoIndOrganizerAction({
    this.code,
    this.name,
    this.description,
  });
  @override
  Future<AppState> reduce() async {
    print('SetDocInfoIndOrganizerCurrentAsyncInfoIndOrganizerAction...');
    Firestore firestore = Firestore.instance;
    InfoIndOrganizerModel infoIndOrganizerModel = InfoIndOrganizerModel(
            state.infoIndOrganizerState.infoIndOrganizerCurrent.id)
        .fromMap(state.infoIndOrganizerState.infoIndOrganizerCurrent.toMap());
    infoIndOrganizerModel.name = name;
    infoIndOrganizerModel.description = description;
    var docRef = await firestore
        .collection(InfoIndOrganizerModel.collection)
        .where('code', isEqualTo: code)
        .getDocuments();
    bool doc = docRef.documents.length != 0;
    if (doc)
      throw const UserException(
          "Esta proprietário de informações e indicadores já foi cadastrado.");
    await firestore
        .collection(InfoIndOrganizerModel.collection)
        .document(infoIndOrganizerModel.id)
        .setData(infoIndOrganizerModel.toMap(), merge: true);
    return state.copyWith(
      infoIndOrganizerState: state.infoIndOrganizerState.copyWith(
        infoIndOrganizerCurrent: infoIndOrganizerModel,
      ),
    );
  }

  @override
  Object wrapError(error) => UserException("ATENÇÃO:", cause: error);
  @override
  void after() =>
      dispatch(GetDocsInfoIndOrganizerListAsyncInfoIndOrganizerAction());
}

class UpdateDocInfoIndOrganizerCurrentAsyncInfoIndOrganizerAction
    extends ReduxAction<AppState> {
  final String code;
  final String name;
  final String description;
  final bool arquived;

  UpdateDocInfoIndOrganizerCurrentAsyncInfoIndOrganizerAction({
    this.code,
    this.name,
    this.description,
    this.arquived,
  });
  @override
  Future<AppState> reduce() async {
    print('SetDocInfoIndOrganizerCurrentAsyncInfoIndOrganizerAction...');
    Firestore firestore = Firestore.instance;
    InfoIndOrganizerModel infoIndOrganizerModel = InfoIndOrganizerModel(
            state.infoIndOrganizerState.infoIndOrganizerCurrent.id)
        .fromMap(state.infoIndOrganizerState.infoIndOrganizerCurrent.toMap());
    infoIndOrganizerModel.name = name;
    infoIndOrganizerModel.description = description;
    await firestore
        .collection(InfoIndOrganizerModel.collection)
        .document(infoIndOrganizerModel.id)
        .updateData(infoIndOrganizerModel.toMap());
    return state.copyWith(
      infoIndOrganizerState: state.infoIndOrganizerState.copyWith(
        infoIndOrganizerCurrent: infoIndOrganizerModel,
      ),
    );
  }

  @override
  void after() =>
      dispatch(GetDocsInfoIndOrganizerListAsyncInfoIndOrganizerAction());
}
