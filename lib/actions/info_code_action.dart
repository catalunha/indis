import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:indis/models/info_code_model.dart';
import 'package:indis/models/info_ind_owner_model.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/states/types_states.dart';

// +++ Actions Sync
class SetInfoCodeCurrentSyncInfoCodeAction extends ReduxAction<AppState> {
  final String id;

  SetInfoCodeCurrentSyncInfoCodeAction(this.id);

  @override
  AppState reduce() {
    InfoCodeModel infoCodeModel = id == null
        ? InfoCodeModel(null)
        : state.infoCodeState.infoCodeList
            .firstWhere((element) => element.id == id);
    return state.copyWith(
      infoCodeState: state.infoCodeState.copyWith(
        infoCodeCurrent: infoCodeModel,
      ),
    );
  }
}

class SetInfoIndOwnerInInfoCodeSyncInfoCodeAction
    extends ReduxAction<AppState> {
  final InfoIndOwnerModel infoIndOwnerModel;
  SetInfoIndOwnerInInfoCodeSyncInfoCodeAction({this.infoIndOwnerModel});
  @override
  AppState reduce() {
    InfoCodeModel _infoCodeModel =
        InfoCodeModel(state.infoCodeState.infoCodeCurrent.id)
            .fromMap(state.infoCodeState.infoCodeCurrent.toMap());
    _infoCodeModel.infoIndOwnerRef = infoIndOwnerModel;
    return state.copyWith(
      infoCodeState: state.infoCodeState.copyWith(
        infoCodeCurrent: _infoCodeModel,
      ),
    );
  }
}

class SetInfoCodeInInfoCodeCloneMapSyncInfoCodeAction
    extends ReduxAction<AppState> {
  final InfoCodeModel infoCodeModel;
  final bool addOrRemove;
  SetInfoCodeInInfoCodeCloneMapSyncInfoCodeAction({
    this.infoCodeModel,
    this.addOrRemove,
  });
  @override
  AppState reduce() {
    InfoCodeModel _infoCodeModel =
        InfoCodeModel(state.infoCodeState.infoCodeCurrent.id)
            .fromMap(state.infoCodeState.infoCodeCurrent.toMap());

    if (_infoCodeModel.cloneMap == null)
      _infoCodeModel.cloneMap = Map<String, InfoCodeModel>();
    if (addOrRemove) {
      if (!_infoCodeModel.cloneMap.containsKey(infoCodeModel.id)) {
        _infoCodeModel.cloneMap.addAll({infoCodeModel.id: infoCodeModel});
        return state.copyWith(
          infoCodeState: state.infoCodeState.copyWith(
            infoCodeCurrent: _infoCodeModel,
          ),
        );
      } else {
        return null;
      }
    } else {
      _infoCodeModel.cloneMap.remove(infoCodeModel.id);
      return state.copyWith(
        infoCodeState: state.infoCodeState.copyWith(
          infoCodeCurrent: _infoCodeModel,
        ),
      );
    }
  }
}

class SetInfoCodeInInfoCodeLinkMapSyncInfoCodeAction
    extends ReduxAction<AppState> {
  final InfoCodeModel infoCodeModel;
  final bool addOrRemove;
  SetInfoCodeInInfoCodeLinkMapSyncInfoCodeAction({
    this.infoCodeModel,
    this.addOrRemove,
  });
  @override
  AppState reduce() {
    InfoCodeModel _infoCodeModel =
        InfoCodeModel(state.infoCodeState.infoCodeCurrent.id)
            .fromMap(state.infoCodeState.infoCodeCurrent.toMap());

    if (_infoCodeModel.linkMap == null)
      _infoCodeModel.linkMap = Map<String, InfoCodeModel>();
    if (addOrRemove) {
      if (!_infoCodeModel.linkMap.containsKey(infoCodeModel.id)) {
        _infoCodeModel.linkMap.addAll({infoCodeModel.id: infoCodeModel});
        return state.copyWith(
          infoCodeState: state.infoCodeState.copyWith(
            infoCodeCurrent: _infoCodeModel,
          ),
        );
      } else {
        return null;
      }
    } else {
      _infoCodeModel.linkMap.remove(infoCodeModel.id);
      return state.copyWith(
        infoCodeState: state.infoCodeState.copyWith(
          infoCodeCurrent: _infoCodeModel,
        ),
      );
    }
  }
}

class SetInfoCodeOrderSyncInfoCodeAction extends ReduxAction<AppState> {
  final InfoCodeOrder infoCodeOrder;

  SetInfoCodeOrderSyncInfoCodeAction(this.infoCodeOrder);
  @override
  AppState reduce() {
    List<InfoCodeModel> _infoCodeList = [];
    _infoCodeList.addAll(state.infoCodeState.infoCodeList);
    if (infoCodeOrder == InfoCodeOrder.code) {
      _infoCodeList.sort((a, b) => a.code.compareTo(b.code));
    } else if (infoCodeOrder == InfoCodeOrder.name) {
      _infoCodeList.sort((a, b) => a.name.compareTo(b.name));
    } else if (infoCodeOrder == InfoCodeOrder.unit) {
      _infoCodeList.sort((a, b) => a.unit.compareTo(b.unit));
    } else if (infoCodeOrder == InfoCodeOrder.infoIndOwnerRefName) {
      _infoCodeList.sort(
          (a, b) => a.infoIndOwnerRef.name.compareTo(b.infoIndOwnerRef.name));
    }
    return state.copyWith(
      infoCodeState: state.infoCodeState.copyWith(
        infoCodeOrder: infoCodeOrder,
        infoCodeList: _infoCodeList,
      ),
    );
  }
}

// +++ Actions Async
class GetDocsInfoCodeListAsyncInfoCodeAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    print('GetDocsInfoCodeListAsyncInfoCodeAction...');
    Firestore firestore = Firestore.instance;

    final collRef = firestore.collection(InfoCodeModel.collection);
    final docsSnap = await collRef.getDocuments();

    final listDocs = docsSnap.documents
        .map((docSnap) =>
            InfoCodeModel(docSnap.documentID).fromMap(docSnap.data))
        .toList();
    return state.copyWith(
      infoCodeState: state.infoCodeState.copyWith(
        infoCodeList: listDocs,
      ),
    );
  }
}

class CreateDocInfoCodeCurrentAsyncInfoCodeAction
    extends ReduxAction<AppState> {
  final String code;
  final String name;
  final String description;
  final String unit;
  final bool isNumber;

  CreateDocInfoCodeCurrentAsyncInfoCodeAction({
    this.code,
    this.name,
    this.description,
    this.unit,
    this.isNumber,
  });
  @override
  Future<AppState> reduce() async {
    print('SetDocInfoCodeCurrentAsyncInfoCodeAction...');
    Firestore firestore = Firestore.instance;
    InfoCodeModel infoCodeModel =
        InfoCodeModel(state.infoCodeState.infoCodeCurrent.id)
            .fromMap(state.infoCodeState.infoCodeCurrent.toMap());
    infoCodeModel.code = code;
    infoCodeModel.name = name;
    infoCodeModel.description = description;
    infoCodeModel.unit = unit;
    infoCodeModel.arquived = false;
    var docRef = await firestore
        .collection(InfoCodeModel.collection)
        .where('code', isEqualTo: code)
        .getDocuments();
    bool doc = docRef.documents.length != 0;
    if (doc)
      throw const UserException(
          "Esta proprietário de informações e indicadores já foi cadastrado.");
    await firestore
        .collection(InfoCodeModel.collection)
        .document(infoCodeModel.id)
        .setData(infoCodeModel.toMap(), merge: true);
    return state.copyWith(
      infoCodeState: state.infoCodeState.copyWith(
        infoCodeCurrent: infoCodeModel,
      ),
    );
  }

  @override
  Object wrapError(error) => UserException("ATENÇÃO:", cause: error);
  @override
  void after() => dispatch(GetDocsInfoCodeListAsyncInfoCodeAction());
}

class UpdateDocInfoCodeCurrentAsyncInfoCodeAction
    extends ReduxAction<AppState> {
  final String code;
  final String name;
  final String description;
  final String unit;
  final bool arquived;

  UpdateDocInfoCodeCurrentAsyncInfoCodeAction({
    this.code,
    this.name,
    this.description,
    this.unit,
    this.arquived,
  });
  @override
  Future<AppState> reduce() async {
    print('SetDocInfoCodeCurrentAsyncInfoCodeAction...');
    Firestore firestore = Firestore.instance;
    InfoCodeModel infoCodeModel =
        InfoCodeModel(state.infoCodeState.infoCodeCurrent.id)
            .fromMap(state.infoCodeState.infoCodeCurrent.toMap());
    infoCodeModel.code = code;
    infoCodeModel.name = name;
    infoCodeModel.description = description;
    infoCodeModel.unit = unit;
    infoCodeModel.arquived = arquived;
    await firestore
        .collection(InfoCodeModel.collection)
        .document(infoCodeModel.id)
        .updateData(infoCodeModel.toMap());
    return state.copyWith(
      infoCodeState: state.infoCodeState.copyWith(
        infoCodeCurrent: infoCodeModel,
      ),
    );
  }

  @override
  void after() => dispatch(GetDocsInfoCodeListAsyncInfoCodeAction());
}
