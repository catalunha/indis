import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/actions/info_data_action.dart';
import 'package:indis/models/info_setor_model.dart';
import 'package:indis/routes.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/info_data/info_data_list_ds.dart';

class ViewModel extends BaseModel<AppState> {
  List<InfoSetorModel> infoDataList;
  Function(String) onEditInfoDataCurrent;
  ViewModel();
  ViewModel.build({
    @required this.infoDataList,
    @required this.onEditInfoDataCurrent,
  }) : super(equals: [
          infoDataList,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        infoDataList: state.infoDataState.infoDataList,
        onEditInfoDataCurrent: (String id) {
          dispatch(SetInfoDataCurrentSyncInfoDataAction(id));
          dispatch(NavigateAction.pushNamed(Routes.infoDataEdit));
        },
      );
}

class InfoDataList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      //debug: this,
      model: ViewModel(),
      onInit: (store) =>
          store.dispatch(GetDocsInfoDataListAsyncInfoDataAction()),
      builder: (context, viewModel) => InfoDataListDS(
        infoDataList: viewModel.infoDataList,
        onEditInfoDataCurrent: viewModel.onEditInfoDataCurrent,
      ),
    );
  }
}
