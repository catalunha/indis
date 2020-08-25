import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/actions/info_code_action.dart';
import 'package:indis/actions/info_setor_action.dart';
import 'package:indis/actions/user_action.dart';
import 'package:indis/models/info_setor_model.dart';
import 'package:indis/models/user_model.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/info_setor/info_setor_edit_ds.dart';

class ViewModel extends BaseModel<AppState> {
  String uf;
  String city;
  String area;
  String code;
  String description;
  bool public;
  Map<String, UserModel> editorsMap;
  Map<String, ValueInfo> valueMap;
  bool isCreateOrUpdate;
  Function(String, String, String, String, String, bool) onCreate;
  Function(String, String, String, String, String, bool) onUpdate;
  ViewModel();
  ViewModel.build({
    @required this.uf,
    @required this.city,
    @required this.area,
    @required this.code,
    @required this.description,
    @required this.public,
    @required this.editorsMap,
    @required this.valueMap,
    @required this.isCreateOrUpdate,
    @required this.onCreate,
    @required this.onUpdate,
  }) : super(equals: [
          uf,
          city,
          area,
          code,
          description,
          public,
          editorsMap,
          isCreateOrUpdate,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        isCreateOrUpdate: state.infoSetorState.infoSetorCurrent.id == null,
        uf: state.infoSetorState.infoSetorCurrent.uf,
        city: state.infoSetorState.infoSetorCurrent.city,
        area: state.infoSetorState.infoSetorCurrent.area,
        code: state.infoSetorState.infoSetorCurrent.code,
        description: state.infoSetorState.infoSetorCurrent.description,
        public: state.infoSetorState.infoSetorCurrent.public ?? false,
        editorsMap: state.infoSetorState.infoSetorCurrent.editorsMap,
        valueMap: state.infoSetorState.infoSetorCurrent.valueMap,
        onCreate: (String uf, String city, String area, String code,
            String description, bool public) {
          dispatch(CreateDocInfoSetorCurrentAsyncInfoSetorAction(
            uf: uf,
            city: city,
            area: area,
            code: code,
            description: description,
            public: public,
          ));
          dispatch(NavigateAction.pop());
        },
        onUpdate: (String uf, String city, String area, String code,
            String description, bool public) {
          dispatch(UpdateDocInfoSetorCurrentAsyncInfoSetorAction(
            uf: uf,
            city: city,
            area: area,
            code: code,
            description: description,
            public: public,
          ));
          dispatch(NavigateAction.pop());
        },
      );
}

class InfoSetorEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      //debug: this,
      onInit: (store) {
        store.dispatch(GetDocsUserListAsyncUserAction());
        store.dispatch(GetDocsInfoCodeListAsyncInfoCodeAction());
      },
      model: ViewModel(),
      builder: (context, viewModel) => InfoSetorEditDS(
        isCreateOrUpdate: viewModel.isCreateOrUpdate,
        uf: viewModel.uf,
        city: viewModel.city,
        area: viewModel.area,
        code: viewModel.code,
        description: viewModel.description,
        public: viewModel.public,
        editorsMap: viewModel.editorsMap,
        valueMap: viewModel.valueMap,
        onCreate: viewModel.onCreate,
        onUpdate: viewModel.onUpdate,
      ),
    );
  }
}
