import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:indis/models/info_code_model.dart';
import 'package:indis/models/info_setor_model.dart';
import 'package:indis/models/user_model.dart';
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

class SetUserInInfoSetorEditorsSyncInfoSetorAction
    extends ReduxAction<AppState> {
  final UserModel userModel;
  final bool addOrRemove;
  SetUserInInfoSetorEditorsSyncInfoSetorAction({
    this.userModel,
    this.addOrRemove,
  });
  @override
  AppState reduce() {
    InfoSetorModel _infoSetorCurrent =
        InfoSetorModel(state.infoSetorState.infoSetorCurrent.id)
            .fromMap(state.infoSetorState.infoSetorCurrent.toMap());

    if (_infoSetorCurrent.editorsMap == null) {
      _infoSetorCurrent.editorsMap = Map<String, UserModel>();
      print('userModel.id: ${userModel.name}');
    }
    if (addOrRemove) {
      if (!_infoSetorCurrent.editorsMap.containsKey(userModel.id)) {
        _infoSetorCurrent.editorsMap.addAll({userModel.id: userModel});
        return state.copyWith(
          infoSetorState: state.infoSetorState.copyWith(
            infoSetorCurrent: _infoSetorCurrent,
          ),
        );
      } else {
        return null;
      }
    } else {
      _infoSetorCurrent.editorsMap.remove(userModel.id);
      return state.copyWith(
        infoSetorState: state.infoSetorState.copyWith(
          infoSetorCurrent: _infoSetorCurrent,
        ),
      );
    }
  }
}

class SetInfoCodeInInfoSetorValueMapSyncInfoCodeAction
    extends ReduxAction<AppState> {
  final InfoCodeModel infoCodeModel;
  final bool addOrRemove;
  SetInfoCodeInInfoSetorValueMapSyncInfoCodeAction({
    this.infoCodeModel,
    this.addOrRemove,
  });
  @override
  AppState reduce() {
    InfoSetorModel _infoSetorCurrent =
        InfoSetorModel(state.infoSetorState.infoSetorCurrent.id)
            .fromMap(state.infoSetorState.infoSetorCurrent.toMap());

    if (_infoSetorCurrent.valueMap == null) {
      _infoSetorCurrent.valueMap = Map<String, ValueInfo>();
    }
    if (addOrRemove) {
      if (!_infoSetorCurrent.valueMap.containsKey(infoCodeModel.id)) {
        _infoSetorCurrent.valueMap.addAll({
          infoCodeModel.id:
              ValueInfo(infoCodeModel.id, infoCodeRef: infoCodeModel)
        });
        return state.copyWith(
          infoSetorState: state.infoSetorState.copyWith(
            infoSetorCurrent: _infoSetorCurrent,
          ),
        );
      } else {
        return null;
      }
    } else {
      _infoSetorCurrent.valueMap.remove(infoCodeModel.id);
      return state.copyWith(
        infoSetorState: state.infoSetorState.copyWith(
          infoSetorCurrent: _infoSetorCurrent,
        ),
      );
    }
  }
}

// +++ +++++++++++++++++++++++++++++++++++++++++++++++++
// +++ Actions Async
// +++ +++++++++++++++++++++++++++++++++++++++++++++++++
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
  final bool public;

  CreateDocInfoDataCurrentAsyncInfoSetorAction({
    this.uf,
    this.city,
    this.area,
    this.code,
    this.description,
    this.public,
  });
  @override
  Future<AppState> reduce() async {
    print('CreateDocInfoDataCurrentAsyncInfoSetorAction...');
    Firestore firestore = Firestore.instance;
    InfoSetorModel infoDataModel =
        InfoSetorModel(state.infoSetorState.infoSetorCurrent.id)
            .fromMap(state.infoSetorState.infoSetorCurrent.toMap());
    infoDataModel.uf = uf;
    infoDataModel.city = city;
    infoDataModel.area = area;
    infoDataModel.code = code;
    infoDataModel.description = description;
    infoDataModel.public = public;
    infoDataModel.updated = FieldValue.serverTimestamp();
    infoDataModel.userRef = state.loggedState.userModelLogged;
    // var docRef = await firestore
    //     .collection(InfoSetorModel.collection)
    //     .where('code', isEqualTo: code)
    //     .getDocuments();
    // bool doc = docRef.documents.length != 0;
    // if (doc)
    //   throw const UserException(
    //       "Esta proprietário de informações e indicadores já foi cadastrado.");
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
  final bool public;

  UpdateDocInfoDataCurrentAsyncInfoSetorAction({
    this.uf,
    this.city,
    this.area,
    this.code,
    this.description,
    this.public,
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
    infoDataModel.description = description;
    infoDataModel.public = public;
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
