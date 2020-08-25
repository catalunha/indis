import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/actions/info_setor_action.dart';
import 'package:indis/models/info_setor_model.dart';
import 'package:indis/routes.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/info_setor/info_setor_valuedata_list_ds.dart';

class ViewModel extends BaseModel<AppState> {
  List<InfoSetorValueDataModel> valueDataList;
  Function(String) onEditInfoSetorValueDataCurrent;
  ViewModel();
  ViewModel.build({
    @required this.valueDataList,
    @required this.onEditInfoSetorValueDataCurrent,
  }) : super(equals: [
          valueDataList,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        valueDataList: state.infoSetorState.infoSetorValueDataList,
        onEditInfoSetorValueDataCurrent: (String id) {
          dispatch(SetInfoSetorValueDataCurrentSyncInfoSetorAction(id));
          // dispatch(NavigateAction.pushNamed(Routes.infoSetorValueDataEdit));
        },
      );
}

class InfoSetorValueDataList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      //debug: this,
      model: ViewModel(),
      builder: (context, viewModel) => InfoSetorValueDataListDS(
        valueDataList: viewModel.valueDataList,
        onEditInfoSetorValueDataCurrent:
            viewModel.onEditInfoSetorValueDataCurrent,
      ),
    );
  }
}
