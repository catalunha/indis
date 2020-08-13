import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:indis/models/info_ind_owner_model.dart';
import 'package:indis/states/app_state.dart';

// +++ Actions Sync
class SetInfoIndOwnerCurrentSyncInfoIndOwnerAction
    extends ReduxAction<AppState> {
  final String id;

  SetInfoIndOwnerCurrentSyncInfoIndOwnerAction(this.id);

  @override
  AppState reduce() {
    InfoIndOwnerModel moduleModel = id == null
        ? InfoIndOwnerModel(null)
        : state.infoIndOwnerState.infoIndOwnerList
            .firstWhere((element) => element.id == id);
    return state.copyWith(
      infoIndOwnerState: state.infoIndOwnerState.copyWith(
        infoIndOwnerCurrent: moduleModel,
      ),
    );
  }
}

// +++ Actions Async
class GetDocsInfoIndOwnerListAsyncInfoIndOwnerAction
    extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    print('GetDocsInfoIndOwnerListAsyncInfoIndOwnerAction...');
    Firestore firestore = Firestore.instance;

    final collRef = firestore.collection(InfoIndOwnerModel.collection);
    final docsSnap = await collRef.getDocuments();

    final listDocs = docsSnap.documents
        .map((docSnap) =>
            InfoIndOwnerModel(docSnap.documentID).fromMap(docSnap.data))
        .toList();
    return state.copyWith(
      infoIndOwnerState: state.infoIndOwnerState.copyWith(
        infoIndOwnerList: listDocs,
      ),
    );
  }
}

class CreateDocInfoIndOwnerCurrentAsyncInfoIndOwnerAction
    extends ReduxAction<AppState> {
  final String code;
  final String name;
  final String description;

  CreateDocInfoIndOwnerCurrentAsyncInfoIndOwnerAction({
    this.code,
    this.name,
    this.description,
  });
  @override
  Future<AppState> reduce() async {
    print('SetDocInfoIndOwnerCurrentAsyncInfoIndOwnerAction...');
    Firestore firestore = Firestore.instance;
    InfoIndOwnerModel infoIndOwnerModel =
        InfoIndOwnerModel(state.infoIndOwnerState.infoIndOwnerCurrent.id)
            .fromMap(state.infoIndOwnerState.infoIndOwnerCurrent.toMap());
    infoIndOwnerModel.code = code;
    infoIndOwnerModel.name = name;
    infoIndOwnerModel.description = description;
    infoIndOwnerModel.arquived = false;
    var docRef = await firestore
        .collection(InfoIndOwnerModel.collection)
        .where('code', isEqualTo: code)
        .getDocuments();
    bool doc = docRef.documents.length != 0;
    if (doc)
      throw const UserException(
          "Esta proprietário de informações e indicadores já foi cadastrado.");
    await firestore
        .collection(InfoIndOwnerModel.collection)
        .document(infoIndOwnerModel.id)
        .setData(infoIndOwnerModel.toMap(), merge: true);
    return state.copyWith(
      infoIndOwnerState: state.infoIndOwnerState.copyWith(
        infoIndOwnerCurrent: infoIndOwnerModel,
      ),
    );
  }

  @override
  Object wrapError(error) => UserException("ATENÇÃO:", cause: error);
  @override
  void after() => dispatch(GetDocsInfoIndOwnerListAsyncInfoIndOwnerAction());
}

class UpdateDocInfoIndOwnerCurrentAsyncInfoIndOwnerAction
    extends ReduxAction<AppState> {
  final String code;
  final String name;
  final String description;
  final bool arquived;

  UpdateDocInfoIndOwnerCurrentAsyncInfoIndOwnerAction({
    this.code,
    this.name,
    this.description,
    this.arquived,
  });
  @override
  Future<AppState> reduce() async {
    print('SetDocInfoIndOwnerCurrentAsyncInfoIndOwnerAction...');
    Firestore firestore = Firestore.instance;
    InfoIndOwnerModel infoIndOwnerModel =
        InfoIndOwnerModel(state.infoIndOwnerState.infoIndOwnerCurrent.id)
            .fromMap(state.infoIndOwnerState.infoIndOwnerCurrent.toMap());
    infoIndOwnerModel.code = code;
    infoIndOwnerModel.name = name;
    infoIndOwnerModel.description = description;
    infoIndOwnerModel.arquived = arquived;
    await firestore
        .collection(InfoIndOwnerModel.collection)
        .document(infoIndOwnerModel.id)
        .updateData(infoIndOwnerModel.toMap());
    return state.copyWith(
      infoIndOwnerState: state.infoIndOwnerState.copyWith(
        infoIndOwnerCurrent: infoIndOwnerModel,
      ),
    );
  }

  @override
  void after() => dispatch(GetDocsInfoIndOwnerListAsyncInfoIndOwnerAction());
}
