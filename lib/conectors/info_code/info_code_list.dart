import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/actions/info_code_action.dart';
import 'package:indis/models/info_code_model.dart';
import 'package:indis/routes.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/info_code/info_code_list_ds.dart';
import 'package:indis/uis/info_ind_owner/info_ind_owner_list_ds.dart';

class ViewModel extends BaseModel<AppState> {
  List<InfoCodeModel> infoCodeList;
  Function(String) onEditInfoCodeCurrent;
  ViewModel();
  ViewModel.build({
    @required this.infoCodeList,
    @required this.onEditInfoCodeCurrent,
  }) : super(equals: [
          infoCodeList,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        infoCodeList: state.infoCodeState.infoCodeList,
        onEditInfoCodeCurrent: (String id) {
          dispatch(SetInfoCodeCurrentSyncInfoCodeAction(id));
          dispatch(NavigateAction.pushNamed(Routes.infoCodeEdit));
        },
      );
}

class InfoCodeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      onInit: (store) =>
          store.dispatch(GetDocsInfoCodeListAsyncInfoCodeAction()),
      builder: (context, viewModel) => InfoCodeListDS(
        infoCodeList: viewModel.infoCodeList,
        onEditInfoCodeCurrent: viewModel.onEditInfoCodeCurrent,
      ),
    );
  }
}
