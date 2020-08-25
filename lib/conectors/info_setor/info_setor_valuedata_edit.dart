import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/actions/info_setor_action.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/info_setor/info_setor_valuedata_edit_ds.dart';

class ViewModel extends BaseModel<AppState> {
  String value;
  String description;
  bool isCreateOrUpdate;
  Function(String, String, bool) onCreate;
  Function(String, String, bool) onUpdate;
  ViewModel();
  ViewModel.build({
    @required this.value,
    @required this.description,
    @required this.isCreateOrUpdate,
    @required this.onCreate,
    @required this.onUpdate,
  }) : super(equals: [
          value,
          description,
          isCreateOrUpdate,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        isCreateOrUpdate:
            state.infoSetorState.infoSetorValueDataCurrent.id == null,
        value: state.infoSetorState.infoSetorValueDataCurrent.value,
        description: state.infoSetorState.infoSetorValueDataCurrent.description,
        onCreate: (String value, String description, bool arquived) {
          dispatch(SetDocInfoSetorValueDataCurrentAsyncInfoSetorAction(
            value: value,
            description: description,
            arquived: arquived,
          ));
          dispatch(NavigateAction.pop());
        },
        onUpdate: (String value, String description, bool arquived) {
          dispatch(SetDocInfoSetorValueDataCurrentAsyncInfoSetorAction(
            value: value,
            description: description,
            arquived: arquived,
          ));
          dispatch(NavigateAction.pop());
        },
      );
}

class InfoSetorValueDataEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      //debug: this,
      model: ViewModel(),
      builder: (context, viewModel) => InfoSetorValueDataEditDS(
        isCreateOrUpdate: viewModel.isCreateOrUpdate,
        value: viewModel.value,
        description: viewModel.description,
        onCreate: viewModel.onCreate,
        onUpdate: viewModel.onUpdate,
      ),
    );
  }
}
