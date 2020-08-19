import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/actions/info_category_action.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/info_category/info_category_edit_ds.dart';

class ViewModel extends BaseModel<AppState> {
  String name;
  String description;
  bool containItemMap;
  bool isCreateOrUpdate;
  Function(String, String) onCreate;
  Function(String, String) onUpdate;
  // Function(InfoCodeModel, bool) onSetInfoCodeInInfoCategory;

  ViewModel();
  ViewModel.build({
    @required this.name,
    @required this.description,
    @required this.containItemMap,
    @required this.isCreateOrUpdate,
    @required this.onCreate,
    @required this.onUpdate,
    // @required this.onSetInfoCodeInInfoCategory,
  }) : super(equals: [
          name,
          description,
          containItemMap,
          isCreateOrUpdate,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        isCreateOrUpdate:
            state.infoCategoryState.infoCategoryCurrent.id == null,
        description: state.infoCategoryState.infoCategoryCurrent.description,
        containItemMap:
            state.infoCategoryState.infoCategoryCurrent?.itemMap != null
                ? true
                : false,
        name: state.infoCategoryState.infoCategoryCurrent.name,
        onCreate: (String name, String description) {
          dispatch(CreateDocInfoCategoryCurrentAsyncInfoCategoryAction(
            name: name,
            description: description,
          ));
          dispatch(NavigateAction.pop());
        },
        onUpdate: (String name, String description) {
          dispatch(UpdateDocInfoCategoryCurrentAsyncInfoCategoryAction(
            name: name,
            description: description,
          ));
          dispatch(NavigateAction.pop());
        },
        // onSetInfoCodeInInfoCategory:
        //     (InfoCodeModel infoCodeRef, bool addOrRemove) {
        //   dispatch(SetInfoCodeInInfoCategorySyncInfoCategoryAction(
        //     infoCodeRef: infoCodeRef,
        //     addOrRemove: addOrRemove,
        //   ));
        // },
      );
}

class InfoCategoryEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      //debug: this,
      model: ViewModel(),
      builder: (context, viewModel) => InfoCategoryEditDS(
        isCreateOrUpdate: viewModel.isCreateOrUpdate,
        name: viewModel.name,
        description: viewModel.description,
        containItemMap: viewModel.containItemMap,
        onCreate: viewModel.onCreate,
        onUpdate: viewModel.onUpdate,
        // onSetInfoCodeInInfoCategory: viewModel.onSetInfoCodeInInfoCategory,
      ),
    );
  }
}
