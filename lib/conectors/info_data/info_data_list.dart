import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/actions/info_data_action.dart';
import 'package:indis/models/info_setor_model.dart';
import 'package:indis/routes.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/info_data/info_data_list_ds.dart';

class ViewModel extends BaseModel<AppState> {
  List<InfoSetorModel> infoSetorList;
  Function(String) onEditInfoSetorCurrent;
  ViewModel();
  ViewModel.build({
    @required this.infoSetorList,
    @required this.onEditInfoSetorCurrent,
  }) : super(equals: [
          infoSetorList,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        infoSetorList: state.infoSetorState.infoSetorList,
        onEditInfoSetorCurrent: (String id) {
          dispatch(SetInfoDataCurrentSyncInfoSetorAction(id));
          dispatch(NavigateAction.pushNamed(Routes.infoSetorEdit));
        },
      );
}

class InfoSetorList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      //debug: this,
      model: ViewModel(),
      onInit: (store) =>
          store.dispatch(GetDocsInfoDataListAsyncInfoSetorAction()),
      builder: (context, viewModel) => InfoSetorListDS(
        infoSetorList: viewModel.infoSetorList,
        onEditInfoSetorCurrent: viewModel.onEditInfoSetorCurrent,
      ),
    );
  }
}
