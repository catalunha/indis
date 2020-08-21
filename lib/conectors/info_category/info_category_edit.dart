import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/actions/info_category_action.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/info_category/info_category_edit_ds.dart';

class ViewModel extends BaseModel<AppState> {
  String name;
  String description;
  bool public;
  bool containItemMap;
  bool isCreateOrUpdate;
  Function(String, String, bool) onCreate;
  Function(String, String, bool) onUpdate;
  // Function(InfoCodeModel, bool) onSetInfoCodeInInfoCategory;

  ViewModel();
  ViewModel.build({
    @required this.name,
    @required this.description,
    @required this.public,
    @required this.containItemMap,
    @required this.isCreateOrUpdate,
    @required this.onCreate,
    @required this.onUpdate,
    // @required this.onSetInfoCodeInInfoCategory,
  }) : super(equals: [
          name,
          description,
          public,
          containItemMap,
          isCreateOrUpdate,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        isCreateOrUpdate:
            state.infoCategoryState.infoCategoryCurrent.id == null,
        name: state.infoCategoryState.infoCategoryCurrent.name,
        description: state.infoCategoryState.infoCategoryCurrent.description,
        public: state.infoCategoryState.infoCategoryCurrent.public,
        containItemMap:
            state.infoCategoryState.infoCategoryCurrent?.itemMap != null
                ? true
                : false,
        onCreate: (String name, String description, bool public) {
          dispatch(CreateDocInfoCategoryCurrentAsyncInfoCategoryAction(
            name: name,
            description: description,
            public: public,
          ));
          dispatch(NavigateAction.pop());
        },
        onUpdate: (String name, String description, bool public) {
          dispatch(UpdateDocInfoCategoryCurrentAsyncInfoCategoryAction(
            name: name,
            description: description,
            public: public,
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
        public: viewModel.public,
        containItemMap: viewModel.containItemMap,
        onCreate: viewModel.onCreate,
        onUpdate: viewModel.onUpdate,
        // onSetInfoCodeInInfoCategory: viewModel.onSetInfoCodeInInfoCategory,
      ),
    );
  }
}
