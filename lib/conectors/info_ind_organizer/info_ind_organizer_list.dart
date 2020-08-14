import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/actions/info_ind_organizer_action.dart';
import 'package:indis/actions/info_ind_owner_action.dart';
import 'package:indis/models/info_ind_organizer_model.dart';
import 'package:indis/routes.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/info_ind_organizer/info_ind_organizer_list_ds.dart';

class ViewModel extends BaseModel<AppState> {
  List<InfoIndOrganizerModel> infoIndOrganizerList;
  Function(String) onEditInfoIndOrganizerCurrent;
  ViewModel();
  ViewModel.build({
    @required this.infoIndOrganizerList,
    @required this.onEditInfoIndOrganizerCurrent,
  }) : super(equals: [
          infoIndOrganizerList,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        infoIndOrganizerList: state.infoIndOrganizerState.infoIndOrganizerList,
        onEditInfoIndOrganizerCurrent: (String id) {
          dispatch(SetInfoIndOrganizerCurrentSyncInfoIndOrganizerAction(id));
          dispatch(NavigateAction.pushNamed(Routes.infoIndOrganizerEdit));
        },
      );
}

class InfoIndOrganizerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      onInit: (store) => store
          .dispatch(GetDocsInfoIndOrganizerListAsyncInfoIndOrganizerAction()),
      builder: (context, viewModel) => InfoIndOrganizerListDS(
        infoIndOrganizerList: viewModel.infoIndOrganizerList,
        onEditInfoIndOrganizerCurrent: viewModel.onEditInfoIndOrganizerCurrent,
      ),
    );
  }
}
