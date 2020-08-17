import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/actions/info_category_action.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/info_category/info_category_data_edit_ds.dart';

class ViewModel extends BaseModel<AppState> {
  String name;
  String description;
  bool isCreateOrUpdate;
  Function(String, String) onCreate;
  Function(String, String, bool) onUpdate;
  // Function(InfoCodeModel, bool) onSetInfoCodeInInfoCategory;

  ViewModel();
  ViewModel.build({
    @required this.name,
    @required this.description,
    @required this.isCreateOrUpdate,
    @required this.onCreate,
    @required this.onUpdate,
    // @required this.onSetInfoCodeInInfoCategory,
  }) : super(equals: [
          name,
          description,
          isCreateOrUpdate,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        isCreateOrUpdate:
            state.infoCategoryState.infoCategoryDataCurrent.id == null,
        name: state.infoCategoryState.infoCategoryDataCurrent.name,
        description:
            state.infoCategoryState.infoCategoryDataCurrent.description,
        onCreate: (String name, String description) {
          dispatch(CreateInfoCategoryDataCurrentSyncInfoCategoryAction(
            name: name,
            description: description,
          ));
          dispatch(NavigateAction.pop());
        },
        onUpdate: (String name, String description, bool remover) {
          dispatch(UpdateInfoCategoryDataCurrentSyncInfoCategoryAction(
            name: name,
            description: description,
            remover: remover,
          ));
          dispatch(NavigateAction.pop());
        },
      );
}

class InfoCategoryDataEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      //debug: this,
      model: ViewModel(),
      builder: (context, viewModel) => InfoCategoryDataEditDS(
        isCreateOrUpdate: viewModel.isCreateOrUpdate,
        name: viewModel.name,
        description: viewModel.description,
        onCreate: viewModel.onCreate,
        onUpdate: viewModel.onUpdate,
        // onSetInfoCodeInInfoCategory: viewModel.onSetInfoCodeInInfoCategory,
      ),
    );
  }
}
