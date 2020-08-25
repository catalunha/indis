import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:indis/actions/info_category_action.dart';
import 'package:indis/actions/info_setor_action.dart';
import 'package:indis/models/info_category_model.dart';
import 'package:indis/models/info_code_model.dart';
import 'package:indis/models/info_setor_model.dart';
import 'package:indis/routes.dart';
import 'package:indis/states/app_state.dart';
import 'package:indis/uis/info_category/info_category_item_tree_ds.dart';

class ViewModel extends BaseModel<AppState> {
  Map<String, InfoCategoryItem> itemMap;
  InfoCategoryModel infoCategoryModel;
  InfoSetorModel infoSetorModel;
  Function(String) onInfoSetorValueDataList;
  Function(String, bool) onEditInfoCategoryItemCurrent;
  Function(String, bool) onSetInfoCategoryItemCurrent;
  Function(InfoCodeModel) onSetInfoCodeInInfoCategoryItemSyncInfoCategoryAction;

  ViewModel();
  ViewModel.build({
    @required this.itemMap,
    @required this.infoCategoryModel,
    @required this.infoSetorModel,
    @required this.onInfoSetorValueDataList,
    @required this.onEditInfoCategoryItemCurrent,
    @required this.onSetInfoCategoryItemCurrent,
    @required this.onSetInfoCodeInInfoCategoryItemSyncInfoCategoryAction,
  }) : super(equals: [itemMap, infoSetorModel]);
  @override
  ViewModel fromStore() => ViewModel.build(
        itemMap: state.infoCategoryState.infoCategoryCurrent?.itemMap ??
            Map<String, InfoCategoryItem>(),
        infoCategoryModel: state.infoCategoryState.infoCategoryCurrent,
        infoSetorModel: state.infoSetorState.infoSetorCurrent,
        onEditInfoCategoryItemCurrent: (String id, bool isCreateOrUpdate) {
          dispatch(SetInfoCategoryItemCurrentSyncInfoCategoryAction(
              id: id, isCreateOrUpdate: isCreateOrUpdate));
          dispatch(NavigateAction.pushNamed(Routes.infoCategoryItemEdit));
        },
        onSetInfoCategoryItemCurrent: (String id, bool isCreateOrUpdate) {
          dispatch(SetInfoCategoryItemCurrentSyncInfoCategoryAction(
              id: id, isCreateOrUpdate: isCreateOrUpdate));
        },
        onSetInfoCodeInInfoCategoryItemSyncInfoCategoryAction:
            (InfoCodeModel infoCodeRef) {
          dispatch(SetInfoCodeInInfoCategoryItemSyncInfoCategoryAction(
            infoCodeRef: infoCodeRef,
            addOrRemove: false,
          ));
        },
        onInfoSetorValueDataList: (String infoSetorValueId) {
          dispatch(
              SetInfoSetorValueCurrentSyncInfoSetorAction(infoSetorValueId));
          dispatch(NavigateAction.pushNamed(Routes.infoSetorValueDataList));
        },
      );
}

class InfoCategoryItemTree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (context, viewModel) => InfoCategoryItemTreeDS(
        itemMap: viewModel.itemMap,
        infoCategoryModel: viewModel.infoCategoryModel,
        infoSetorModel: viewModel.infoSetorModel,
        onEditInfoCategoryItemCurrent: viewModel.onEditInfoCategoryItemCurrent,
        onInfoSetorValueDataList: viewModel.onInfoSetorValueDataList,
        onSetInfoCategoryItemCurrent: viewModel.onSetInfoCategoryItemCurrent,
        onSetInfoCodeInInfoCategoryItemSyncInfoCategoryAction:
            viewModel.onSetInfoCodeInInfoCategoryItemSyncInfoCategoryAction,
      ),
    );
  }
}
