import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/actions/info_ind_organizer_action.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/info_ind_organizer/info_ind_organizer_edit_ds.dart';

class ViewModel extends BaseModel<AppState> {
  String description;
  String name;
  bool isCreateOrUpdate;
  Function(String, String) onCreate;
  Function(String, String) onUpdate;
  ViewModel();
  ViewModel.build({
    @required this.description,
    @required this.name,
    @required this.isCreateOrUpdate,
    @required this.onCreate,
    @required this.onUpdate,
  }) : super(equals: [
          description,
          name,
          isCreateOrUpdate,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        isCreateOrUpdate:
            state.infoIndOrganizerState.infoIndOrganizerCurrent.id == null,
        description:
            state.infoIndOrganizerState.infoIndOrganizerCurrent.description,
        name: state.infoIndOrganizerState.infoIndOrganizerCurrent.name,
        onCreate: (String name, String description) {
          dispatch(CreateDocInfoIndOrganizerCurrentAsyncInfoIndOrganizerAction(
            description: description,
            name: name,
          ));
          dispatch(NavigateAction.pop());
        },
        onUpdate: (String name, String description) {
          dispatch(UpdateDocInfoIndOrganizerCurrentAsyncInfoIndOrganizerAction(
            description: description,
            name: name,
          ));
          dispatch(NavigateAction.pop());
        },
      );
}

class InfoIndOrganizerEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      //debug: this,
      model: ViewModel(),
      builder: (context, viewModel) => InfoIndOrganizerEditDS(
        isCreateOrUpdate: viewModel.isCreateOrUpdate,
        description: viewModel.description,
        name: viewModel.name,
        onCreate: viewModel.onCreate,
        onUpdate: viewModel.onUpdate,
      ),
    );
  }
}
