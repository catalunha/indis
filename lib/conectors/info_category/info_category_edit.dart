import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/actions/info_category_action.dart';
import 'package:indis/models/info_code_model.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/info_category/info_category_edit_ds.dart';

class ViewModel extends BaseModel<AppState> {
  String name;
  String description;
  Map<String, InfoCodeModel> infoCodeRefMap;
  bool isCreateOrUpdate;
  Function(String, String) onCreate;
  Function(String, String) onUpdate;
  Function(InfoCodeModel, bool) onSetInfoCodeInInfoCategory;

  ViewModel();
  ViewModel.build({
    @required this.description,
    @required this.name,
    @required this.isCreateOrUpdate,
    @required this.onCreate,
    @required this.onUpdate,
    @required this.infoCodeRefMap,
    @required this.onSetInfoCodeInInfoCategory,
  }) : super(equals: [
          name,
          description,
          isCreateOrUpdate,
          infoCodeRefMap,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        isCreateOrUpdate:
            state.infoCategoryState.infoCategoryCurrent.id == null,
        description: state.infoCategoryState.infoCategoryCurrent.description,
        infoCodeRefMap:
            state.infoCategoryState.infoCategoryCurrent.infoCodeRefMap,
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
        onSetInfoCodeInInfoCategory:
            (InfoCodeModel infoCodeRef, bool addOrRemove) {
          dispatch(SetInfoCodeInInfoCategorySyncInfoCategoryAction(
            infoCodeRef: infoCodeRef,
            addOrRemove: addOrRemove,
          ));
        },
      );
}

class InfoCategoryEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      builder: (context, viewModel) => InfoCategoryEditDS(
        isCreateOrUpdate: viewModel.isCreateOrUpdate,
        name: viewModel.name,
        description: viewModel.description,
        onCreate: viewModel.onCreate,
        onUpdate: viewModel.onUpdate,
        infoCodeRefMap: viewModel.infoCodeRefMap,
        onSetInfoCodeInInfoCategory: viewModel.onSetInfoCodeInInfoCategory,
      ),
    );
  }
}
