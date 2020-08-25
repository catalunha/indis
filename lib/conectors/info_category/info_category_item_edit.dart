import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/actions/info_category_action.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/info_category/info_category_item_edit_ds.dart';

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
            state.infoCategoryState.infoCategoryItemCurrent.id == null,
        name: state.infoCategoryState.infoCategoryItemCurrent.name,
        description:
            state.infoCategoryState.infoCategoryItemCurrent.description,
        onCreate: (String name, String description) {
          dispatch(CreateInfoCategoryItemCurrentSyncInfoCategoryAction(
            name: name,
            description: description,
          ));
          dispatch(NavigateAction.pop());
        },
        onUpdate: (String name, String description, bool remover) {
          dispatch(UpdateInfoCategoryItemCurrentSyncInfoCategoryAction(
            name: name,
            description: description,
            remover: remover,
          ));
          dispatch(NavigateAction.pop());
        },
      );
}

class InfoCategoryItemEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      //debug: this,
      model: ViewModel(),
      builder: (context, viewModel) => InfoCategoryItemEditDS(
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
