import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/actions/info_category_action.dart';
import 'package:indis/models/info_category_model.dart';
import 'package:indis/models/info_code_model.dart';
import 'package:indis/routes.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/info_category/info_category_tree_ds.dart';

class ViewModel extends BaseModel<AppState> {
  Map<String, InfoCategoryItem> itemMap;
  Function(String, bool) onEditInfoCategoryDataCurrent;
  Function(String, bool) onSetInfoCategoryDataCurrent;
  Function(InfoCodeModel) onSetInfoCodeInInfoCategoryDataSyncInfoCategoryAction;

  ViewModel();
  ViewModel.build({
    @required this.itemMap,
    @required this.onEditInfoCategoryDataCurrent,
    @required this.onSetInfoCategoryDataCurrent,
    @required this.onSetInfoCodeInInfoCategoryDataSyncInfoCategoryAction,
  }) : super(equals: [itemMap]);
  @override
  ViewModel fromStore() => ViewModel.build(
        itemMap: state.infoCategoryState.infoCategoryCurrent?.itemMap ??
            Map<String, InfoCategoryItem>(),
        onEditInfoCategoryDataCurrent: (String id, bool isCreateOrUpdate) {
          dispatch(SetInfoCategoryItemCurrentSyncInfoCategoryAction(
              id: id, isCreateOrUpdate: isCreateOrUpdate));
          dispatch(NavigateAction.pushNamed(Routes.infoCategoryDataEdit));
        },
        onSetInfoCategoryDataCurrent: (String id, bool isCreateOrUpdate) {
          dispatch(SetInfoCategoryItemCurrentSyncInfoCategoryAction(
              id: id, isCreateOrUpdate: isCreateOrUpdate));
        },
        onSetInfoCodeInInfoCategoryDataSyncInfoCategoryAction:
            (InfoCodeModel infoCodeRef) {
          dispatch(SetInfoCodeInInfoCategoryItemSyncInfoCategoryAction(
            infoCodeRef: infoCodeRef,
            addOrRemove: false,
          ));
        },
      );
}

class InfoCategoryDataTree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (context, viewModel) => InfoCategoryDataTreeDS(
        itemMap: viewModel.itemMap,
        onEditInfoCategoryDataCurrent: viewModel.onEditInfoCategoryDataCurrent,
        onSetInfoCategoryDataCurrent: viewModel.onSetInfoCategoryDataCurrent,
        onSetInfoCodeInInfoCategoryDataSyncInfoCategoryAction:
            viewModel.onSetInfoCodeInInfoCategoryDataSyncInfoCategoryAction,
      ),
    );
  }
}
