import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/actions/info_setor_action.dart';
import 'package:indis/models/info_setor_model.dart';
import 'package:indis/routes.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/info_setor/info_setor_source_list_ds.dart';

class ViewModel extends BaseModel<AppState> {
  List<InfoSetorSourceModel> sourceMap;
  Function(String) onEditInfoSetorSourceCurrent;
  ViewModel();
  ViewModel.build({
    @required this.sourceMap,
    @required this.onEditInfoSetorSourceCurrent,
  }) : super(equals: [
          sourceMap,
        ]);
  _sourceMap() {
    List<InfoSetorSourceModel> _sourceMap = [];
    if (state.infoSetorState.infoSetorCurrent?.sourceMap != null) {
      _sourceMap =
          state.infoSetorState.infoSetorCurrent.sourceMap.values.toList();
    }
    return _sourceMap;
  }

  @override
  ViewModel fromStore() => ViewModel.build(
        sourceMap: _sourceMap(),
        onEditInfoSetorSourceCurrent: (String id) {
          dispatch(SetInfoSetorSourceCurrentSyncInfoSetorAction(id));
          dispatch(NavigateAction.pushNamed(Routes.infoSetorSourceEdit));
        },
      );
}

class InfoSetorSourceList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      //debug: this,
      model: ViewModel(),
      builder: (context, viewModel) => InfoSetorSourceListDS(
        sourceMap: viewModel.sourceMap,
        onEditInfoSetorSourceCurrent: viewModel.onEditInfoSetorSourceCurrent,
      ),
    );
  }
}
