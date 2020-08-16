import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:indis/models/info_category_model.dart';
import 'package:indis/models/info_code_model.dart';
import 'package:indis/models/info_ind_owner_model.dart';
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
  Object wrapError(error) => UserException("ATENÇÃO:", cause: error);
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
    infoCategoryModel.name = name;
    infoCategoryModel.description = description;
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

// class SetInfoCodeInInfoCategorySyncInfoCategoryAction
//     extends ReduxAction<AppState> {
//   final InfoCodeModel infoCodeRef;
//   final bool addOrRemove;
//   SetInfoCodeInInfoCategorySyncInfoCategoryAction({
//     this.infoCodeRef,
//     this.addOrRemove,
//   });
//   @override
//   AppState reduce() {
//     InfoCategoryModel infoCategoryModel =
//         InfoCategoryModel(state.infoCategoryState.infoCategoryCurrent.id)
//             .fromMap(state.infoCategoryState.infoCategoryCurrent.toMap());

//     if (infoCategoryModel.infoCodeRefMap == null)
//       infoCategoryModel.infoCodeRefMap = Map<String, InfoCodeModel>();
//     if (addOrRemove) {
//       if (!infoCategoryModel.infoCodeRefMap.containsKey(infoCodeRef.id)) {
//         infoCategoryModel.infoCodeRefMap.addAll({infoCodeRef.id: infoCodeRef});
//         print(
//             'infoCategoryModel.infoCodeRefMap1: ${infoCategoryModel.infoCodeRefMap}');
//         return state.copyWith(
//           infoCategoryState: state.infoCategoryState.copyWith(
//             infoCategoryCurrent: infoCategoryModel,
//           ),
//         );
//       } else {
//         print(
//             'infoCategoryModel.infoCodeRefMap2: ${infoCategoryModel.infoCodeRefMap}');
//         return null;
//       }
//     } else {
//       infoCategoryModel.infoCodeRefMap.remove(infoCodeRef.id);
//       print(
//           'infoCategoryModel.infoCodeRefMap3: ${infoCategoryModel.infoCodeRefMap}');
//       return state.copyWith(
//         infoCategoryState: state.infoCategoryState.copyWith(
//           infoCategoryCurrent: infoCategoryModel,
//         ),
//       );
//     }
//   }
// }
