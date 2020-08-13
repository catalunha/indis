import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/actions/info_ind_owner_action.dart';
import 'package:indis/models/info_ind_owner_model.dart';
import 'package:indis/routes.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/info_ind_owner/info_ind_owner_list_ds.dart';

class ViewModel extends BaseModel<AppState> {
  List<InfoIndOwnerModel> infoIndOwnerList;
  Function(String) onEditInfoIndOwnerCurrent;
  ViewModel();
  ViewModel.build({
    @required this.infoIndOwnerList,
    @required this.onEditInfoIndOwnerCurrent,
  }) : super(equals: [
          infoIndOwnerList,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        infoIndOwnerList: state.infoIndOwnerState.infoIndOwnerList,
        onEditInfoIndOwnerCurrent: (String id) {
          dispatch(SetInfoIndOwnerCurrentSyncInfoIndOwnerAction(id));
          dispatch(NavigateAction.pushNamed(Routes.ownerEdit));
        },
      );
}

class InfoIndOwnerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      onInit: (store) =>
          store.dispatch(GetDocsInfoIndOwnerListAsyncInfoIndOwnerAction()),
      builder: (context, viewModel) => InfoIndOwnerListDS(
        infoIndOwnerList: viewModel.infoIndOwnerList,
        onEditInfoIndOwnerCurrent: viewModel.onEditInfoIndOwnerCurrent,
      ),
    );
  }
}
