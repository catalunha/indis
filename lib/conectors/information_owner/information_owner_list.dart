import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/actions/information_owner_action.dart';
import 'package:indis/models/information_owner_model.dart';
import 'package:indis/routes.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/information_owner/information_owner_list_ds.dart';

class ViewModel extends BaseModel<AppState> {
  List<InformationOwnerModel> informationOwnerList;
  Function(String) onEditInformationOwnerCurrent;
  ViewModel();
  ViewModel.build({
    @required this.informationOwnerList,
    @required this.onEditInformationOwnerCurrent,
  }) : super(equals: [
          informationOwnerList,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        informationOwnerList: state.informationOwnerState.informationOwnerList,
        onEditInformationOwnerCurrent: (String id) {
          dispatch(SetInformationOwnerCurrentSyncInformationOwnerAction(id));
          dispatch(NavigateAction.pushNamed(Routes.ownerEdit));
        },
      );
}

class InformationOwnerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      onInit: (store) => store
          .dispatch(GetDocsInformationOwnerListAsyncInformationOwnerAction()),
      builder: (context, viewModel) => InformationOwnerListDS(
        informationOwnerList: viewModel.informationOwnerList,
        onEditInformationOwnerCurrent: viewModel.onEditInformationOwnerCurrent,
      ),
    );
  }
}
