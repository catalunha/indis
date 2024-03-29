import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/actions/info_code_action.dart';
import 'package:indis/models/info_code_model.dart';
import 'package:indis/models/info_ind_owner_model.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/info_code/info_code_edit_ds.dart';

class ViewModel extends BaseModel<AppState> {
  String code;
  String description;
  String name;
  String unit;
  InfoIndOwnerModel infoIndOwnerRef;
  Map<String, InfoCodeModel> cloneMap;
  Map<String, InfoCodeModel> linkMap;
  bool arquived;
  bool isCreateOrUpdate;
  Function(String, String, String, String) onCreate;
  Function(String, String, String, String, bool) onUpdate;
  ViewModel();
  ViewModel.build({
    @required this.code,
    @required this.description,
    @required this.name,
    @required this.unit,
    @required this.cloneMap,
    @required this.linkMap,
    @required this.infoIndOwnerRef,
    @required this.arquived,
    @required this.isCreateOrUpdate,
    @required this.onCreate,
    @required this.onUpdate,
  }) : super(equals: [
          code,
          description,
          name,
          unit,
          cloneMap,
          linkMap,
          infoIndOwnerRef,
          arquived,
          isCreateOrUpdate,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        isCreateOrUpdate: state.infoCodeState.infoCodeCurrent.id == null,
        code: state.infoCodeState.infoCodeCurrent.code,
        description: state.infoCodeState.infoCodeCurrent.description,
        name: state.infoCodeState.infoCodeCurrent.name,
        unit: state.infoCodeState.infoCodeCurrent.unit,
        cloneMap: state.infoCodeState.infoCodeCurrent.cloneMap,
        linkMap: state.infoCodeState.infoCodeCurrent.linkMap,
        infoIndOwnerRef: state.infoCodeState.infoCodeCurrent.infoIndOwnerRef,
        arquived: state.infoCodeState.infoCodeCurrent?.arquived ?? false,
        onCreate: (String code, String description, String name, String unit) {
          dispatch(CreateDocInfoCodeCurrentAsyncInfoCodeAction(
            code: code,
            description: description,
            name: name,
            unit: unit,
          ));
          dispatch(NavigateAction.pop());
        },
        onUpdate: (String code, String description, String name, String unit,
            bool arquived) {
          dispatch(UpdateDocInfoCodeCurrentAsyncInfoCodeAction(
            code: code,
            description: description,
            name: name,
            unit: unit,
            arquived: arquived,
          ));
          dispatch(NavigateAction.pop());
        },
      );
}

class InfoCodeEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      //debug: this,
      model: ViewModel(),
      builder: (context, viewModel) => InfoCodeEditDS(
        isCreateOrUpdate: viewModel.isCreateOrUpdate,
        code: viewModel.code,
        description: viewModel.description,
        name: viewModel.name,
        unit: viewModel.unit,
        cloneMap: viewModel.cloneMap,
        linkMap: viewModel.linkMap,
        infoIndOwnerRef: viewModel.infoIndOwnerRef,
        arquived: viewModel.arquived,
        onCreate: viewModel.onCreate,
        onUpdate: viewModel.onUpdate,
      ),
    );
  }
}
