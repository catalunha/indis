import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/actions/info_ind_owner_action.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/info_ind_owner/info_ind_owner_edit_ds.dart';

class ViewModel extends BaseModel<AppState> {
  String code;
  String description;
  String name;
  bool arquived;
  bool isCreateOrUpdate;
  Function(String, String, String) onCreate;
  Function(String, String, String, bool) onUpdate;
  ViewModel();
  ViewModel.build({
    @required this.code,
    @required this.description,
    @required this.name,
    @required this.arquived,
    @required this.isCreateOrUpdate,
    @required this.onCreate,
    @required this.onUpdate,
  }) : super(equals: [
          code,
          description,
          name,
          arquived,
          isCreateOrUpdate,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        isCreateOrUpdate:
            state.infoIndOwnerState.infoIndOwnerCurrent.id == null,
        code: state.infoIndOwnerState.infoIndOwnerCurrent.code,
        description: state.infoIndOwnerState.infoIndOwnerCurrent.description,
        name: state.infoIndOwnerState.infoIndOwnerCurrent.name,
        arquived:
            state.infoIndOwnerState.infoIndOwnerCurrent?.arquived ?? false,
        onCreate: (String code, String description, String name) {
          dispatch(CreateDocInfoIndOwnerCurrentAsyncInfoIndOwnerAction(
            code: code,
            description: description,
            name: name,
          ));
          dispatch(NavigateAction.pop());
        },
        onUpdate:
            (String code, String description, String name, bool arquived) {
          dispatch(UpdateDocInfoIndOwnerCurrentAsyncInfoIndOwnerAction(
            code: code,
            description: description,
            name: name,
            arquived: arquived,
          ));
          dispatch(NavigateAction.pop());
        },
      );
}

class InfoIndOwnerEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      //debug: this,
      model: ViewModel(),
      builder: (context, viewModel) => InfoIndOwnerEditDS(
        isCreateOrUpdate: viewModel.isCreateOrUpdate,
        code: viewModel.code,
        description: viewModel.description,
        name: viewModel.name,
        arquived: viewModel.arquived,
        onCreate: viewModel.onCreate,
        onUpdate: viewModel.onUpdate,
      ),
    );
  }
}
