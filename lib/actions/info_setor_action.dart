import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:indis/models/info_code_model.dart';
import 'package:indis/models/info_setor_model.dart';
import 'package:indis/models/user_model.dart';
import 'package:indis/states/app_state.dart';
import 'package:uuid/uuid.dart' as uuid;

// +++ Actions Sync
class SetInfoSetorCurrentSyncInfoSetorAction extends ReduxAction<AppState> {
  final String id;

  SetInfoSetorCurrentSyncInfoSetorAction(this.id);

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

class SetInfoSetorSourceCurrentSyncInfoSetorAction
    extends ReduxAction<AppState> {
  final String infoSetorSourceId;

  SetInfoSetorSourceCurrentSyncInfoSetorAction(this.infoSetorSourceId);

  @override
  AppState reduce() {
    print('SetInfoSetorSourceCurrentSyncInfoSetorAction...');
    InfoSetorSourceModel _infoSetorSourceModel = infoSetorSourceId == null
        ? InfoSetorSourceModel(null)
        : state.infoSetorState.infoSetorCurrent.sourceMap[infoSetorSourceId];
    return state.copyWith(
      infoSetorState: state.infoSetorState.copyWith(
        infoSetorSourceCurrent: _infoSetorSourceModel,
      ),
    );
  }
}

class SetInfoSetorValueCurrentSyncInfoSetorAction
    extends ReduxAction<AppState> {
  final String infoSetorValueId;

  SetInfoSetorValueCurrentSyncInfoSetorAction(this.infoSetorValueId);

  @override
  AppState reduce() {
    print('SetInfoSetorValueCurrentSyncInfoSetorAction...');
    InfoSetorValueModel _infoSetorValueModel =
        state.infoSetorState.infoSetorCurrent.valueMap[infoSetorValueId];

    List<InfoSetorValueDataModel> _valueDataList = [];
    if (_infoSetorValueModel.valueDataMap != null) {
      _valueDataList = _infoSetorValueModel.valueDataMap.values.toList();
    }

    return state.copyWith(
      infoSetorState: state.infoSetorState.copyWith(
        infoSetorValueCurrent: _infoSetorValueModel,
        infoSetorValueDataList: _valueDataList,
      ),
    );
  }
}

class SetInfoSetorValueDataCurrentSyncInfoSetorAction
    extends ReduxAction<AppState> {
  final String infoSetorValueDataId;

  SetInfoSetorValueDataCurrentSyncInfoSetorAction(this.infoSetorValueDataId);

  @override
  AppState reduce() {
    print('SetInfoSetorValueDataCurrentSyncInfoSetorAction...');
    InfoSetorValueDataModel _infoSetorValueDataModel =
        infoSetorValueDataId == null
            ? InfoSetorValueDataModel(null)
            : state.infoSetorState.infoSetorValueDataList
                .firstWhere((element) => element.id == infoSetorValueDataId);

    return state.copyWith(
      infoSetorState: state.infoSetorState.copyWith(
        infoSetorValueDataCurrent: _infoSetorValueDataModel,
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

class SetInfoCodeInInfoSetorValueMapSyncInfoSetorAction
    extends ReduxAction<AppState> {
  final InfoCodeModel infoCodeModel;
  final bool addOrRemove;
  SetInfoCodeInInfoSetorValueMapSyncInfoSetorAction({
    this.infoCodeModel,
    this.addOrRemove,
  });
  @override
  AppState reduce() {
    InfoSetorModel _infoSetorCurrent =
        InfoSetorModel(state.infoSetorState.infoSetorCurrent.id)
            .fromMap(state.infoSetorState.infoSetorCurrent.toMap());

    if (_infoSetorCurrent.valueMap == null) {
      _infoSetorCurrent.valueMap = Map<String, InfoSetorValueModel>();
    }
    if (addOrRemove) {
      if (!_infoSetorCurrent.valueMap.containsKey(infoCodeModel.id)) {
        _infoSetorCurrent.valueMap.addAll({
          infoCodeModel.id:
              InfoSetorValueModel(infoCodeModel.id, infoCodeRef: infoCodeModel)
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
class GetDocsInfoSetorListAsyncInfoSetorAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    print('GetDocsInfoSetorListAsyncInfoSetorAction...');
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

class GetDocInfoSetorCurrentAsyncInfoSetorAction extends ReduxAction<AppState> {
  final String infoSetorId;

  GetDocInfoSetorCurrentAsyncInfoSetorAction(this.infoSetorId);
  @override
  Future<AppState> reduce() async {
    print('GetDocInfoSetorCurrentAsyncInfoSetorAction...');
    Firestore firestore = Firestore.instance;

    final collRef =
        firestore.collection(InfoSetorModel.collection).document(infoSetorId);
    final docSnap = await collRef.get();

    final InfoSetorModel _infoSetorModel =
        InfoSetorModel(docSnap.documentID).fromMap(docSnap.data);
    return state.copyWith(
      infoSetorState: state.infoSetorState.copyWith(
        infoSetorCurrent: _infoSetorModel,
      ),
    );
  }
}

class CreateDocInfoSetorCurrentAsyncInfoSetorAction
    extends ReduxAction<AppState> {
  final String uf;
  final String city;
  final String area;
  final String code;
  final String description;
  final bool public;

  CreateDocInfoSetorCurrentAsyncInfoSetorAction({
    this.uf,
    this.city,
    this.area,
    this.code,
    this.description,
    this.public,
  });
  @override
  Future<AppState> reduce() async {
    print('CreateDocInfoSetorCurrentAsyncInfoSetorAction...');
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
  void after() => dispatch(GetDocsInfoSetorListAsyncInfoSetorAction());
}

class SetDocInfoSetorSourceCurrentAsyncInfoSetorAction
    extends ReduxAction<AppState> {
  final String name;
  final String description;
  final bool arquived;

  SetDocInfoSetorSourceCurrentAsyncInfoSetorAction({
    this.name,
    this.description,
    this.arquived,
  });
  @override
  Future<AppState> reduce() async {
    print('SetDocInfoSetorSourceCurrentAsyncInfoSetorAction...');
    Firestore firestore = Firestore.instance;
    // InfoSetorModel _infoSetorModel =
    //     InfoSetorModel(state.infoSetorState.infoSetorCurrent.id)
    //         .fromMap(state.infoSetorState.infoSetorCurrent.toMap());
    // print(
    //     'SetDocInfoSetorSourceCurrentAsyncInfoSetorAction2...${_infoSetorModel.toString()}');
    InfoSetorSourceModel _infoSetorSourceModel =
        InfoSetorSourceModel(state.infoSetorState.infoSetorSourceCurrent.id)
            .fromMap(state.infoSetorState.infoSetorSourceCurrent.toMap());
    // print(
    //     'SetDocInfoSetorSourceCurrentAsyncInfoSetorAction3...${_infoSetorSourceModel.toString()}');
    if (_infoSetorSourceModel.id == null) {
      _infoSetorSourceModel.id = uuid.Uuid().v4();
      _infoSetorSourceModel.userRef = state.loggedState.userModelLogged;
    }
    _infoSetorSourceModel.name = name;
    _infoSetorSourceModel.description = description;
    _infoSetorSourceModel.updated = FieldValue.serverTimestamp();

    await firestore
        .collection(InfoSetorModel.collection)
        .document(state.infoSetorState.infoSetorCurrent.id)
        .updateData({
      'sourceMap.${_infoSetorSourceModel.id}': _infoSetorSourceModel.toMap()
    });
    return null;
  }

  @override
  Object wrapError(error) => UserException("ATENÇÃO:", cause: error);
  @override
  void after() => dispatch(GetDocInfoSetorCurrentAsyncInfoSetorAction(
      state.infoCategoryState.infoCategoryCurrent.setorRef.id));
}

class SetDocInfoSetorValueDataCurrentAsyncInfoSetorAction
    extends ReduxAction<AppState> {
  final String value;
  final String description;
  final bool arquived;

  SetDocInfoSetorValueDataCurrentAsyncInfoSetorAction({
    this.value,
    this.description,
    this.arquived,
  });
  @override
  Future<AppState> reduce() async {
    print('SetDocInfoSetorValueDataCurrentAsyncInfoSetorAction...');
    Firestore firestore = Firestore.instance;
    InfoSetorValueDataModel _infoSetorValueDataModel = InfoSetorValueDataModel(
            state.infoSetorState.infoSetorValueDataCurrent.id)
        .fromMap(state.infoSetorState.infoSetorValueDataCurrent.toMap());

    if (_infoSetorValueDataModel.id == null) {
      _infoSetorValueDataModel.id = uuid.Uuid().v4();
      _infoSetorValueDataModel.userRef = state.loggedState.userModelLogged;
    }
    _infoSetorValueDataModel.value = value;
    _infoSetorValueDataModel.description = description;
    _infoSetorValueDataModel.updated = FieldValue.serverTimestamp();
    await firestore
        .collection(InfoSetorModel.collection)
        .document(state.infoSetorState.infoSetorCurrent.id)
        .updateData({
      'valueMap.${state.infoSetorState.infoSetorValueCurrent.id}.valueDataMap.${_infoSetorValueDataModel.id}':
          _infoSetorValueDataModel.toMap()
    });
    return null;
  }

  @override
  Object wrapError(error) => UserException("ATENÇÃO:", cause: error);
  @override
  void after() => dispatch(GetDocInfoSetorCurrentAsyncInfoSetorAction(
      state.infoCategoryState.infoCategoryCurrent.setorRef.id));
}

class UpdateDocInfoSetorCurrentAsyncInfoSetorAction
    extends ReduxAction<AppState> {
  final String uf;
  final String city;
  final String area;
  final String code;
  final String description;
  final bool public;

  UpdateDocInfoSetorCurrentAsyncInfoSetorAction({
    this.uf,
    this.city,
    this.area,
    this.code,
    this.description,
    this.public,
  });
  @override
  Future<AppState> reduce() async {
    print('SetDocInfoSetorCurrentAsyncInfoSetorAction...');
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
  void after() => dispatch(GetDocsInfoSetorListAsyncInfoSetorAction());
}
