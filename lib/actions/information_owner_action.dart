import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:indis/models/information_owner_model.dart';
import 'package:indis/states/app_state.dart';

// +++ Actions Sync
class SetInformationOwnerCurrentSyncInformationOwnerAction
    extends ReduxAction<AppState> {
  final String id;

  SetInformationOwnerCurrentSyncInformationOwnerAction(this.id);

  @override
  AppState reduce() {
    InformationOwnerModel moduleModel = id == null
        ? InformationOwnerModel(null)
        : state.informationOwnerState.informationOwnerList
            .firstWhere((element) => element.id == id);
    return state.copyWith(
      informationOwnerState: state.informationOwnerState.copyWith(
        informationOwnerCurrent: moduleModel,
      ),
    );
  }
}

// +++ Actions Async
class GetDocsInformationOwnerListAsyncInformationOwnerAction
    extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    print('GetDocsInformationOwnerListAsyncInformationOwnerAction...');
    Firestore firestore = Firestore.instance;

    final collRef = firestore.collection(InformationOwnerModel.collection);
    final docsSnap = await collRef.getDocuments();

    final listDocs = docsSnap.documents
        .map((docSnap) =>
            InformationOwnerModel(docSnap.documentID).fromMap(docSnap.data))
        .toList();
    return state.copyWith(
      informationOwnerState: state.informationOwnerState.copyWith(
        informationOwnerList: listDocs,
      ),
    );
  }
}

class CreateDocInformationOwnerCurrentAsyncInformationOwnerAction
    extends ReduxAction<AppState> {
  final String code;
  final String name;
  final String description;

  CreateDocInformationOwnerCurrentAsyncInformationOwnerAction({
    this.code,
    this.name,
    this.description,
  });
  @override
  Future<AppState> reduce() async {
    print('SetDocInformationOwnerCurrentAsyncInformationOwnerAction...');
    Firestore firestore = Firestore.instance;
    InformationOwnerModel informationOwnerModel = InformationOwnerModel(
            state.informationOwnerState.informationOwnerCurrent.id)
        .fromMap(state.informationOwnerState.informationOwnerCurrent.toMap());
    informationOwnerModel.code = code;
    informationOwnerModel.name = name;
    informationOwnerModel.description = description;
    informationOwnerModel.arquived = false;
    var docRef = await firestore
        .collection(InformationOwnerModel.collection)
        .where('code', isEqualTo: code)
        .getDocuments();
    bool doc = docRef.documents.length != 0;
    if (doc)
      throw const UserException(
          "Esta proprietário de informações e indicadores já foi cadastrado.");
    await firestore
        .collection(InformationOwnerModel.collection)
        .document(informationOwnerModel.id)
        .setData(informationOwnerModel.toMap(), merge: true);
    return state.copyWith(
      informationOwnerState: state.informationOwnerState.copyWith(
        informationOwnerCurrent: informationOwnerModel,
      ),
    );
  }

  @override
  Object wrapError(error) => UserException("ATENÇÃO:", cause: error);
  @override
  void after() =>
      dispatch(GetDocsInformationOwnerListAsyncInformationOwnerAction());
}

class UpdateDocInformationOwnerCurrentAsyncInformationOwnerAction
    extends ReduxAction<AppState> {
  final String code;
  final String name;
  final String description;
  final bool arquived;

  UpdateDocInformationOwnerCurrentAsyncInformationOwnerAction({
    this.code,
    this.name,
    this.description,
    this.arquived,
  });
  @override
  Future<AppState> reduce() async {
    print('SetDocInformationOwnerCurrentAsyncInformationOwnerAction...');
    Firestore firestore = Firestore.instance;
    InformationOwnerModel informationOwnerModel = InformationOwnerModel(
            state.informationOwnerState.informationOwnerCurrent.id)
        .fromMap(state.informationOwnerState.informationOwnerCurrent.toMap());
    informationOwnerModel.code = code;
    informationOwnerModel.name = name;
    informationOwnerModel.description = description;
    informationOwnerModel.arquived = arquived;
    await firestore
        .collection(InformationOwnerModel.collection)
        .document(informationOwnerModel.id)
        .updateData(informationOwnerModel.toMap());
    return state.copyWith(
      informationOwnerState: state.informationOwnerState.copyWith(
        informationOwnerCurrent: informationOwnerModel,
      ),
    );
  }

  @override
  void after() =>
      dispatch(GetDocsInformationOwnerListAsyncInformationOwnerAction());
}
