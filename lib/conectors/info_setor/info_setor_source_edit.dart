import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/actions/info_code_action.dart';
import 'package:indis/actions/info_setor_action.dart';
import 'package:indis/actions/user_action.dart';
import 'package:indis/models/info_setor_model.dart';
import 'package:indis/models/user_model.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/info_setor/info_setor_edit_ds.dart';
import 'package:indis/uis/info_setor/info_setor_source_edit_ds.dart';

class ViewModel extends BaseModel<AppState> {
  String name;
  String description;
  bool isCreateOrUpdate;
  Function(String, String, bool) onCreate;
  Function(String, String, bool) onUpdate;
  ViewModel();
  ViewModel.build({
    @required this.name,
    @required this.description,
    @required this.isCreateOrUpdate,
    @required this.onCreate,
    @required this.onUpdate,
  }) : super(equals: [
          name,
          description,
          isCreateOrUpdate,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        isCreateOrUpdate:
            state.infoSetorState.infoSetorSourceCurrent.id == null,
        name: state.infoSetorState.infoSetorSourceCurrent.name,
        description: state.infoSetorState.infoSetorSourceCurrent.description,
        onCreate: (String name, String description, bool arquived) {
          dispatch(SetDocInfoSetorSourceCurrentAsyncInfoSetorAction(
            name: name,
            description: description,
            arquived: arquived,
          ));
          dispatch(NavigateAction.pop());
        },
        onUpdate: (String name, String description, bool arquived) {
          dispatch(SetDocInfoSetorSourceCurrentAsyncInfoSetorAction(
            name: name,
            description: description,
            arquived: arquived,
          ));
          dispatch(NavigateAction.pop());
        },
      );
}

class InfoSetorSourceEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      //debug: this,
      model: ViewModel(),
      builder: (context, viewModel) => InfoSetorSourceEditDS(
        isCreateOrUpdate: viewModel.isCreateOrUpdate,
        name: viewModel.name,
        description: viewModel.description,
        onCreate: viewModel.onCreate,
        onUpdate: viewModel.onUpdate,
      ),
    );
  }
}
