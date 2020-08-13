import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:indis/models/info_category_model.dart';
import 'package:indis/states/app_state.dart';

// +++ Actions Sync
class SetInfoCategoryCurrentSyncInfoCategoryAction
    extends ReduxAction<AppState> {
  final String id;

  SetInfoCategoryCurrentSyncInfoCategoryAction(this.id);

  @override
  AppState reduce() {
    InfoCategoryModel infoCategoryModel = id == null
        ? InfoCategoryModel(null)
        : state.infoCategoryState.infoCategoryList
            .firstWhere((element) => element.id == id);
    return state.copyWith(
      infoCategoryState: state.infoCategoryState.copyWith(
        infoCategoryCurrent: infoCategoryModel,
      ),
    );
  }
}

// +++ Actions Async
class GetDocsInfoCategoryListAsyncInfoCategoryAction
    extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    print('GetDocsInfoCategoryListAsyncInfoCategoryAction...');
    Firestore firestore = Firestore.instance;

    final collRef = firestore.collection(InfoCategoryModel.collection);
    final docsSnap = await collRef.getDocuments();

    final listDocs = docsSnap.documents
        .map((docSnap) =>
            InfoCategoryModel(docSnap.documentID).fromMap(docSnap.data))
        .toList();
    return state.copyWith(
      infoCategoryState: state.infoCategoryState.copyWith(
        infoCategoryList: listDocs,
      ),
    );
  }
}

class CreateDocInfoCategoryCurrentAsyncInfoCategoryAction
    extends ReduxAction<AppState> {
  final String code;
  final String name;
  final String description;

  CreateDocInfoCategoryCurrentAsyncInfoCategoryAction({
    this.code,
    this.name,
    this.description,
  });
  @override
  Future<AppState> reduce() async {
    print('SetDocInfoCategoryCurrentAsyncInfoCategoryAction...');
    Firestore firestore = Firestore.instance;
    InfoCategoryModel infoCategoryModel =
        InfoCategoryModel(state.infoCategoryState.infoCategoryCurrent.id)
            .fromMap(state.infoCategoryState.infoCategoryCurrent.toMap());
    infoCategoryModel.name = name;
    var docRef = await firestore
        .collection(InfoCategoryModel.collection)
        .where('code', isEqualTo: code)
        .getDocuments();
    bool doc = docRef.documents.length != 0;
    if (doc)
      throw const UserException(
          "Esta proprietário de informações e indicadores já foi cadastrado.");
    await firestore
        .collection(InfoCategoryModel.collection)
        .document(infoCategoryModel.id)
        .setData(infoCategoryModel.toMap(), merge: true);
    return state.copyWith(
      infoCategoryState: state.infoCategoryState.copyWith(
        infoCategoryCurrent: infoCategoryModel,
      ),
    );
  }

  @override
  Object wrapError(error) => UserException("ATENÇÃO:", cause: error);
  @override
  void after() => dispatch(GetDocsInfoCategoryListAsyncInfoCategoryAction());
}

class UpdateDocInfoCategoryCurrentAsyncInfoCategoryAction
    extends ReduxAction<AppState> {
  final String code;
  final String name;
  final String description;
  final bool arquived;

  UpdateDocInfoCategoryCurrentAsyncInfoCategoryAction({
    this.code,
    this.name,
    this.description,
    this.arquived,
  });
  @override
  Future<AppState> reduce() async {
    print('SetDocInfoCategoryCurrentAsyncInfoCategoryAction...');
    Firestore firestore = Firestore.instance;
    InfoCategoryModel infoCategoryModel =
        InfoCategoryModel(state.infoCategoryState.infoCategoryCurrent.id)
            .fromMap(state.infoCategoryState.infoCategoryCurrent.toMap());
    infoCategoryModel.name = name;
    await firestore
        .collection(InfoCategoryModel.collection)
        .document(infoCategoryModel.id)
        .updateData(infoCategoryModel.toMap());
    return state.copyWith(
      infoCategoryState: state.infoCategoryState.copyWith(
        infoCategoryCurrent: infoCategoryModel,
      ),
    );
  }

  @override
  void after() => dispatch(GetDocsInfoCategoryListAsyncInfoCategoryAction());
}
