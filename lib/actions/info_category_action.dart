import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:indis/models/info_category_model.dart';
import 'package:indis/models/info_code_model.dart';
import 'package:indis/models/info_ind_owner_model.dart';
import 'package:indis/states/app_state.dart';
import 'package:uuid/uuid.dart' as uuid;

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

class SetInfoCategoryItemCurrentSyncInfoCategoryAction
    extends ReduxAction<AppState> {
  final String id;
  final bool isCreateOrUpdate;

  SetInfoCategoryItemCurrentSyncInfoCategoryAction(
      {this.id, this.isCreateOrUpdate});

  @override
  AppState reduce() {
    InfoCategoryItem categoryData;
    if (isCreateOrUpdate) {
      categoryData = InfoCategoryItem(null);
      categoryData.idParente = id;
    } else {
      categoryData = state.infoCategoryState.infoCategoryCurrent.itemMap[id];
    }

    return state.copyWith(
      infoCategoryState: state.infoCategoryState.copyWith(
        infoCategoryItemCurrent: categoryData,
      ),
    );
  }
}

class CreateInfoCategoryItemCurrentSyncInfoCategoryAction
    extends ReduxAction<AppState> {
  final String name;
  final String description;

  CreateInfoCategoryItemCurrentSyncInfoCategoryAction({
    this.name,
    this.description,
  });
  @override
  AppState reduce() {
    print('CreateInfoCategoryDataCurrentSyncInfoCategoryAction...');
    InfoCategoryItem categoryData;
    categoryData = state.infoCategoryState.infoCategoryItemCurrent;
    categoryData.id = uuid.Uuid().v4();
    categoryData.name = name;
    categoryData.description = description;
    categoryData.infoCodeRefMap = Map<String, InfoCodeModel>();
    InfoCategoryModel infoCategoryModel =
        InfoCategoryModel(state.infoCategoryState.infoCategoryCurrent.id)
            .fromMap(state.infoCategoryState.infoCategoryCurrent.toMap());
    if (infoCategoryModel.itemMap == null) {
      infoCategoryModel.itemMap = Map<String, InfoCategoryItem>();
    }

    infoCategoryModel.itemMap[categoryData.id] = categoryData;

    return state.copyWith(
      infoCategoryState: state.infoCategoryState.copyWith(
        infoCategoryCurrent: infoCategoryModel,
      ),
    );
  }

  @override
  Object wrapError(error) => UserException("ATENÇÃO1:", cause: error);
  @override
  void after() =>
      dispatch(UpdateDocInfoCategoryCurrentAsyncInfoCategoryAction());
}

class UpdateInfoCategoryItemCurrentSyncInfoCategoryAction
    extends ReduxAction<AppState> {
  final String name;
  final String description;
  final bool remover;

  UpdateInfoCategoryItemCurrentSyncInfoCategoryAction({
    this.name,
    this.description,
    this.remover,
  });
  @override
  AppState reduce() {
    print('UpdateInfoCategoryDataCurrentSyncInfoCategoryAction...');
    InfoCategoryItem categoryData;
    categoryData = state.infoCategoryState.infoCategoryItemCurrent;

    InfoCategoryModel infoCategoryModel =
        InfoCategoryModel(state.infoCategoryState.infoCategoryCurrent.id)
            .fromMap(state.infoCategoryState.infoCategoryCurrent.toMap());
    if (remover) {
      infoCategoryModel.itemMap
          .removeWhere((k, v) => v.idParente == categoryData.id);
      infoCategoryModel.itemMap.remove(categoryData.id);
    } else {
      categoryData.name = name;
      categoryData.description = description;
      infoCategoryModel.itemMap[categoryData.id] = categoryData;
    }
    return state.copyWith(
      infoCategoryState: state.infoCategoryState.copyWith(
        infoCategoryCurrent: infoCategoryModel,
      ),
    );
  }

  @override
  Object wrapError(error) => UserException("ATENÇÃO2:", cause: error);
  @override
  void after() =>
      dispatch(UpdateDocInfoCategoryCurrentAsyncInfoCategoryAction());
}

class SetInfoCodeInInfoCategoryItemSyncInfoCategoryAction
    extends ReduxAction<AppState> {
  final InfoCodeModel infoCodeRef;
  final bool addOrRemove;
  SetInfoCodeInInfoCategoryItemSyncInfoCategoryAction({
    this.infoCodeRef,
    this.addOrRemove,
  });
  @override
  AppState reduce() {
    InfoCategoryItem categoryData;
    categoryData = state.infoCategoryState.infoCategoryItemCurrent;
    if (categoryData.infoCodeRefMap == null)
      categoryData.infoCodeRefMap = Map<String, InfoCodeModel>();
    if (addOrRemove) {
      if (!categoryData.infoCodeRefMap.containsKey(infoCodeRef.id)) {
        categoryData.infoCodeRefMap[infoCodeRef.id] = infoCodeRef;
      }
    } else {
      categoryData.infoCodeRefMap.remove(infoCodeRef.id);
    }
    InfoCategoryModel infoCategoryModel =
        InfoCategoryModel(state.infoCategoryState.infoCategoryCurrent.id)
            .fromMap(state.infoCategoryState.infoCategoryCurrent.toMap());
    infoCategoryModel.itemMap[categoryData.id] = categoryData;
    return state.copyWith(
      infoCategoryState: state.infoCategoryState.copyWith(
        infoCategoryCurrent: infoCategoryModel,
      ),
    );
  }

  @override
  void after() =>
      dispatch(UpdateDocInfoCategoryCurrentAsyncInfoCategoryAction());
}

class SetInfoIndOwnerInInfoCategorySyncInfoCategoryAction
    extends ReduxAction<AppState> {
  final String infoIndOwnerCode;
  SetInfoIndOwnerInInfoCategorySyncInfoCategoryAction({this.infoIndOwnerCode});
  @override
  Future<AppState> reduce() async {
    InfoCategoryModel _infoCategoryCurrent =
        InfoCategoryModel(state.infoCategoryState.infoCategoryCurrent.id)
            .fromMap(state.infoCategoryState.infoCategoryCurrent.toMap());

    Firestore firestore = Firestore.instance;

    final docRef = await firestore
        .collection(InfoCategoryModel.collection)
        .where('name', isEqualTo: infoIndOwnerCode)
        .getDocuments();

    InfoCategoryModel _infoCategoryWithItem =
        InfoCategoryModel(docRef.documents.first.documentID)
            .fromMap(docRef.documents.first.data);

    _infoCategoryCurrent.itemMap = Map<String, InfoCategoryItem>();
    _infoCategoryCurrent.itemMap.addAll(_infoCategoryWithItem.itemMap);

    return state.copyWith(
      infoCategoryState: state.infoCategoryState.copyWith(
        infoCategoryCurrent: _infoCategoryCurrent,
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
  final String name;
  final String description;

  CreateDocInfoCategoryCurrentAsyncInfoCategoryAction({
    this.name,
    this.description,
  });
  @override
  Future<AppState> reduce() async {
    print('CreateDocInfoCategoryCurrentAsyncInfoCategoryAction...');
    Firestore firestore = Firestore.instance;
    InfoCategoryModel infoCategoryModel =
        InfoCategoryModel(state.infoCategoryState.infoCategoryCurrent.id)
            .fromMap(state.infoCategoryState.infoCategoryCurrent.toMap());
    infoCategoryModel.name = name;
    infoCategoryModel.description = description;
    infoCategoryModel.userRef = state.loggedState.userModelLogged;
    var docRef = await firestore
        .collection(InfoCategoryModel.collection)
        .where('name', isEqualTo: name)
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
  Object wrapError(error) => UserException("ATENÇÃO3:", cause: error);
  @override
  void after() => dispatch(GetDocsInfoCategoryListAsyncInfoCategoryAction());
}

class UpdateDocInfoCategoryCurrentAsyncInfoCategoryAction
    extends ReduxAction<AppState> {
  final String name;
  final String description;

  UpdateDocInfoCategoryCurrentAsyncInfoCategoryAction({
    this.name,
    this.description,
  });
  @override
  Future<AppState> reduce() async {
    print('UpdateDocInfoCategoryCurrentAsyncInfoCategoryAction...');
    Firestore firestore = Firestore.instance;
    InfoCategoryModel infoCategoryModel =
        InfoCategoryModel(state.infoCategoryState.infoCategoryCurrent.id)
            .fromMap(state.infoCategoryState.infoCategoryCurrent.toMap());
    infoCategoryModel.name = name ?? infoCategoryModel.name;
    infoCategoryModel.description =
        description ?? infoCategoryModel.description;
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
