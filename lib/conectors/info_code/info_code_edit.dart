import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/actions/info_code_action.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/info_code/info_code_edit_ds.dart';

class ViewModel extends BaseModel<AppState> {
  String code;
  String description;
  String name;
  String unit;
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
    @required this.arquived,
    @required this.isCreateOrUpdate,
    @required this.onCreate,
    @required this.onUpdate,
  }) : super(equals: [
          code,
          description,
          name,
          unit,
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
        arquived: viewModel.arquived,
        onCreate: viewModel.onCreate,
        onUpdate: viewModel.onUpdate,
      ),
    );
  }
}
