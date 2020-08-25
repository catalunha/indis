import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/actions/info_setor_action.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/info_setor/info_setor_valuedata_edit_ds.dart';

class ViewModel extends BaseModel<AppState> {
  String value;
  int year;
  int month;
  String description;
  bool isCreateOrUpdate;
  Function(String, int, int, String, bool) onCreate;
  Function(String, int, int, String, bool) onUpdate;
  ViewModel();
  ViewModel.build({
    @required this.value,
    @required this.year,
    @required this.month,
    @required this.description,
    @required this.isCreateOrUpdate,
    @required this.onCreate,
    @required this.onUpdate,
  }) : super(equals: [
          value,
          year,
          month,
          description,
          isCreateOrUpdate,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        isCreateOrUpdate:
            state.infoSetorState.infoSetorValueDataCurrent.id == null,
        value: state.infoSetorState.infoSetorValueDataCurrent.value,
        year: state.infoSetorState.infoSetorValueDataCurrent.year,
        month: state.infoSetorState.infoSetorValueDataCurrent.month,
        description: state.infoSetorState.infoSetorValueDataCurrent.description,
        onCreate: (String value, int year, int month, String description,
            bool arquived) {
          dispatch(SetDocInfoSetorValueDataCurrentAsyncInfoSetorAction(
            value: value,
            year: year,
            month: month,
            description: description,
            arquived: arquived,
          ));
          dispatch(NavigateAction.pop());
        },
        onUpdate: (String value, int year, int month, String description,
            bool arquived) {
          dispatch(SetDocInfoSetorValueDataCurrentAsyncInfoSetorAction(
            value: value,
            year: year,
            month: month,
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
        year: viewModel.year,
        month: viewModel.month,
        value: viewModel.value,
        description: viewModel.description,
        onCreate: viewModel.onCreate,
        onUpdate: viewModel.onUpdate,
      ),
    );
  }
}
