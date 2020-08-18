import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/actions/info_code_action.dart';
import 'package:indis/actions/info_ind_owner_action.dart';
import 'package:indis/models/info_ind_owner_model.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/info_ind_owner/info_ind_owner_select_ds.dart';

class ViewModel extends BaseModel<AppState> {
  List<InfoIndOwnerModel> infoIndOwnerList;
  Function(InfoIndOwnerModel) onSetInfoIndOwnerInInfoCode;
  ViewModel();
  ViewModel.build({
    @required this.infoIndOwnerList,
    @required this.onSetInfoIndOwnerInInfoCode,
  }) : super(equals: [
          infoIndOwnerList,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        infoIndOwnerList: state.infoIndOwnerState.infoIndOwnerList,
        onSetInfoIndOwnerInInfoCode: (InfoIndOwnerModel infoIndOwnerModel) {
          dispatch(SetInfoIndOwnerInInfoCodeSyncGroupAction(
              infoIndOwnerModel: infoIndOwnerModel));
          dispatch(NavigateAction.pop());
        },
      );
}

class InfoindOwnerSelect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      onInit: (store) =>
          store.dispatch(GetDocsInfoIndOwnerListAsyncInfoIndOwnerAction()),
      builder: (context, viewModel) => InfoindOwnerSelectDS(
        infoIndOwnerList: viewModel.infoIndOwnerList,
        onSetInfoIndOwnerInInfoCode: viewModel.onSetInfoIndOwnerInInfoCode,
      ),
    );
  }
}
